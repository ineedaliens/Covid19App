//
//  Extensions.swift
//  TestApi
//
//  Created by Евгений on 13.03.2021.
//

import UIKit

extension CovidVC {
    
    // Alert Controller
    func getData() {
        let ac = UIAlertController(title: "Введите", message: "Название страны", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler:  { _ in
            self.hideLabels()
        })
        let ok = UIAlertAction(title: "OK", style: .default, handler: {_ in
            let countryName = ac.textFields!.first?.text
            self.viewLabel()
            self.networkService.fetchCurrentCovidDataForCountry(with: countryName!.split(separator: " ").joined(separator: "%20"))
        })
        ac.addTextField { (textField) in
            let countryNames = ["Afghanistan","Abkhazia","Artsakh","Albania","Algeria","Andorra","Angola","Antigua and Barbuda","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Central African Republic","Chad","Cook Islands","Chile","China","Colombia","Comoros","Congo","Costa Rica","Croatla","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Eswatini", "Ethiopia","Fiji","Finland","France","Gabon","Gambia, The","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Ivory Coast","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kosovo","Kiribati","Korea, North","Korea, South","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Niue","North Korea","North Macedonia","Northern Cyprus","Norway","Oman","Pakistan","Palau","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Pridnestrovie","Qatar","Republic of Korea","Republic of the Congo","Romania","Russia","Rwanda","Sahrawi Arab Democratic Republic","Saint Kitts and Nevis","Saint Lucia","Saint Vincent and the Grenadines","Samoa","San Marino","São Tomé and Príncipe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","Somaliland","South Africa","South Korea","South Ossetia","South Sudan","Spain","Sri Lanka","Sudan","Sudan, South","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","The Bahamas","The Gambia","Timor-Leste","Togo","Tonga","Transnistria","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Yemen","Zambia","Zimbabwe"]
            textField.placeholder = countryNames.randomElement()
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    // Update interface for CovidVC
    func updateUserInterface() {
        let covidData = covidDatas.first
        DispatchQueue.main.async {
            self.countryLabel.text = "\(covidData?.country ?? "")"
            self.deathLabel.text = "Умерло: \(covidData?.deaths ?? 0)"
            self.confirmedLabel.text = "Потверждено: \(covidData?.confirmed ?? 0)"
            self.criticalLabel.text = "Критическое: \(covidData?.critical ?? 0)"
            self.lastUpdateLabel.text = "Последнее обновление: \(covidData?.lastUpdate ?? "")"
        }
    }
    
    // Hide Labels for CovidVC
    func hideLabels() {
        messageView.isHidden = true
        countryLabel.isHidden = true
        deathLabel.isHidden = true
        confirmedLabel.isHidden = true
        criticalLabel.isHidden = true
        lastUpdateLabel.isHidden = true
    }

    // View Labels for CovidVc
    func viewLabel() {
        messageView.isHidden = false
        countryLabel.isHidden = false
        deathLabel.isHidden = false
        confirmedLabel.isHidden = false
        criticalLabel.isHidden = false
        lastUpdateLabel.isHidden = false
    }
}

extension CovidTVC: TableViewHeaderFooterViewDelegate {
    
//    func updateSearchResults(for searchController: UISearchController) {
//        filterCommentsFor( searchText: searchController.searchBar.text!)
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        if searchBar.text == "" {
//            navigationController?.hidesBarsOnSwipe = false
//        }
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        navigationController?.hidesBarsOnSwipe = true
//    }

    func toggleSection(headed: TableViewHeaderFooterView, section: Int) {
        tap = !tap
        tableView.beginUpdates()
        for row in 0..<1 {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .right)
        }
        tableView.endUpdates()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return covidData?.infectedByRegion.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.isActive && searchController.searchBar.text != "" {
//            return filteredCommentsResult.count
//        }
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let covid = covidData?.infectedByRegion[section].region
//        return covid
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TableViewHeaderFooterView()
        header.setup(withTitle: covidData!.infectedByRegion[section].region, sction: section, delegate: self)
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CovidTVCell
        let covid = covidData?.infectedByRegion[indexPath.section]
        
//        let covid = filteredNamesDisplay(indexPath: indexPath)
       
        cell.configureCell(covid: covid!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     return true
     }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  tap {
            return 102
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 35
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
}
