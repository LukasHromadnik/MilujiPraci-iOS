//
//  ViewController.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 27/02/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit
import SnapKit

protocol TrackListViewControllerDelegate: class {
    func didSelectTrack(_ track: Track)
}

final class TrackListViewController: UIViewController {
    
    let numberOfColumns: CGFloat = 3
    weak var delegate: TrackListViewControllerDelegate?
    
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
        layout.minimumInteritemSpacing = 10
        
        let itemWidth = (view.bounds.width - (numberOfColumns + 1) * layout.minimumInteritemSpacing) / numberOfColumns
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(
            top: layout.minimumInteritemSpacing,
            left: layout.minimumInteritemSpacing,
            bottom: 0,
            right: layout.minimumInteritemSpacing
        )
        
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: TrackCollectionViewCell.reuseIdentifier)
    }

}

extension TrackListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.item(for: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionViewCell.reuseIdentifier, for: indexPath) as! TrackCollectionViewCell
        cell.backgroundColor = item.type.backgroundColor
        cell.title = item.title
        
        return cell
    }
    
}

extension TrackListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTrack(viewModel.item(for: indexPath))
    }
    
}
