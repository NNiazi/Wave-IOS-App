//
//  RegisterViewController.swift
//  wave
//
//  Created by Ahmed Aziz on 26/04/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bySigningUp: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var alreadyHaveAnAccount: UIButton!
        
    let alertService = AlertService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add custom image to navigation back button
        self.setNavigationBar()

        //Add styling to the view onload
        setUpStyling()

        //Use return key to hide keyboard
        self.fullNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

        //Tap anywhere on screen to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        //Move view up when keyboard is shown
        self.setUpKeyboardView()
    }
    
    //Func to start setup for styling the content within register view
    func setUpStyling(){
        
        //Style the full name text field
        Utilities.styleTextField(fullNameTextField)
        
        //Add user icon inside text field
        let userImageView = UIImageView(image: UIImage(named: "user"))
        userImageView.frame = CGRect(x: 20, y: 5, width: userImageView.image!.size.width , height: userImageView.image!.size.height)
        let userPaddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        userPaddingView.addSubview(userImageView)
        fullNameTextField.leftViewMode = .always
        fullNameTextField.leftView = userPaddingView
        
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
        
        //TODO: Add styling to the by signing up
        
        
        //Style the login button with the filled styling
        Utilities.styleFilledButton(registerButton)
        
        //Add underline to button text for dont have an account
        self.alreadyHaveAnAccount.underline()
        
    }
    
    //When register button is tapped sign the user up
    @IBAction func registerTapped(_ sender: Any) {
        
        //Validate all textfields
        //Check if the email and password textfield are empty
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            //Show incomplete form alert
            let incompleteForm = alertService.alert(title: "INCOMEPLETE FORM", body: "Please fill in all fields", buttonTitle: "OK")
            present(incompleteForm, animated: true)
            
            return
        }

        //Password field is not empty, clean the password from whitespace characters
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //Check if the password matches the regular expressions method in Utilities Class
        if Utilities.isEmailValid(cleanedEmail) == false{
          
            //Email is not secure enough and Show invalid email alert
            let invalidEmail = alertService.alert(title: "INVALID EMAIL", body: "Please enter a correct email address", buttonTitle: "OK")
            present(invalidEmail, animated: true)

            return
        }

        //Password field is not empty, clean the password from whitespace characters
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //Check if the password matches the regular expressions method in Utilities Class
        if Utilities.isPasswordValid(cleanedPassword) == false{
          
            //Password is not secure enough and Show invalid password alert
            let invalidPassword = alertService.alert(title: "INVALID PASSWORD", body: "Password must have an uppercase and lowercase letter and be 8 characters", buttonTitle: "OK")
            present(invalidPassword, animated: true)

            return
        }
        
        //Handle sign up using Auth
        signup()

    }
    
    //Sign up function containing Auth code
    func signup(){
        
        //Create user
        Auth.auth().createUser(withEmail: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, err) in
            
            //Check for errors
            if err != nil{
                
                //There was an error
                let registrationError = self.alertService.alert(title: "REGISTRATION FAILED", body: err!.localizedDescription, buttonTitle: "OK")
                self.present(registrationError, animated: true)
                
                return
            }
            else{
                
                //User was created successfully, now store full name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["fullname" : self.fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), "uid": result!.user.uid]) { (error) in
                    
                    if error != nil{
                        print("Could not add full name: \(self.fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) to database with uid: \(result!.user.uid) ")
                    }
                }
                
                //Transition to home screen
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
