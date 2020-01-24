//
//  LoginViewController.swift
//  Gigs
//
//  Created by alfredo on 1/20/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
         super.viewDidLoad()
     }
     
    //MARK: - Properties
    
    var gigController: GigController!
    var loginType: LoginType = .signup
    
 
    //MARK: - IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        
        switch selectedSegmentIndex{
        case  0:
            loginType = .signin
            loginButton.setTitle(loginType.rawValue, for: .normal)
        case 1:
            loginType = .signup
            loginButton.setTitle(loginType.rawValue, for: .normal)
        default:
            break
        }
    }
    @IBAction func buttonTapped(_ sender: Any) {
        //make sure data that is needed is available
        guard let username = usernameLabel.text, !username.isEmpty else { return }
        guard let password = passwordLabel.text, !password.isEmpty else { return }
        //convert data into model
        let user = User(username: username, password: password)
        //determine whether user is signing up or signing in
        switch loginType{
        case .signin:
            signIn(user)
        case .signup:
            signUp(user)
        }
    }
    func signUp(_ user: User){
        gigController.signUp(with: user) { (error) in
            //Create error log if error occurs in signup method
            if let errorOccured = error {
                print("Error occured during sign up: \(errorOccured)")
            }
            else {
                
                //MARK: -Update UI from Main Queue
                
                //No error occured take credientials and sign in to application
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Sign up successful!", message: "Now please sign in.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true) {
                        self.loginType = .signin
                        //Change UI to sign in mode
                        self.segmentedControl.selectedSegmentIndex = 1
                        self.loginButton.setTitle("Log In", for: .normal)
                    }
                }
            }
        }
    }
    func signIn(_ user: User){
        gigController.signIn(with: user) { error in
            //Check for error
            if let error = error {
                print("Error occured during log in: \(error)")
            }
            //Close modal if no error
            else {
                DispatchQueue.main.async{
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
