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
    @IBOutlet weak var signupButton: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        
        switch selectedSegmentIndex{
        case  0:
            loginType = .signup
            loginButton.setTitle(loginType.rawValue, for: .normal)
        case 1:
            loginType = .login
            loginButton.setTitle(loginType.rawValue, for: .normal)
        default:
            break
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        guard let username = usernameLabel.text, !username.isEmpty else { return }
        guard let password = passwordLabel.text, !password.isEmpty else { return }
        
        let user = User(username: username, password: password)
        
        switch loginType{
        case .login:
            break
        case .signup:
            gigController.signUp(with: user) { (error) in
                //Check for errors
                if let errorOccured = error {
                    print("Error occured during sign up: \(error)")
                }
                else {
                    //take credientials and sign in 
                }
                
            }
        default:
            break
        }
    }
}
