//
//  LogonViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 14/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "Log In"
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = ""
    }
    

    @IBAction func loginButtonTapped(_ sender: LineButton) {
        handelLogin()
    }
    
    func handelLogin() {
        guard let emailAddress = emailTextField.text, emailAddress != "",
        let password = passwordTextField.text, password != "" else {
            let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)

            return
        }
        
    
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            if let error = error {
                print("Error loging in - \(#function): \(error) \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            self.view.endEditing(true)
            
            if let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = mainController
                self.dismiss(animated: true, completion: nil)
            }
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
