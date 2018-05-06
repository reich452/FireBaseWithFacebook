//
//  ResetPasswordViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 5/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: LineButton) {
        handelResetPassword()
    }
    
    func handelResetPassword() {
        guard let emailAddressTextField = emailTextField.text,
            emailAddressTextField != "" else { return }
        
        Auth.auth().sendPasswordReset(withEmail: emailAddressTextField) { (error) in
            if let localError = error {
                print("Error with reset \(String(describing: localError)) \(String(describing: localError.localizedDescription))")
            }
            let title = (error == nil) ? "Password Rest Follow - UP" : "Password Reset Error"
            let message = (error == nil) ? "We have just sent you a reset email. Please check your inbox and follow the instructions to rese your password" : error?.localizedDescription
            
            let alertCOntroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                if error == nil {
                    self.view.endEditing(true)
                }
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
                
            })
            alertCOntroller.addAction(okayAction)
            self.present(alertCOntroller, animated: true, completion: nil)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
