import UIKit
import AlamofireImage
import Parse

// for geolocation
import MapKit
import CoreLocation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
	
	let locationManager = CLLocationManager()

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
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
		print("locations = \(locValue.latitude) \(locValue.longitude)")
		guard let location: CLLocation = manager.location else { return }
		fetchCityAndCountry(from: location) { city, country, error in
			guard let city = city, let country = country, error == nil else { return }
			print(city + ", " + country)
		}
	}
	
	func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
		CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
			completion(placemarks?.first?.locality,
					   placemarks?.first?.country,
					   error)
		}
	}
	
	@objc func showNewSymptoms() {
		let user = PFUser.current()!
		
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
	
	override func viewDidAppear(_ animated: Bool) {
		// super.viewDidAppear(animated)
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			self.showNewSymptoms()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.requestAlwaysAuthorization()
		// locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
		
		let user = PFUser.current()!
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
