//
//  RoomsTableItem.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/21/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class RoomsTableItem: UITableViewCell {

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

    lazy var nameLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        return view
    }()

    func initViewElements() {
        addSubview(nameLabel)
        setNeedsUpdateConstraints()
    }
    
    func positionViewElements() {
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
    }
    
}
