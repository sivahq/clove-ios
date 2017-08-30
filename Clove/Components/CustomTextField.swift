//
//  CustomTextField.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/28/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + 15,
            y: bounds.origin.y + 8,
            width: bounds.size.width - 30,
            height: bounds.size.height - 16
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

}
