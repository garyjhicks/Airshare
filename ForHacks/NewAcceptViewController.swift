//
//  NewAcceptViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-04.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse

class NewAcceptViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gate: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        if MyVars.status==true{
            performSegue(withIdentifier: "toAccept", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let query = PFQuery(className: "Acceptances")
        query.whereKey("poster", equalTo: PFUser.current()?.objectId as Any)
        query.findObjectsInBackground { (objects, error) in
            if let acceptances = objects {
                for accept in acceptances {
                    //self.name.text = "You have matched with \(accept["clicker"]!)!"
                    let find = PFUser.query()
                    find?.whereKey("objectId", equalTo: accept["clicker"])
                    find?.findObjectsInBackground(block: { (objects, error) in
                        if let people = objects {
                            for person in people {
                                self.name.text = "You have matched with \(person["username"]!)!"
                            }
                        }
                    })
                    self.gate.text = "Meet at gate \(accept["gate"]!)!"
                    self.time.text = "Be there by \(accept["time"]!)!"
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
