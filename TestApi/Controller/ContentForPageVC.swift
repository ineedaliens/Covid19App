//
//  ContentForPageVC.swift
//  TestApi
//
//  Created by Евгений on 13.03.2021.
//

import UIKit

class ContentForPageVC: UIViewController {

    @IBOutlet weak var imagesView: UIImageView! {
        didSet{
            imagesView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!

    var image = ""
    var current = 0
    var numberOfPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagesView.image = UIImage(named: image)
        pageControl.numberOfPages = numberOfPage
        pageControl.currentPage = current
    }
    

}
