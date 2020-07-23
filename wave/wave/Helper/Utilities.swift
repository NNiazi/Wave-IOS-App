//
//  Utilities.swift
//  wave
//
//  Created by Ahmed Aziz on 02/05/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit

class Utilities:UIViewController {
    
    //Styling for textfields
    static func styleTextField(_ textfield:UITextField) {
        
//        // Create the bottom line
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
//
//        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
//
//        // Remove border on text field
//        textfield.borderStyle = .none
//
//        // Add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
        
        // Hollow rounded corner style
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.cornerRadius = 5.0
        textfield.tintColor = UIColor.black
    }
    
    //Styling for filled buttons
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.white
    }
    
    //Styling for unfilled buttons but with border
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.black
    }
    
    //Styling for alert buttons
    static func styleAlertButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.tintColor = UIColor.white
    }
    
    //Email regular express to check for valid emails
    static func isEmailValid(_ email : String) -> Bool {
         
         let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
         return emailTest.evaluate(with: email)
     }
    
    //Password regular express to check for valid password
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

