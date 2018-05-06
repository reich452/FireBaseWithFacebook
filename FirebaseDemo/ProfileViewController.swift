//
//  ProfileViewController.swift
//  FirebaseDemo
//
//  Created by Simon Ng on 6/1/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func logOutButtonTapped(_ sender: LineButton) {
        handelLogout()
    }
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        title = "My Profile"
        if let currentUser = Auth.auth().currentUser {
            nameLabel.text = currentUser.displayName
        }
    }
    
    func handelLogout() {
        do {
            try Auth.auth().signOut()
        } catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            print("Error with sign out \(error) \(error.localizedDescription)")
            return
        }
        if let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = welcomeVC
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


