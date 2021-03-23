//
//  Extension.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

extension UIViewController {
    
    func setupStatusBar(color: UIColor = UIColor.clear){
          
        if #available(iOS 13.0, *) {
            let tag = 3848245
            let keyWindow = UIApplication.shared.connectedScenes
                  .map({$0 as? UIWindowScene})
                  .compactMap({$0})
                  .first?.windows.first

                
            if let statusBar = keyWindow?.viewWithTag(tag) {
                statusBar.backgroundColor = color
            } else {
                 
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999

                keyWindow?.addSubview(statusBarView)
                statusBarView.backgroundColor = color
                
            }
            
        } else {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.backgroundColor = color
        }
    }
    
    func configBackButton(title: String, color: UIColor, selColor: UIColor?) {
        for item in self.navigationController?.navigationBar.items ?? []{
            item.backBarButtonItem =  UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
            item.backBarButtonItem?.tintColor = color
        }
    }
    func setupNavigarionBar(color: UIColor = UIColor.clear) {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = color
    }
    
    func makeNavigationBarUnClear() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    func showAlert(message: String, title: String, completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            completion?()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension UIImageView {
    func load(url: URL) {
        self.image = UIImage(named: "ic_sync")
        self.contentMode = .center
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFit
                    }
                }
            }
        }
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let scanner = Scanner(string: hexString )
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
