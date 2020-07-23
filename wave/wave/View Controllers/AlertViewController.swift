//
//  File.swift
//  wave
//
//  Created by Ahmed Aziz on 04/05/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit

class AlertViewController:UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    var alertTitle = String()
    
    var alertBody = String()
    
    var okButtonTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    //Add styling to ok button
    func setUpView(){
        
        //Set titleLabel outlet to whatever the alertTitle will be
        titleLabel.text = alertTitle
        
        //Set bodyLabel outlet to whatever the alertTitle will be
        bodyLabel.text = alertBody
        
        //Style the ok buttons
        Utilities.styleAlertButton(okButton)
        
        //Set okButton outlet to whatever the alertTitle will be
        okButton.setTitle(okButtonTitle, for: .normal)
    }
    
    //Dismiss alert when tapped
    @IBAction func okTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
