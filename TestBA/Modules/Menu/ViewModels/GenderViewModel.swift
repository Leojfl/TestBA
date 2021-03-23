//
//  GenderViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RxCocoa

class GenderViewModel: BaseViewModel {
    
    var lastGender = BehaviorRelay<String>(value: "")
    
    
    public func loadData(){
        self.needsLoading.accept(true)
        let lastGender = TextDB.getLastText(type: 5)
        self.lastGender.accept(lastGender)
        self.needsLoading.accept(false)
    }
    
    public func saveText(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type: 5)
        self.needsLoading.accept(false)
    }
}
