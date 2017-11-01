//
//  DesignableTextField.swift
//  Technex18
//
//  Created by JOGENDRA on 25/03/17.
//  Copyright © 2017 Jogendra Singh. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0{
        
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var leftImage : UIImage?{
        
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        
        if let image = leftImage{
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            
            var width = leftPadding + 20
            
            if (borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line){
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
        }
        else{
            leftViewMode = .never
        }
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: tintColor])
    }
    
}
