//
//  AcceptViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-04.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse

class AcceptViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(MyVars.objectid)

        let query = PFQuery(className: "People")
        query.whereKey("objectId", equalTo: MyVars.objectid)
        query.findObjectsInBackground { (objects, error) in
            if let people = objects {
                for person in people {
                    self.name.text = "You have matched with \(person["name"]!)!"
                    self.gate.text = "Meet at gate \(person["gate"]!)!"
                    self.time.text = "Be there by \(person["time"]!)!"
                }
            }
        }
        
    }
    @IBOutlet weak var gate: UILabel!
    
    @IBAction func accept(_ sender: Any) {
        let query = PFQuery(className: "People")
        query.whereKey("objectId", equalTo: MyVars.objectid)
        query.findObjectsInBackground { (objects, error) in
            if let people = objects {
                for person in people {
                    person.deleteInBackground()
                }
            }
        }
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
