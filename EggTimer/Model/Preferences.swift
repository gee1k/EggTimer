//
//  Preferences.swift
//  EggTimer
//
//  Created by Svend Jin on 2019/5/30.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Foundation

struct Preferences {
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            
            return 360
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
