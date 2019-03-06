//
//  TracksViewController.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        self.pageControl = pageControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        childControllers = viewModel.viewModels.map(TrackListViewController.init)
        childControllers.forEach { $0.delegate = self }
        pageControl.numberOfPages = childControllers.count
        
        updateState()
        
        delegate = self
        dataSource = self
        
        if let firstController = childControllers.first {
            setViewControllers([firstController], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Helpers
    
    private func updateState() {
        navigationItem.title = viewModel.title
        pageControl.currentPage = viewModel.selectedIndex
    }
    
    private func indexOfController(_ controller: UIViewController) -> Int? {
        for (offset, element) in childControllers.enumerated() where element == controller {
            return offset
        }
        
        return nil
    }
    
}

extension TracksViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let index = indexOfController(viewController),
            let newIndex = index == 0 ? nil : index - 1
        else { return nil }
        
        return childControllers[newIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let index = indexOfController(viewController),
            let newIndex = index + 1 < childControllers.count ? index + 1 : nil
        else { return nil }
        
        return childControllers[newIndex]
    }

}

extension TracksViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            completed,
            let controller = pageViewController.viewControllers?.last,
            let index = indexOfController(controller)
        else { return }
        
        viewModel.selectedIndex = index
        updateState()
    }
    
}

extension TracksViewController: TrackListViewControllerDelegate {
    
    func didSelectTrack(_ track: Track) {
        viewModel.play(track: track)
    }
    
}
