//
//  HomeViewController.swift
//  Woovly Assignment
//
//  Created by Vikesh Prasad on 04/10/20.
//  Copyright © 2020 Woovly. All rights reserved.
//

import UIKit

typealias VideoIndex = (feed: String, index: Int)

class HomeViewController: UIPageViewController {
    
    var viewModel: HomeViewModel?
    //MARK: Properties
    var currentVideoIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getContent()
    }
    fileprivate func getContent() {
        viewModel = HomeViewModel(listViewController: self)
        if let viewModel = self.viewModel {
            viewModel.completionHandler = { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.presentInitialFeed()
                    }
                }
            }
            viewModel.fetchContent()
        }
    }
    fileprivate func configureUI() {
        self.dataSource = self
        self.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constant.Home.logout, style: .plain, target: self, action: #selector(onTappingLogoutButton))
        self.navigationItem.title = Constant.Home.title
    }
    //Button actions
    @objc func onTappingLogoutButton() {
        self.sceneDelegate?.makeLoginViewNavCntrlAsWindorRootViewController()
    }
    
    private func presentInitialFeed() {
        let viewController = ContentViewController.initialize(urlString: viewModel?.contentArray[currentVideoIndex] ?? "", andIndex: currentVideoIndex, isPlaying: false)
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
    
    private func fetchPreviousVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: currentVideoIndex - 1)
    }
    
    private func fetchNextVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: currentVideoIndex + 1)
    }
    
    private func getVideoIndex(atIndex index: Int) -> VideoIndex? {
        guard index >= 0 && index < viewModel?.contentArray.count ?? 0 else {
            return nil
        }
        return (feed: viewModel?.contentArray[index] ?? "", index: index)
    }
    
    private func updateVideoIndex(fromIndex index: Int) {
        currentVideoIndex = index
    }
}


//MARK: UIPageViewControllerDataSource
extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let previousVideoIndex = fetchPreviousVideoIndex()?.index else {
            return nil
        }
        return ContentViewController.initialize(urlString: viewModel?.contentArray[previousVideoIndex] ?? "", andIndex: previousVideoIndex, isPlaying: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let nextVideoIndex = fetchNextVideoIndex()?.index else {
            return nil
        }
        return ContentViewController.initialize(urlString: viewModel?.contentArray[nextVideoIndex] ?? "", andIndex: nextVideoIndex, isPlaying: false)
    }
}

//MARK: UIPageViewControllerDelegate
extension HomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        if
            let viewController = pageViewController.viewControllers?.first as? ContentViewController,
            let previousViewController = previousViewControllers.first as? ContentViewController
        {
            previousViewController.pausePlayingVideo()
            viewController.startPlayingVideo()
            self.updateVideoIndex(fromIndex: viewController.index)
        }
    }
}
