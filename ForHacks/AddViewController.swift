//
//  AddViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-03.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var airport: UITextField!
    @IBOutlet weak var destination: UITextField!
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        
        if textField.text == "" || airport.text == "" || destination.text == "" {
            displayAlert(title: "Oops! Something went wrong.", message: "You need to fill everything out!")
        }
        else{
            
            let geoCoder = CLGeocoder()
            
            if let address = destination.text{
                
                geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?[0] {
                        
                        let coordinates: CLLocation = placemark.location!
                        let latitude = coordinates.coordinate.latitude
                        let longitude = coordinates.coordinate.longitude
                        
                        let people = PFObject(className: "People")
                        people["name"] = self.textField.text
                        people["airport"] = self.airport.text
                        people["destination"] = self.destination.text
                        people["userid"] = PFUser.current()?.objectId
                        people["latitude"] = latitude
                        people["longitude"] = longitude
                        
                        people.saveInBackground(block: { (success, error) in
                            
                            if success == true {
                                
                                self.displayAlert(title: "User added!", message: "Your user has been added successfully.")
                                self.textField.text = ""
                            }
                            else{
                                self.displayAlert(title: "Uh oh!", message: "We couldn't add a user.")
                            }
                        })
                        
                    }
                })
                
            }
        
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
