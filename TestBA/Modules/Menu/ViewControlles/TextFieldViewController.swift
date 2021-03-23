//
//  TextFieldViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class TextFieldViewController: BaseViewController {
    
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var tfText: TextFieldCustom!
    @IBOutlet weak var lbLastValidate: UILabel!
    
    public var validateType = ValidateType.fullname
    private var viewModel = TextFieldViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
    @IBAction func onClickBtnValidate(_ sender: Any) {
        if isValid(){
            viewModel.saveText(text: tfText.text!, type: validateType)
            lbLastValidate.text = tfText.text!
        }
        
    }
    
    private func setup() {
        lbDescription.text = validateType.getDescriptioText()
        tfText.placeholder = validateType.getText()
        viewModel.loadData(type: validateType)
    }
    
    private func setupBinding(){
        
            
        viewModel.needsLoading.asObservable()
                .bind {  isLoading in
                    if isLoading {
                        self.start()
                    }else{
                        self.stop()
                    }
                }.disposed(by: bag)
        
        viewModel.lastText.asObservable()
                .bind {  text in
                    self.lbLastValidate.text = text
                }.disposed(by: bag)
        
        
    }
    
    private func isValid() -> Bool{
        switch validateType {
        case .fullname:
            return isValidFullName()
        case .phone:
            return isValidPhone()
        }
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
