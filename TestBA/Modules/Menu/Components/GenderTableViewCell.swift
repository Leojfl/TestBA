//
//  GenderTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class GenderTableViewCell: UITableViewCell {

    @IBOutlet weak var scGender: UISegmentedControl!
    @IBOutlet weak var lastGender: UILabel!
    
    var lastGenderString: String = "" {
        didSet{
            lastGender.text = lastGenderString
        }
    }
    
    var handleSave: ((_ text:String)-> Void)?
    
    @IBAction func onSelectGender(_ sender: Any) {
        
        let index = scGender.selectedSegmentIndex
        var gender  = "Mujer"
        if index == 0 {
            lastGender.text = gender
        }
        
        if index == 1 {
            gender = "Hombre"
            lastGender.text = gender
        }
        handleSave?(gender)
    }
    
}
