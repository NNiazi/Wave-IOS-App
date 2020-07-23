//
//  LoginViewController.swift
//  wave
//
//  Created by Ahmed Aziz on 26/04/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var dontHaveAnAccount: UIButton!
    
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add custom image to navigation back button
        self.setNavigationBar()
        
        //Add styling to the view onload
        setUpStyling()
        
        //Use return key to hide keyboard
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
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
        
        //Style the password text field
        Utilities.styleTextField(passwordTextField)
        
        //Add password icon inside textfield
        let passwordImageView = UIImageView(image: UIImage(named: "password"))
        passwordImageView.frame = CGRect(x: 20, y: 5, width: passwordImageView.image!.size.width , height: passwordImageView.image!.size.height)
        let passwordPaddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        passwordPaddingView.addSubview(passwordImageView)
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = passwordPaddingView
        
        //Add underline to button text for forgot password
        self.forgotPassword.underline()
        
        //Style the login button with the filled styling
        Utilities.styleFilledButton(loginButton)
        
        //Add underline to button text for dont have an account
        self.dontHaveAnAccount.underline()
        
    }
    
    //When login button is tapped sign them in
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //Clean the text entry for email and password
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Validate textfields
        if email == "" || password == ""{
            let incompleteForm = alertService.alert(title: "INCOMEPLETE FORM", body: "Please fill in all fields", buttonTitle: "OK")
            present(incompleteForm, animated: true)
        }
        
        
        //Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error ) in
            
            //Error signing user in
            if error != nil{
                let loginError = self.alertService.alert(title: "LOGIN FAILED", body: error!.localizedDescription, buttonTitle: "OK")
                self.present(loginError, animated: true)
            }
            //No error continue to transition to Home view controller
            else{
                self.transitionToHome()
            }
        }
    }
    
    //Transition to home view controller in Main.storyboard
    func transitionToHome(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyBoard.instantiateViewController(withIdentifier: "TabBar")
        view.window?.rootViewController = tabBar
        view.window?.makeKeyAndVisible()
    }
}


