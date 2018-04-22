//
//  SettingVCTableViewController.swift
//  LiveTemperature
//
//  Created by Sudeep Tuladhar on 7/26/17.
//  Copyright © 2017 Kent State University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SettingVCTableViewController: UITableViewController {
    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        minTempTextField.text = "\(MyUserDefaults().getMinTemp())"
        maxTempTextField.text = "\(MyUserDefaults().getMaxTemp())"
        
        self.ref.child("setting").observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            if(postDict != nil){
                if let minTemp = postDict!["minThreshold"]{
                    self.minTempTextField.text = "\(minTemp)"
                }
                if let maxTemp = postDict!["maxThreshold"]{
                    self.maxTempTextField.text = "\(maxTemp)"
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func minTempChanged(_ sender: UITextField) {
        self.ref.child("setting").updateChildValues(["minThreshold": Double(sender.text!)!])
    }
    
    @IBAction func maxTempChanged(_ sender: UITextField) {
        self.ref.child("setting").updateChildValues(["maxThreshold": Double(sender.text!)!])
    }
}
