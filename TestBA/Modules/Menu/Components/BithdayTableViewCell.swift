//
//  BithdayTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class BithdayTableViewCell: UITableViewCell {

 
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var lastBirthday: UILabel!
    
    var handleSave: ((_ text:String)-> Void)?
    
    var lastBirthdayString: String = " "{
        didSet{
            lastBirthday.text = lastBirthdayString
        }
    }
    
    @IBAction func onClickSelect(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let date = df.string(from: dpDate.date)
        lastBirthday.text = date
        handleSave?(date)
    }
    
    
}
