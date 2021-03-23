//
//  ColorViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RxCocoa

class ColorViewModel: BaseViewModel {
    
    
    var colors = BehaviorRelay<[UIColor]>(value: [])
    
    
    public func loadData(){
        self.needsLoading.accept(true)
        self.colors.accept([UIColor.gray, .blue, .cyan, .green, .red, .purple] )
        self.needsLoading.accept(false)
    }
    
    public func saveColor(color: UIColor){
        let colorDB = ColorDB()
        colorDB.hexa = color.toHexString()
        ColorDB.saveColor(color: colorDB)
    }


}
