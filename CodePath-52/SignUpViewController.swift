//
//  SignUpViewController.swift
//  CodePath-52
//
//  Created by Zainab Rizvi on 13/04/2022.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {


    @IBOutlet weak var symptoms: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
        
    @IBAction func onRegister(_ sender: Any) {
        if (password.text != passwordConfirmation.text) {
            let alert = UIAlertController(title: "Passwords do not match", message: "Please re-enter your password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
                self.present(alert, animated: true, completion: nil)
            
        } else {
            let user = PFUser()
            user.username = username.text!
            user.password = password.text!
            user["age"] = Int(age.text!)
            user["sex"] = sex.text!
            user["symptoms"] = symptoms.text!.components(separatedBy: ", ")
            user.signUpInBackground {(success, error) in
                if success {
                    self.performSegue(withIdentifier: "signedUpSegue", sender: nil)
                } else {
                    print("Error: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
