//
//  StoryboardUtils.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//
import UIKit
import Foundation

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    enum Storyboard: String {
        case menu
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        
        let optionalViewController = instantiateViewController(withIdentifier: T.storyboardIdentifier)
        guard let viewController = optionalViewController as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

extension UIViewController: StoryboardIdentifiable {}
