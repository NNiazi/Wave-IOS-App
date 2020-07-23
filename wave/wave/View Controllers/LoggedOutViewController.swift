//
//  ViewController.swift
//  wave
//
//  Created by Ahmed Aziz on 04/04/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoggedOutViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var orStartBrowsing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if there is a current user signed in
        authUserAndConfigView()
        
        //Load the styling for the register and login buttons
        setUpButtonStyling()
    }
    
    //Instantiate correct view controller based on if a user is logged in or if not
    func authUserAndConfigView(){
        
        //If there is a current user logged in
        if Auth.auth().currentUser != nil{
            
            //Execute on main thread
            DispatchQueue.main.async {
                self.transitionToHome()
            }
        }
        //If there is no logged in users transition to logged out view
        else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loggedOutViewController = storyBoard.instantiateViewController(withIdentifier: "Navigation")
            view.window?.rootViewController = loggedOutViewController
            view.window?.makeKeyAndVisible()
        }
    }
    
    //Style for the register and login buttons
    func setUpButtonStyling(){
        
        //Style the register button with the filled styling
        Utilities.styleFilledButton(registerButton)
        
        //Style the login button with the unfilled styling
        Utilities.styleHollowButton(loginButton)
        
        //Add underline to button text for or Start Browsing
        self.orStartBrowsing.underline()
    }
    
    //Take user to home page without being logged in
    @IBAction func orStartBrowsingTapped(_ sender: Any) {
        transitionToHome()
    }
    
    //Instantiate home view controller
    func transitionToHome(){
        //When the or Start Browsing button is tapped it takes us to the home page
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyBoard.instantiateViewController(withIdentifier: "TabBar")
        view.window?.rootViewController = tabBar
        view.window?.makeKeyAndVisible()
    }
}

