//
//  Skatepark.swift
//  Park Rat
//
//  Created by Tyler Huff on 11/3/20.
//  Copyright © 2020 Tyler Huff. All rights reserved.
//

import Foundation
import CoreLocation

struct Skatepark {
    
    let name: String
    let city: String
    
    let lights: Bool
    let safetyGearRequired: Bool
    let type: String
    let visited: Bool
    
    var address : String
    let latitude : CLLocationDegrees
    let longitude : CLLocationDegrees
 
}
