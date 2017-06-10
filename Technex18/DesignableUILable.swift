//
//  DesignableUILable.swift
//  Technex18
//
//  Created by JOGENDRA on 30/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit

class DesignableUILable: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

}
