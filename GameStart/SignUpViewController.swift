//
//  SignUpViewController.swift
//  GameStart
//
//  Created by user on 29/07/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignUpViewController: UIViewController {

    // MARK: - variables
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    @IBAction func signUp(_ sender: UIButton) {
        
        if password.text != repassword.text{
            
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){(user,error) in
                if error == nil {
                    debugPrint("nil 's not perfoeme the segue")
                    self.performSegue(withIdentifier: "SignupToLoading", sender: self)
                }else{
                    debugPrint("we got an error over here")
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
            email.text = ""
            password.text = ""
            repassword.text = ""
            
        }
//        else{
//            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
//                if error == nil {
//                    self.performSegue(withIdentifier: "signupToHome", sender: self)
//                }
//                else{
//                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//
//                    alertController.addAction(defaultAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            }
//        }
        
        //debugPrint("not clicked")
    }
    
    
    @IBAction func showHidePWD(_ sender: UIButton) {
        debugPrint("clicked for password")
        password.isSecureTextEntry = sender.isSelected
        debugPrint("clicked for reppasword")
        repassword.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
        
    }
    

}
