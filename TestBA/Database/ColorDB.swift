//
//  ColorDB.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RealmSwift

class ColorDB: Object {
    @objc dynamic var hexa: String = ""
    
    public static func getColor() -> ColorDB? {
        let realm = try! Realm()
        let colorsDB = realm.objects(ColorDB.self).last
        return colorsDB
    }
    
    public static func saveColor(color: ColorDB){
        let realm = try! Realm()
        try! realm.write {
            realm.add(color)
        }
    }

    

}
