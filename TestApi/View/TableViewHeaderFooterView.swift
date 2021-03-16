//
//  TableViewHeaderFooterView.swift
//  TestApi
//
//  Created by Евгений Сергеевич on 14.03.2021.
//

import UIKit

protocol TableViewHeaderFooterViewDelegate {
    func toggleSection(headed: TableViewHeaderFooterView, section: Int)
}

class TableViewHeaderFooterView: UITableViewHeaderFooterView {

    var delegate: TableViewHeaderFooterViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, sction: Int, delegate: TableViewHeaderFooterViewDelegate) {
        
        self.delegate = delegate
        self.section = sction
        self.textLabel?.text = title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        textLabel?.contentMode = .center
//        contentView.backgroundColor = .black
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer){
        let cell = gesterRecognizer.view as! TableViewHeaderFooterView
        delegate?.toggleSection(headed: self, section: cell.section!)
    }
}
