//
//  ViewController.swift
//  WeatherApplication
//
//  Created by pazl992 on 21.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        self.loadPointsOfCities()
        self.showPointsOfCitiesInMap()
        // fixed user location at latitude: 55.751244,37.618423
        self.centerMapIn(coordinates: CLLocationCoordinate2DMake(55.751244,37.618423))
        
    }
    func centerMapIn(coordinates :CLLocationCoordinate2D) {
        
        mapView.setCenter(coordinates, animated: true)
        let visibleRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }
    
    var poi: [PointOfCity] = []
    
    func loadPointsOfCities() {
        var citiesArray : NSMutableArray = NSMutableArray.init()
        let citiesIdsArray : NSMutableArray = NSMutableArray.init()
        let del :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        citiesArray = del.citiesArray
        for city  in citiesArray
        {
            if let myCity = city as? City {
                
                let point = PointOfCity (name: myCity.cityName, coordinate: myCity.cityCoordinate)
                poi.append(point)
                citiesIdsArray .add(myCity.cityCode)
            }
        }
       // DispatchGroup.performSelector(inBackground: Selector(loadWeatherFor(CitiesIds:)), with: citiesIdsArray as! [NSNumber])
        self.loadWeatherFor(CitiesIds: citiesIdsArray as! [NSNumber])
    }
    //загружаем данные о погоде (сейчас, из списка id городов)
    func loadWeatherFor(CitiesIds:[NSNumber])
    {
        let weather = WeatherGetter()
        weather.getWeatherFor(CitiesIds: CitiesIds, withCompletion: {
            (response) in
            //заменяем строчки температуры из полученных с сервера данных
            DispatchQueue.main.async {
                
                let responseDictionry : NSDictionary = response as NSDictionary
                let listDictionry : NSArray = responseDictionry.value(forKey: "list") as! NSArray
                var i = 0
                for point in self.mapView.annotations
                {
                    let pin = point as! PointOfCityAnnotation
                    let dictionary : NSDictionary = listDictionry.object(at: i) as! NSDictionary
                    pin.temperatureDataFrom(dictionry: dictionary)
                    i=i+1 //города отдаются в той же последовательности что оправлены на сервер, так что можно не проверять на сходство id города
                }
            }
            })
    }
    
    func showPointsOfCitiesInMap() {
        mapView.removeAnnotations(mapView.annotations)
        
        for point in poi {
            let pin = PointOfCityAnnotation(point: point)
            mapView.addAnnotation(pin)
        }
    }

}

