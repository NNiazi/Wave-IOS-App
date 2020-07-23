//
//  AlertService.swift
//  wave
//
//  Created by Ahmed Aziz on 04/05/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit

class AlertService{
    
    func alert(title: String, body: String, buttonTitle:String) -> AlertViewController{
        
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        
        alertVC.alertTitle = title
        
        alertVC.alertBody = body
        
        alertVC.okButtonTitle = buttonTitle
        
        return alertVC
    }
}
