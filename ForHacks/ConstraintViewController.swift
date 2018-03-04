//
//  ConstraintViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-03.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

struct MyVars {
    static var myLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    static var myAirport: String = "None"
}

class ConstraintViewController: UIViewController {

    @IBOutlet weak var airport: UITextField!
    @IBOutlet weak var destination: UITextField!
    
    @IBAction func save(_ sender: Any) {
        
        let geoCoder = CLGeocoder()
        
        if let address = destination.text{
            
            geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                if let placemark = placemarks?[0] {
                    
                    MyVars.myLocation = placemark.location!
                    MyVars.myAirport = self.airport.text!

                }
            })
            
        }
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        PFUser.logOut()
        performSegue(withIdentifier: "goHome", sender: self)
        
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
