//
//  CovidVC.swift
//  TestApi
//
//  Created by Евгений on 13.03.2021.
//

import UIKit

class CovidVC: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var criticalLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    var covidDatas = [Covid19Data]()
    var networkService = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = 24
        hideLabels()
        networkService.covidDataHandler = { covidData in
            self.covidDatas = covidData
            self.updateUserInterface()
            return nil
        }
        startPresentation()

    }
    
    @IBAction func getCurrentData(_ sender: UIBarButtonItem) {
        getData()
    }
    
    func startPresentation() {
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: "presentationwasviewed")
        if presentationWasViewed == false {
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageVC") as? PageVC {
                   present(pageViewController, animated: true, completion: nil)
        }
   
        }
    }
}
