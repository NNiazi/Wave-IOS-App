//
//  ForgotPasswordViewController.swift
//  wave
//
//  Created by Ahmed Aziz on 01/05/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add custom image to navigation back button
        self.setNavigationBar()
        
        //Add styling to the view onload
        setUpStyling()
        
        //Use return key to hide keyboard
        self.emailTextField.delegate = self
        
        //Tap anywhere on screen to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //Move view up when keyboard is shown
        self.setUpKeyboardView()
        
    }
    
    func setUpStyling(){
        
        //Style the email text field
        Utilities.styleTextField(emailTextField)
        
        //Add email icon inside textfield
        let emailImageView = UIImageView(image: UIImage(named: "email"))
        emailImageView.frame = CGRect(x: 20, y: 5, width: emailImageView.image!.size.width , height: emailImageView.image!.size.height)
        let emailPaddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        emailPaddingView.addSubview(emailImageView)
        emailTextField.leftViewMode = .always
        emailTextField.leftView = emailPaddingView
        
        //Style the login button with the filled styling
        Utilities.styleFilledButton(resetButton)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
        //Clean the email from whitespace characters
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Check if the email text field is not empty
        if cleanedEmail == ""{

            //Email is empty show incomplete form alert
            let incompleteForm = alertService.alert(title: "INCOMEPLETE FORM", body: "Please fill in all fields", buttonTitle: "OK")
            present(incompleteForm, animated: true)

            return
        }

        //Check if the email matches the regular expressions method in Utilities Class
        if Utilities.isEmailValid(cleanedEmail) == false{
          
          //Email is not in correct format, Show invalid email alert
          let invalidEmail = alertService.alert(title: "INVALID EMAIL", body: "Please enter a correct email address", buttonTitle: "OK")
          present(invalidEmail, animated: true)
          
          return
        }
        else{
            Auth.auth().sendPasswordReset(withEmail: cleanedEmail) { error in
                     
                //There is an error and then show
                if error != nil{
                    let loginError = self.alertService.alert(title: "RESET FAILED", body: error!.localizedDescription, buttonTitle: "OK")
                    self.present(loginError, animated: true)
                }
                //Otherwise send reset email link to user
                else {
                    let emailSent = self.alertService.alert(title: "EMAIL SENT", body: "Please follow the instructions on your email to reset your password", buttonTitle: "OK")
                    self.present(emailSent, animated: true)
                }
            }
        }
    }
}
