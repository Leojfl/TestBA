//
//  MenuViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//
import UIKit
import RxCocoa

class MenuViewModel: BaseViewModel {

    var data = BehaviorRelay<[MenuContentViewCell]>(value: [])
    var color = BehaviorRelay<UIColor?>(value: nil)
    var itemsSelected: [MenuContentViewCell] = []
    
    public func loadData(){
        self.needsLoading.accept(true)
        let data: [MenuContentViewCell] = [
            MenuContentViewCell(type: .camera),
            MenuContentViewCell(type: .photo),
            MenuContentViewCell(type: .fullName),
            MenuContentViewCell(type: .phone),
            MenuContentViewCell(type: .birthday),
            MenuContentViewCell(type: .gender),
            MenuContentViewCell(type: .favoriteColor),
        ]
        if let color  = ColorDB.getColor() {
            let color = UIColor(hexString: color.hexa)
            self.color.accept(color)
        }
        self.data.accept(data)
        self.needsLoading.accept(false)
    }
    
    
    public func isSelected(itemSelect: MenuContentViewCell) -> Bool{
        let itemSelected = self.itemsSelected.first { (item) -> Bool in
            return item.type == itemSelect.type
        }
        return itemSelected != nil
    }
    
    
    public func changeStatusItem(row: Int) {
        let itemSelect = data.value[row]
        if isSelected(itemSelect: itemSelect){
            self.itemsSelected = self.itemsSelected .filter({ (item) -> Bool in
                return item.type != itemSelect.type
            })
        }else{
            self.itemsSelected.append(itemSelect)
        }
    }

}

struct MenuContentViewCell {
    let type: EnumMenuContent
    
}

enum EnumMenuContent{
    case camera
    case photo
    case fullName
    case phone
    case birthday
    case gender
    case favoriteColor
    
    
    func getText() -> String {
        switch self {
        case .camera:
            return "Cámara"
        case .photo:
            return "Foto"
        case .fullName:
            return "Nombre completo"
        case .phone:
            return "Teléfono"
        case .birthday:
            return "Fecha de nacimiento"
        case .gender:
            return "Sexo (Masculino o femenino)"
        case .favoriteColor:
            return "Color favorito"
        }
    }
    
    
    func getInt() -> Int{
        switch self {
        case .camera:
            return 1
        case .photo:
            return 2
        case .fullName:
            return 3
        case .phone:
            return 4
        case .birthday:
            return 5
        case .gender:
            return 6
        case .favoriteColor:
            return 7
        }
    }
    
    
}
