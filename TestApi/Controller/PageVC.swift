//
//  PageVC.swift
//  TestApi
//
//  Created by Евгений on 13.03.2021.
//

import UIKit

class PageVC: UIPageViewController {
    
    let imageArray = ["1","2","3",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentViewController = showViewControllerAtIndex(index: 0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    func showViewControllerAtIndex(index: Int) -> ContentForPageVC? {
        guard index >= 0 else { return nil }
        guard index < imageArray.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "presentationwasviewed")
            dismiss(animated: true, completion: nil)
            return nil }
        guard let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentForPageVC") as? ContentForPageVC else { return nil }
        contentViewController.current = index
        contentViewController.numberOfPage = imageArray.count
        contentViewController.image = imageArray[index]
        return contentViewController
    }
    

}
extension PageVC: UIPageViewControllerDataSource {
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentForPageVC).current
        pageNumber -= 1
        return showViewControllerAtIndex(index: pageNumber)
    }
    
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            var pageNumber = (viewController as! ContentForPageVC).current
            pageNumber += 1
            return showViewControllerAtIndex(index: pageNumber)
    }
    
    
}
