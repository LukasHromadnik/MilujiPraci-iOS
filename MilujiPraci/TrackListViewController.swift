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

    static func itemWidth(fitting width: CGFloat) -> CGFloat {
        return (width - (numberOfColumns + 1) * minimumInteritemSpacing) / numberOfColumns
    }
}

final class TrackListViewController: UIViewController {

    private weak var collectionView: UICollectionView!

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

        view.backgroundColor = .white

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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Miluji svoji práci"

        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension TrackListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.item(for: indexPath)

        let cell: TrackCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.backgroundColor = item.type.backgroundColor
        cell.title = item.title

        return cell
    }

}

extension TrackListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.playTrack(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        let header: CollectionViewSectionHeader = collectionView.dequeueHeader(for: indexPath)
        header.title = viewModel.sections[indexPath.section].title

        return header
    }

}
