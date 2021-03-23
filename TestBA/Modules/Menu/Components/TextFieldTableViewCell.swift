//
//  TextFieldTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var tfText: TextFieldCustom!
    @IBOutlet weak var lbLastValidate: UILabel!
    
    var handleSave: ((_ text:String)-> Void)?
    public var validateType = ValidateType.fullname {
        didSet{
            setup()
        }
    }
    
    public var lastText: String = "" {
        didSet{
            self.lbLastValidate.text = lastText
        }
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onClickBtnValidate(_ sender: Any) {
        if isValid(){
            handleSave?(tfText.text!)
            lbLastValidate.text = tfText.text!
        }
        
    }
    
    private func isValid() -> Bool{
        switch validateType {
        case .fullname:
            return isValidFullName()
        case .phone:
            return isValidPhone()
        }
    }
    
    private func setup() {
        lbDescription.text = validateType.getDescriptioText()
        tfText.placeholder = validateType.getText()
        
    }
    
    private func isValidFullName() -> Bool{
        var isValid: Bool = true
        isValid = tfText.required(error: "El nombre es requerido") && isValid
        isValid = tfText.max(characters: 30, error: "El texto es muy largo") && isValid
        isValid = tfText.onlyLettersAndSpace(error: "El nombre contiene caracteres no válidos") && isValid
        return isValid
    }
    
    private func isValidPhone() -> Bool{
        var isValid: Bool = true
        isValid = tfText.required(error: "El teléfono es requerido") && isValid
        isValid = tfText.phone(error: "Teléfono no válido") && isValid
        return isValid
    }
    
}
