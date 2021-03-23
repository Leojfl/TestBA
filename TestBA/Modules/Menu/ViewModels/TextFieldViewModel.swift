//
//  TextFieldViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RxCocoa

class TextFieldViewModel: BaseViewModel {
    
    var lastText = BehaviorRelay<String>(value: "")
    
    
    public func loadData(type: ValidateType){
        self.needsLoading.accept(true)
        let lastText = TextDB.getLastText(type: type.getInt())
        self.lastText.accept(lastText)
        self.needsLoading.accept(false)
    }
    
    public func saveText(text: String, type: ValidateType){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type: type.getInt())
        self.needsLoading.accept(false)
        
    }

}

enum ValidateType {
    case phone
    case fullname
    
    
    
    func getDescriptioText() -> String{
        switch self {
        case .fullname:
            return "Por favor ingrese su nombre completo"
        case .phone:
            return "Por favor ingrese su teléfono"
        }
    }
    
    func getText() -> String{
        switch self {
        case .fullname:
            return "Nombre completo"
        case .phone:
            return "Teléfono"
        }
    }
    
    func getInt() -> Int{
        switch self {
        case .fullname:
            return 1
        case .phone:
            return 2
        }
    }
}
