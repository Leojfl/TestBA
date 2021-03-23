//
//  BaseViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

class BaseViewController: UIViewController {

    var viewBackground: UIView?
    var viewLoading: UIView?
    var isStop: Bool = true
    
    public func start() {
        let screen = view.bounds
        
        isStop = false
        viewLoading?.removeFromSuperview()
        viewBackground?.removeFromSuperview()
        viewLoading = nil
        viewLoading = UIView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height))
        
        // Create container
        let viewContent = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        viewContent.layer.cornerRadius = 8
        
        viewContent.center = CGPoint(x: screen.width / 2, y: (screen.height / 2))
        viewContent.backgroundColor = UIColor.black
        viewContent.alpha = 0.5
        viewContent.clipsToBounds = true
        viewLoading?.addSubview(viewContent)
        
        
        let spinner = UIActivityIndicatorView(frame: CGRect(x: (viewContent.frame.size.width - 20) / 2, y: (viewContent.frame.size.height - 20) / 2, width: 22, height: 22))
        spinner.style = .large
        spinner.color = UIColor.white
        spinner.startAnimating()
        viewContent.addSubview(spinner)
        
        viewBackground = UIView(frame: screen)
        viewBackground?.backgroundColor = UIColor.clear
        viewBackground?.alpha = 0
        view.addSubview(viewBackground!)
        
        
        viewLoading?.alpha = 0
        view.addSubview(viewLoading!)
        
        UIView.animate(withDuration: 0.2) {
            self.viewBackground?.alpha = 0.5
            self.viewLoading?.alpha = 1
        }
    }
    
    
    public func stop() {
        isStop = true
        if viewLoading != nil {
            UIView.animate(withDuration: 0.1, animations: {
                self.viewBackground?.alpha = 0
                self.viewLoading?.alpha = 0
                
            }) { (finished) in
                self.viewBackground?.removeFromSuperview()
                self.viewBackground = nil
                self.viewLoading?.removeFromSuperview()
                self.viewLoading = nil
            }
        }
    }
    
    
    

}
