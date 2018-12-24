//
//  PointsofInterest.swift
//  WeatherApplication
//
//  Created by pazl992 on 22.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit
import MapKit
class PointOfCity: NSObject {
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
    
}



