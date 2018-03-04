//
//  TableViewController.swift
//  ForHacks
//
//  Created by Gary Hicks on 2018-03-03.
//  Copyright © 2018 Gary Hicks. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class TableViewController: UITableViewController {
    
    var airport = [String]()
    var destinations = [String]()
    var latitude = [Double]()
    var longitude = [Double]()
    var toDelete = [Int]()
    var objectid = [String]()
    
    /*override func viewDidAppear(_ animated: Bool) {
        
        var count = 0
        
        for theAirport in airport {
            if (MyVars.myAirport != "None") && (MyVars.myAirport != theAirport) {
                airport.remove(at: count)
                destinations.remove(at: count)
                latitude.remove(at: count)
                longitude.remove(at: count)
            }
            count+=1
            //print(destinations)
        }
        
        //print(destinations)
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "People")
        query.whereKey("destination", notEqualTo: "")
        query.findObjectsInBackground { (objects, error) in
            if let people = objects {
                for person in people {
                    self.destinations.append(person["destination"] as! String!)
                    self.airport.append(person["airport"] as! String!)
                    self.latitude.append(person["latitude"] as! Double)
                    self.longitude.append(person["longitude"] as! Double)
                    self.objectid.append((person.objectId)!)
                    
                    /*let latdif = (self.latitude[self.latitude.count-1]-MyVars.myLocation.coordinate.latitude)*(self.latitude[self.latitude.count-1]-MyVars.myLocation.coordinate.latitude)
                    let longdif = (self.longitude[self.longitude.count-1]-MyVars.myLocation.coordinate.longitude)*(self.longitude[self.longitude.count-1]-MyVars.myLocation.coordinate.longitude)*/
                    
                    
                    //print(self.destinations)
                }
                var count = 0
                for theAirport in self.airport {
                    
                    let latdif = (self.latitude[count]-MyVars.myLocation.coordinate.latitude)*(self.latitude[count]-MyVars.myLocation.coordinate.latitude)
                    let longdif = (self.longitude[count]-MyVars.myLocation.coordinate.longitude)*(self.longitude[count]-MyVars.myLocation.coordinate.longitude)
                    //print((latdif+longdif).squareRoot())
                    //print(self.destinations[count])
                    
                    if (MyVars.myAirport != "None") && ((MyVars.myAirport != theAirport) || (latdif+longdif).squareRoot()>0.1){
                        self.airport.remove(at: count)
                        self.destinations.remove(at: count)
                        self.latitude.remove(at: count)
                        self.longitude.remove(at: count)
                        self.objectid.remove(at: count)
                        count-=1
                    }
                    count+=1
                    print(self.destinations)
                }
                self.tableView.reloadData()
                self.tableView.tableFooterView = UIView()
                //print(self.destinations)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return destinations.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if MyVars.myAirport == "None" {
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.text = "\(destinations[indexPath.row])"
            return cell
        }
     
        else if MyVars.myAirport == airport[indexPath.row]{
            cell.textLabel?.numberOfLines = 0;
            cell.textLabel?.text = "\(destinations[indexPath.row])"
            return cell
        }
        
     return cell
     }
    
    var activeRow = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        MyVars.objectid = objectid[activeRow]
        print(MyVars.objectid)
        
        self.performSegue(withIdentifier: "toAccept", sender: self)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
