//
//  ViewController.swift
//  MyBook
//
//  Created by eavictor on 2020/12/30.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    var pageViewController:UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 1. Instantiate PageViewController and add the PageViewController's view into this subview
        pageViewController = storyboard.instantiateViewController(withIdentifier: "PageViewController") as? UIPageViewController
        pageViewController?.view.frame = self.view.frame
        if let okPageViewController = pageViewController {
            addChild(okPageViewController)
            view.addSubview(okPageViewController.view)
        }
        pageViewController?.didMove(toParent: self)
        
        guard let startPage = viewControllerAtIndex(index: 0) else { return }
        pageViewController?.setViewControllers([startPage], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        pageViewController?.dataSource = self
    }
    
    func viewControllerAtIndex(index:Int) -> ContentViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contentViewController = storyboard.instantiateViewController(withIdentifier: "MainContentViewController") as? ContentViewController
        contentViewController?.currentPageNumber = index
        return contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as? ContentViewController
        guard let index = vc?.currentPageNumber else { return nil }
        if index == 0 || index == NSNotFound {
            return nil
        } else {
            return viewControllerAtIndex(index: index - 1)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as? ContentViewController
        guard let index = vc?.currentPageNumber else { return nil }
        if index >= 3 || index == NSNotFound {
            return nil
        } else {
            return viewControllerAtIndex(index: index + 1)
        }
    }
}
