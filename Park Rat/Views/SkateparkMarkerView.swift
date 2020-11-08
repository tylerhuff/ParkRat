//
//  SkateparkMarkerView.swift
//  Park Rat
//
//  Created by Tyler Huff on 11/6/20.
//  Copyright © 2020 Tyler Huff. All rights reserved.
//

import UIKit
import MapKit

class SkateparkMarkerView: NSObject, MKAnnotation {
    
    let parkInfo : Skatepark
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var markerTintColor = UIColor.blue

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, parkInfo: Skatepark) {
            self.title = title
            self.coordinate = coordinate
            self.info = info
            self.parkInfo = parkInfo    
        }
}


class VisitedSkateparkMarkerView: NSObject, MKAnnotation {
    
    let parkInfo : Skatepark
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var markerTintColor = UIColor.blue

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, parkInfo: Skatepark) {
            self.title = title
            self.coordinate = coordinate
            self.info = info
            self.parkInfo = parkInfo
        }
}
