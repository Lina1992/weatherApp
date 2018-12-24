//
//  PointOfInterestAnnotation.swift
//  WeatherApplication
//
//  Created by pazl992 on 22.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit
import MapKit

class PointOfCityAnnotation: NSObject ,MKAnnotation {
    
    let pointOfCity: PointOfCity
    var coordinate: CLLocationCoordinate2D { return pointOfCity.coordinate }
    var temperature: NSString = "идет загрузка..."
    
    init(point: PointOfCity) {
        self.pointOfCity = point
        super.init()
    }
    
    var title: String? { return pointOfCity.name }
    var subtitle: String? {
        return temperature as String
    }
    
    //находим информацию о температуре из словаря
    func temperatureDataFrom (dictionry: NSDictionary)
    {
        self.temperature = self.findTemperatureDataFrom(dictionry: dictionry) as NSString
    }
    
    func findTemperatureDataFrom (dictionry: NSDictionary) -> String
    {
        var temperatureString : String = "ошибка"
        
        let mainDictionry : NSDictionary = dictionry.value(forKey: "main") as! NSDictionary
        temperatureString = "\(mainDictionry.value(forKey: "temp") ?? "ошибка")"
        
        return temperatureString
    }

}
