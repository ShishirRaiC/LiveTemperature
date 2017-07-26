//
//  ViewController.swift
//  LiveTemperature
//
//  Created by Sudeep Tuladhar on 7/26/17.
//  Copyright © 2017 Kent State University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class ViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    var ref: DatabaseReference!
    var inFarhenhiet = true
    var currentTemp = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.tempLabel.text = "Waiting..."
        self.ref.child("temp").child("current").observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.currentTemp = postDict["value"]! as! Double
            self.tempLabel.text = String(describing: "\(self.getCorrectTemp())")
            self.adjustBackground()
        }
        
        ref.child("temp").child("current").observe(DataEventType.value) { (snapshot : DataSnapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.currentTemp = postDict["value"]! as! Double
            self.tempLabel.text = String(describing: "\(self.getCorrectTemp())")
            self.adjustBackground()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.adjustBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func weatherFormatChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            inFarhenhiet = true
            break;
        case 1:
            inFarhenhiet = false
            break;
        default:
            break;
        }
        self.tempLabel.text = String(describing: "\(self.getCorrectTemp())")
    }
    
    fileprivate func getCorrectTemp() -> String{
        if(inFarhenhiet){
            return String(format: "%.2f ℉", currentTemp)
        }else{
            return String(format: "%.2f ℃", (currentTemp - 32)*(5/9))
        }
    }
    
    fileprivate func adjustBackground(){
        if(currentTemp == 0.0){
            return
        }
        
        if(currentTemp < MyUserDefaults().getMinTemp()){
            UIView.animate(withDuration: 1, animations: {
                    self.view.backgroundColor = UIColor.minTempColor
            })
        }else if(currentTemp > MyUserDefaults().getMaxTemp()){
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = UIColor.maxTempColor
            })
        }else{
            UIView.animate(withDuration: 1, animations: {
                self.view.backgroundColor = UIColor.normalTempColor
            })
        }
    }
    
}


extension UIColor {
    
    
    open class var minTempColor: UIColor {
        get{
            return UIColor(hexString: "#3498db")
        }
    }
    
    open class var maxTempColor: UIColor {
        get{
            return UIColor(hexString: "#e74c3c")
        }
    }
    
    open class var normalTempColor: UIColor {
        get{
            return UIColor(hexString: "#2ecc71")
        }
    }
    
    
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String in "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /**
     Creates an UIColor Object based on provided RGB value in integer
     - parameter red:   Red Value in integer (0-255)
     - parameter green: Green Value in integer (0-255)
     - parameter blue:  Blue Value in integer (0-255)
     - returns: UIColor with specified RGB values
     */
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
}
