//
//  TracksViewController.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

protocol TracksViewModeling {
    var viewModels: [TrackListViewModeling] { get }
}

extension TracksViewModeling {
    
    func numberOfLists() -> Int {
        return viewModels.count
    }
    
}

final class TracksViewModel: TracksViewModeling {
    let viewModels: [TrackListViewModeling] = [BasicTrackListViewModel(), MilosTrackListViewModel()]
}

final class TracksViewController: UIPageViewController {
    
    private weak var pageControl: UIPageControl!
    
    private let viewModel: TracksViewModeling
    private var childControllers: [TrackListViewController] = []
    
    // MARK: - Initialization
    
    init(viewModel: TracksViewModeling) {
        self.viewModel = viewModel
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        self.pageControl = pageControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childControllers = viewModel.viewModels.map(TrackListViewController.init)
        pageControl.numberOfPages = childControllers.count
        
        delegate = self
        dataSource = self
        
        if let firstController = childControllers.first {
            setViewControllers([firstController], direction: .forward, animated: true)
        }
    }
    
}

extension TracksViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == childControllers.first {
            return nil
        }
        
        return childControllers.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == childControllers.first {
            return childControllers.last
        }
        
        return nil
    }

}

extension TracksViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if previousViewControllers.first == childControllers.first {
            pageControl.currentPage = 1
        } else {
            pageControl.currentPage = 0
        }
    }
    
}
