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
    
    var done = false
    var name0: String = ""
    var time0: String = ""
    var gate0: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        if done == true {
            print("completed")
            print(name0)
            print(time0)
            print(gate0)
            
            name.text = name0
            gate.text = gate0
            time.text = time0
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(MyVars.objectid)

        let query = PFQuery(className: "People")
        query.whereKey("objectId", equalTo: MyVars.objectid)
        query.findObjectsInBackground { (objects, error) in
            if let people = objects {
                for person in people {
                    self.name.text = "You have matched with \(person["name"]!)!"
                    self.name0 = self.name.text!
                    self.gate.text = "Meet at gate \(person["gate"]!)!"
                    self.gate0 = self.gate.text!
                    self.time.text = "Be there by \(person["time"]!)!"
                    self.time0 = self.time.text!
                    self.done = true
                }
                self.name0 = self.name.text!
                self.gate0 = self.gate.text!
                self.time0 = self.time.text!
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
                    
                    MyVars.status = true
                    
                    let accept = PFObject(className: "Acceptances")
                    
                    accept["poster"] = person["userid"]
                    accept["clicker"] = PFUser.current()?.objectId
                    accept["gate"] = person["gate"]
                    accept["time"] = person["time"]
                    
                    accept.saveInBackground()
                    
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
