//
//  CovidTVCell.swift
//  TestApi
//
//  Created by Евгений Сергеевич on 14.03.2021.
//

import UIKit

class CovidTVCell: UITableViewCell {
    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deceasedLabel: UILabel!
    
    func configureCell(covid: InfectedByRegion) {
        infectedLabel.text = "Зараженно: \(covid.infected)"
        recoveredLabel.text = "Выздоровело: \(covid.recovered)"
        deceasedLabel.text = "Умерло: \(covid.deceased)"
    }
}
