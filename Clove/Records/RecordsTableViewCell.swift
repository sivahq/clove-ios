//
//  RecordsTableViewCell.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/21/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViewElements()
    }
    
    override func updateConstraints() {
        positionViewElements()
        super.updateConstraints()
    }

    lazy var startLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()

    lazy var durationLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.italicSystemFont(ofSize: 14)
        view.textColor = UIColor.gray
        view.textAlignment = .center
        return view
    }()
    
    lazy var endLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        return view
    }()
    
    func initViewElements() {
        addSubview(startLabel)
        addSubview(durationLabel)
        addSubview(endLabel)
        setNeedsUpdateConstraints()
    }
    
    func positionViewElements() {
        startLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        startLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        
        durationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        durationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        endLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        endLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
}
