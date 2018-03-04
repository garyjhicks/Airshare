//
//  ViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-03.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Login(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!, block: { (user, error) in
            
            if user != nil {
                print("Login successful")
                self.performSegue(withIdentifier: "showUserTable", sender: self)
            }
            else{
                if error != nil {
                    self.displayAlert(title: "Oops! Something went wrong.", message: (error?.localizedDescription)!)
                }
            }
        })
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = username.text
        user.password = password.text
        
        user.signUpInBackground(block: { (success, error) in
            if error != nil {
                self.displayAlert(title: "Oops! Something went wrong.", message: (error?.localizedDescription)!)
            } else {
                print("Signed up")
                self.performSegue(withIdentifier: "showUserTable", sender: self)
                
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MyVars.status = false
        
        
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
