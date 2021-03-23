//
//  BirthdayViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RxCocoa

class BirthdayViewModel: BaseViewModel {
    
    var lastBirthday = BehaviorRelay<String>(value: "")
    
    
    public func loadData(){
        self.needsLoading.accept(true)
        let lastBirthday = TextDB.getLastText(type: 4)
        self.lastBirthday.accept(lastBirthday)
        self.needsLoading.accept(false)
    }
    
    public func saveText(text: String){
        self.needsLoading.accept(true)
        TextDB.saveText(text: text, type: 4)
        self.needsLoading.accept(false)
    }

}

