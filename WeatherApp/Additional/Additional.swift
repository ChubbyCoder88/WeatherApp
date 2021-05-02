//
//  Additional.swift
//  WeatherApp
//
//  Created by Matthew on 28/4/21.
//

import Foundation
import UIKit
class Alert {
class func show(title: String, message: String, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert, animated: true)
    }
}
struct Fonts {
    static let common = "Arial"
}
extension UIColor {
    static let myTransparentBlack = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.9)
}
