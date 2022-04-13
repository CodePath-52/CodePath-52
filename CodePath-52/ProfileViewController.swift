import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var imageSet = false
	@IBOutlet weak var profilePic: UIImageView!
	@IBAction func onSubmitButton(_ sender: Any) {
		
		let user = PFUser.current()!
		let imageData = profilePic.image!.pngData()
		// binary object of the image
		let file = PFFileObject(name: "profilePic.png", data: imageData!)
		
		// contains the URL to the image
		user["profilePic"] = file
		
		user.saveInBackground{(success, error) in
			if success {
				// want to return to the feed view
				self.imageSet = true
				print("Profile picture saved!")
			}
			else {
				print("error saving profile picture!")
			}
		}
	}
	
	@IBAction func onLogout(_ sender: Any) {
		PFUser.logOut()
		let main = UIStoryboard(name: "Main", bundle: nil)
		let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
		// get window from sceneDelegate
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
		delegate.window?.rootViewController = loginViewController
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if imageSet {
			self.tabBarController?.selectedIndex = 1
		}
	}
	
	@IBAction func onCameraButton(_ sender: Any) {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			picker.sourceType = .camera
		}
		else {
			picker.sourceType = .photoLibrary
		}
		
		present(picker, animated: true, completion: nil)
	}
	
	@IBOutlet weak var ageLabel: UILabel!
	@IBOutlet weak var sexLabel: UILabel!
	@IBOutlet weak var symptomsLabel: UILabel!
	
	@IBAction func editSymptomsButton(_ sender: Any) {
		self.performSegue(withIdentifier: "editSymptomsSegue", sender: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		let image = info[.editedImage] as! UIImage
		let size = CGSize(width: 300, height: 300)
		let scaledImage = image.af.imageAspectScaled(toFill: size)
		
		profilePic.image = scaledImage
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let user = PFUser.current() as! PFUser
		let ageNum = user["age"] as! Int
		
		self.ageLabel.text = String(ageNum);
		self.sexLabel.text = user["sex"] as? String
		let symptomList = user["symptoms"] as? [String]
		
		var symptomString = "";
		if symptomList != nil {
			for i in 1...symptomList!.count {
				if i != symptomList!.count {
					symptomString = "\(symptomString)\(symptomList![i-1]), "
				}
				else {
					symptomString = "\(symptomString)\(symptomList![i-1])"
				}
			}
			self.symptomsLabel.text = symptomString
		}
	}
}
