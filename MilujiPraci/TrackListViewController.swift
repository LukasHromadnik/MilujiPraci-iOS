//
//  ViewController.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 27/02/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit
import SnapKit

private enum Constants {
    static let numberOfColumns: CGFloat = 3
    static let minimumInteritemSpacing: CGFloat = 10
    static let headerHeight = 30

    static func itemWidth(fitting width: CGFloat) -> Double {
        floor(Double((width - (numberOfColumns + 1) * minimumInteritemSpacing) / numberOfColumns))
    }
}

final class TrackListViewController: UIViewController {
    private weak var collectionView: UICollectionView!
    private weak var toolbar: UIToolbar!
    private weak var progressView: UIProgressView!

    private let viewModel: TrackListViewModeling

    // MARK: - Initialization

    init(viewModel: TrackListViewModeling) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Controller lifecycle

    override func loadView() {
        super.loadView()

        view.backgroundColor = .systemBackground

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        layout.headerReferenceSize = CGSize(width: 0, height: Constants.headerHeight)
        layout.sectionInset = UIEdgeInsets(size: layout.minimumInteritemSpacing)

        let itemWidth = Constants.itemWidth(fitting: view.bounds.width)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView = collectionView

        let toolbar = UIToolbar()
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        self.toolbar = toolbar

        let progressView = UIProgressView(progressViewStyle: .bar)
        toolbar.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        self.progressView = progressView

        updateToolbar(isPlaying: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Miluji svoji práci"

        collectionView.dataSource = self
        collectionView.delegate = self

        viewModel.onFinish = { [weak self] in self?.updateToolbar(isPlaying: false) }
        viewModel.onDurationChange = { [weak self] in self?.progressView.progress = Float($0) }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: toolbar.bounds.size.height, right: 0)
        collectionView.contentInset = insets
        collectionView.scrollIndicatorInsets = insets
    }

    // MARK: - Actions

    @objc
    private func pauseButtonTapped(_ sender: UIBarButtonItem) {
        updateToolbar(isPlaying: false)
        viewModel.pause()
    }

    @objc
    private func playButtonTapped(_ sender: UIBarButtonItem) {
        updateToolbar(isPlaying: true)
        viewModel.play()
    }

    @objc
    private func stopButtonTapped(_ sender: UIBarButtonItem) {
        updateToolbar(isPlaying: false)
        viewModel.stop()
    }

    // MARK: - Helpers

    private func updateToolbar(isPlaying: Bool) {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.trackTitle ?? "Nic nevybráno"

        // swiftlint:disable force_unwrapping
        let pauseButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill")!, style: .plain, target: self, action: #selector(pauseButtonTapped))
        let playButton = UIBarButtonItem(image: UIImage(systemName: "play.fill")!, style: .plain, target: self, action: #selector(playButtonTapped))
        let stopButton = UIBarButtonItem(image: UIImage(systemName: "stop.fill")!, style: .plain, target: self, action: #selector(stopButtonTapped))
        // swiftlint:enable force_unwrapping
        let titleLabelItem = UIBarButtonItem(customView: titleLabel)

        playButton.isEnabled = viewModel.isTrackSelected
        pauseButton.isEnabled = viewModel.isTrackSelected
        stopButton.isEnabled = viewModel.isTrackSelected

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        var items: [UIBarButtonItem] = [titleLabelItem, flexibleSpace, stopButton]
        let itemToAppend: UIBarButtonItem = isPlaying ? pauseButton : playButton
        items.append(itemToAppend)
        toolbar.setItems(items, animated: false)
    }
}

extension TrackListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.item(for: indexPath)

        let cell: TrackCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.backgroundColor = viewModel.backgroundColor(for: indexPath)
        cell.title = item.title

        return cell
    }
}

extension TrackListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectTrack(at: indexPath)
        viewModel.play()
        updateToolbar(isPlaying: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { assertionFailure(); return UICollectionReusableView() }

        let header: CollectionViewSectionHeader = collectionView.dequeueHeader(for: indexPath)
        header.title = viewModel.sectionTitle(at: indexPath)

        return header
    }
}
