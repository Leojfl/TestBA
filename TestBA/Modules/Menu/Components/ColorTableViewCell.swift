//
//  ColorTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCard: CardView!
    public var color:UIColor?  {
        didSet{
            viewCard.backgroundColor = color
        }
    }
}
