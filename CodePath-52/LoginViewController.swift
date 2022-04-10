import UIKit
import Parse

class LoginViewController: UIViewController {
	
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBAction func onSignIn(_ sender: Any) {
		
		let username = usernameField.text!
		let password = passwordField.text!
		PFUser.logInWithUsername(inBackground: username, password: password) {
			(user, error) in
			if user != nil {
				self.performSegue(withIdentifier: "loginSegue", sender: nil)
			}
			else {
				print("Error: \(error?.localizedDescription)")
			}
		}
	}
	
	@IBAction func onSignUp(_ sender: Any) {
		
		self.performSegue(withIdentifier: "signupSegue", sender: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
