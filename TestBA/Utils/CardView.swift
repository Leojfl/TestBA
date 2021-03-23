//
//  Utils.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var elevation: Double = 5 {
        didSet {
            layer.shadowOffset = CGSize(width: 0, height: elevation)
        }
    }
  
    @IBInspectable var shadowRadius: CGFloat = 3 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
  
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: elevation)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = cornerRadius
    }
}
