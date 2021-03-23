//
//  MenuLabelTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

class MenuLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var imageCheck: UIImageView!
    
    
    public var textString: String = "" {
        didSet{
            labelText.text = textString
        }
    }
    
    public var isCheck: Bool = false {
        didSet{
            if isCheck {
                imageCheck.image = UIImage(named: "ic_check")
            }else{
                imageCheck.image = nil
            }
        }
    }
    
    
}
