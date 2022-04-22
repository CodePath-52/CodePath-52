//
//  RatingViewController.swift
//  CodePath-52
//
//  Created by Zainab Rizvi on 20/04/2022.
//

import UIKit
import Parse
import MessageInputBar

class RatingViewController: UIViewController, MessageInputBarDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctor = doctors[indexPath.section]
        let ratings = (doctor["ratings"] as? [PFObject]) ?? []
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        let rating = ratings[indexPath.row - 1]
        cell.reviewLabel.text = rating["description"] as? String
        
        let user = rating["ratingUser"] as! PFUser
        cell.nameLabel.text = user.username
        return cell
    }
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func onSubmit(_ sender: Any) {
        let rating = PFObject(className: "Rating")
        rating["rating"] = Int(ratingTextField.text!)
        if reviewTextField.text != nil {
            rating["description"] = reviewTextField.text!
        }
        rating["title"] = titleTextField.text!
        rating["ratingDoctor"] = selectedDoctor
        rating["ratingUser"] = PFUser.current()!
        
        rating.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error")
            }
        }
        ratingTextField.text = nil
        reviewTextField.text = nil
        titleTextField.text = nil
        
        selectedDoctor.add(rating, forKey: "rating")
        
        selectedDoctor.saveInBackground { (success, error) in
                    if success {
                        print("rating saved")
                    } else {
                        print("failed to save rating")
                    }
                }
                tableView.reloadData()
    }
    
    var doctors = [PFObject]()
    var selectedDoctor: PFObject!
    let reviewBar = MessageInputBar()
    var showsReviewBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selectedDoctor["name"] as? String
        ratingLabel.text = selectedDoctor["rating"] as? String
        typeLabel.text = selectedDoctor["type"] as? String
        sexLabel.text = selectedDoctor["sex"] as? String
        phoneLabel.text = selectedDoctor["phone"] as? String
        websiteLabel.text = selectedDoctor["website"] as? String // need to hyperlink
        hoursLabel.text =  selectedDoctor["hours"] as? String
        locationLabel.text =  selectedDoctor["location"] as? String
        
        
        // dummy values:
//        nameLabel.text = "Very Cool Doctor"
//        ratingLabel.text = "4/5"
//        typeLabel.text = "Dentist"
//        sexLabel.text = "Female"
//        phoneLabel.text = "(123) 456-7890"
//        websiteLabel.text = "bestdoctor.com" // need to hyperlink
//        hoursLabel.text =  "9-5"
//        locationLabel.text =  "(0,0)"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Doctor")
        query.includeKeys(["ratings", "rating.userRating"])
        query.limit = 20
        query.findObjectsInBackground { [self] (doctors, error) in
            if doctors != nil {
                self.doctors = doctors!
                self.tableView.reloadData()
            }
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
