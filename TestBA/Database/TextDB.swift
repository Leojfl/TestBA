//
//  TextDB.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RealmSwift

class TextDB: Object {
    
    @objc dynamic var text = ""
    @objc dynamic var type: Int = 1
    
    
    
    public static func getLastText(type: Int) -> String{
        let realm = try! Realm()
        let textDB = realm.objects(TextDB.self).filter("type = \(type)").last
        return textDB?.text ?? " "
    }
    
    public static func saveText(text:String ,type: Int){
        let realm = try! Realm()
        let textDB = TextDB()
        textDB.type = type
        textDB.text = text
        try! realm.write {
            realm.add(textDB)
        }
    }

}
