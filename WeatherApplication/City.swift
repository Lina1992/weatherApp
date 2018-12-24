//
//  City.swift
//  WeatherApplication
//
//  Created by pazl992 on 21.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class City: NSObject,NSCoding {
    //для правильного отображения нужны имя и координаты города, id необходим для отправки на сервер
    var cityName: String = ""
    var cityCode: NSNumber = 0
    var cityCoordinate: CLLocationCoordinate2D
    init(cityName: String, cityCode:NSNumber, cityCoordinate:CLLocationCoordinate2D) {
        self.cityName = cityName
        self.cityCode=cityCode
        self.cityCoordinate = cityCoordinate
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        print("encodeWithCoder")
        aCoder.encode(cityName, forKey: "cityName")
        
        aCoder.encode(cityCode, forKey: "cityCode")
        
        //проблемы с кодированием CLLocationCoordinate2D по-этому собираем и разбираем на  lat и lng
        var latitude : NSNumber
        latitude = NSNumber(value: cityCoordinate.latitude)
        var longitude : NSNumber
            longitude = NSNumber(value: cityCoordinate.longitude)
        
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        print("decodeWithCoder")
        guard let unarchivedName = aDecoder.decodeObject(forKey: "cityName") as? String
            else {
                return nil
        }
        guard let unarchivedCode = aDecoder.decodeObject(forKey: "cityCode") as? NSNumber
            else {
                return nil
        }
        //проблемы с кодированием CLLocationCoordinate2D по-этому собираем и разбираем на  lat и lng
        guard let unarchivedCoordinateLatitude = aDecoder.decodeObject(forKey: "latitude") as? NSNumber
            else {
                return nil
        }
        guard let unarchivedCoordinateLongitude = aDecoder.decodeObject(forKey: "longitude") as? NSNumber
            else {
                return nil
        }
        self.init(cityName: unarchivedName , cityCode: unarchivedCode,  cityCoordinate:CLLocationCoordinate2DMake(CLLocationDegrees(truncating: unarchivedCoordinateLatitude),CLLocationDegrees(truncating: unarchivedCoordinateLongitude)))
    }
    
    // NSKeyedUnarchiver
    
    private class func getFileURL() -> URL {
        let documentsDirectory = FileManager().urls(for: (.documentDirectory), in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Cities")
        
        return archiveURL
    }
    
    class func saveCitiesToDisk(cities: [City]) {
       // NSData* data=[NSKeyedArchiver archivedDataWithRootObject:City];
        let success = NSKeyedArchiver.archiveRootObject(cities, toFile: City.getFileURL().path)
        if !success {
            print("failed to save")
        }
    }
    
    class func loadCitiesFromDisk() -> [City]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: City.getFileURL().path) as? [City]
    }
    

}
