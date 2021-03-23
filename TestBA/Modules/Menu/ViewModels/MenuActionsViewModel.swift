//
//  MenuActionsViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RxCocoa

class MenuActionsViewModel: BaseViewModel {
    
    var data = BehaviorRelay<[MenuContentViewCell]>(value: [])
    var itemsSelected: [MenuContentViewCell]
    
    var fullName: String = ""
    var phone: String = ""
    var birthday: String = ""
    var gender: String = ""
    
    
    
    
    
    init(itemsSelected: [MenuContentViewCell]) {
        self.itemsSelected = itemsSelected
    }
    
    public func loadData(){
        self.needsLoading.accept(true)
        
        for item in itemsSelected {
            switch item.type {
            case .fullName:
                fullName = TextDB.getLastText(type: item.type.getInt())
                break
            case .phone:
                phone = TextDB.getLastText(type: item.type.getInt())
                break
            case .birthday:
                birthday = TextDB.getLastText(type: item.type.getInt())
                break
            case .gender:
                gender = TextDB.getLastText(type: item.type.getInt())
                break
            default:
                print("no get")
            }
            
            
        }
        
        data.accept(itemsSelected)
        self.needsLoading.accept(false)
    }
    
    
    public func getIndex(type: EnumMenuContent)-> Int? {
        return data.value.firstIndex { (item) -> Bool in
           return type == item.type
        }
    }
    
    
    public func saveColor(color: UIColor){
        let colorDB = ColorDB()
        colorDB.hexa = color.toHexString()
        ColorDB.saveColor(color: colorDB)
    }
    
    public func saveTextFullName(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type: EnumMenuContent.fullName.getInt() )
        self.needsLoading.accept(false)
        
    }
    
    public func saveTextPhone(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type: EnumMenuContent.phone.getInt() )
        self.needsLoading.accept(false)
        
    }
    
    public func saveTextBirthday(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type:  EnumMenuContent.birthday.getInt())
        self.needsLoading.accept(false)
    }
    
    public func saveGender(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type:  EnumMenuContent.gender.getInt())
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
    
}
