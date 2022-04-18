//
//  EditSymptomsViewController.swift
//  CodePath-52
//
//  Created by Eric Tang on 4/17/22.
//

import UIKit
import Parse

class EditSymptomsViewController: UIViewController {

	@IBOutlet weak var symptomsField: UITextField!
	@IBAction func onSubmit(_ sender: Any) {
		
		let user = PFUser.current()!
		
		user["symptoms"] = symptomsField.text?.components(separatedBy: ", ")
		
		user.saveInBackground{(success, error) in
			if success {
				
				// want to return to the profile view controller
				self.dismiss(animated: true, completion: nil)
				print("New symptoms saved!")
			}
			else {
				print("error saving new symptoms!")
			}
		}
		
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
