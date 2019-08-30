//
//  LoginInViewController.swift
//  GameStart
//
//  Created by user on 29/07/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginInViewController: UIViewController {

    // MARK :- Variables
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Functions
    @IBAction func loginIn(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                debugPrint("login with success")
                self.performSegue(withIdentifier: "LoginToLoading", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        password.text = ""
        email.text = ""
    }
    
    @IBAction func showHidePWD(_ sender: UIButton) {
       
        password.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
}
