//
//  TextField.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import MaterialComponents


class TextFieldCustom: MDCTextField, UITextFieldDelegate {
    
    public var controller: MDCTextInputControllerOutlined!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.controller = MDCTextInputControllerOutlined(textInput: self)
        self.placeholderLabel.backgroundColor = .white
        self.clipsToBounds = true
        self.placeholderLabel.clipsToBounds = true
        self.applyStyle(controllers: [self.controller])
        delegate = self
    }
    
    public func required(error: String) -> Bool {
        if controller.errorText == nil {
            if text! == "" {
                controller.setErrorText(error, errorAccessibilityValue: nil)
                return false
            }
            return true
        }
        return false
    }
    
    public func email(error: String) -> Bool {
        if controller.errorText == nil {
            let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
            if !predicate.evaluate(with: text!) {
                controller.setErrorText(error, errorAccessibilityValue: nil)
                return false
            }
            return true
        }
        return false
    }
    
    
    public func max(characters: Int, error: String) -> Bool {
        if controller.errorText == nil {
            if text!.isEmpty || text!.count > characters{
                controller.setErrorText(error, errorAccessibilityValue: nil)
                return false
            }
            return true
        }
        return false
    }
    
    public func phone(error: String) -> Bool {
        if controller.errorText == nil {
            let regEx = "^\\d{10}$"
            let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
            if !predicate.evaluate(with: text!) {
                controller.setErrorText(error, errorAccessibilityValue: nil)
                return false
            }
            return true
        }
        return false
    }
    
    public func onlyLettersAndSpace(error: String) -> Bool {
        if controller.errorText == nil {
            let regEx = "^[A-z??-??\\s]+$"
            let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
            if !predicate.evaluate(with: text!) {
                controller.setErrorText(error, errorAccessibilityValue: nil)
                return false
            }
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        controller.setErrorText(nil, errorAccessibilityValue: nil)
        return true
    }
}

extension TextFieldCustom {
    public func applyStyle(controllers: [MDCTextInputControllerBase]) {
        for controller in controllers {
            controller.activeColor = .black
            controller.floatingPlaceholderActiveColor = .black
            
        }
    }
    
    func setLeftIcon(_ image: UIImage, tintColor: UIColor = .black) {
        let iconView = UIImageView(image: image)
        iconView.tintColor = tintColor
        
        leftView = iconView
        leftViewMode = .always
        
        translatesAutoresizingMaskIntoConstraints = false
        leftView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leftView?.contentMode = .scaleAspectFit
    }
    
    func setRightIcon(_ image: UIImage, tintColor: UIColor = .black) {
        let iconView = UIImageView(image: image)
        iconView.tintColor = tintColor
        trailingView = iconView
        trailingViewMode = .always
        iconView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        iconView.contentMode = .scaleAspectFit
    }
  

}
