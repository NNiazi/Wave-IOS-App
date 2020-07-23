//
//  AccountViewController.swift
//  wave
//
//  Created by Ahmed Aziz on 09/05/2020.
//  Copyright © 2020 Ahmed Aziz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var loggedOutView: UIView!
    
    @IBOutlet weak var loggedOutViewRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton(logoutButton)
        
        //Onload show the correct view based on current user state
//        authUserAndConfigView()
    }
    
    //Check for current user state and authenticate view according to it
//    func authUserAndConfigView(){
//
//        //Check if there is a signed in user
//        if Auth.auth().currentUser != nil{
//
//            //Hide the logged out view when there is a signed user
//            loggedOutView.isHidden = true
//
//            //If there is then display the users account details
//            Utilities.styleFilledButton(logoutButton)
//        }
//        //Otherwise direct them to login and register page
//        else{
//            //Hide the logout button when no user is signed in
//            logoutButton.isHidden = true
//
//            //Show the logged out view
//            loggedOutView.isHidden = false
//
//            //Style the logged out view register/log in button
//            Utilities.styleFilledButton(loggedOutViewRegister)
//
//        }
//    }
    
    //Log out button tapped
    @IBAction func logoutTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            transitionToLoggedOutScreen()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
    
    //Register/Log In button tapped when no user is signed in then navigated to logged out page
    @IBAction func loggedOutViewRegisterTapped(_ sender: Any) {
        transitionToLoggedOutScreen()
    }

    //Instantiate logged out view controller
    func transitionToLoggedOutScreen(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loggedOutViewController = storyBoard.instantiateViewController(withIdentifier: "Navigation")
        view.window?.rootViewController = loggedOutViewController
        view.window?.makeKeyAndVisible()
    }
}
