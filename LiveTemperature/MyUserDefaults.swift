//
//  MyUserDefaults.swift
//  Blackboard
//
//  Created by Sudeep Tuladhar on 6/26/17.
//  Copyright © 2017 Kent Displays Inc. All rights reserved.
//

import Foundation


class MyUserDefaults{
    
    private let userDefault = UserDefaults.standard
    
    private let MIN_TEMP = "min_temp"
    private let MAX_TEMP = "max_temp"

    func getMinTemp() -> Double{
        if let newSave = userDefault.object(forKey: MIN_TEMP) as? Double{
            return newSave
        }else{
            return 32.00
        }
    }
    
    func setMinTemp(temp : Double){
        userDefault.set(temp, forKey: MIN_TEMP)
    }
    
    
    func getMaxTemp() -> Double{
        if let newSave = userDefault.object(forKey: MAX_TEMP) as? Double{
            return newSave
        }else{
            return 100.00
        }
    }
    
    func setMaxTemp(temp : Double){
        userDefault.set(temp, forKey: MAX_TEMP)
    }
}
