//
//  WeatherGetter.swift
//  WeatherApplication
//
//  Created by pazl992 on 22.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//
import Foundation
import MapKit
class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/"
    private let openWeatherMapAPIKey = "51c0833df7fc7137858579a19c851932"
    
    func getWeatherFor(CitiesIds: [NSNumber], withCompletion completion: @escaping (([String:AnyObject]) -> Void)) {
        //http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
        let arrayWithIds : NSArray = CitiesIds as NSArray
        let stringWithIds : String = arrayWithIds.componentsJoined(by: ",")
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)group?APPID=\(openWeatherMapAPIKey)&id=\(stringWithIds)&units=metric")!
        self.getWeatherWith(weatherRequestURL: weatherRequestURL, withCompletion: {
            (response) in
            
            completion(response)
        })
    }
    func getWeatherForDays(CityId: NSNumber, withCompletion completion: @escaping (([String:AnyObject]) -> Void)) {
        //api.openweathermap.org/data/2.5/forecast?
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)forecast?APPID=\(openWeatherMapAPIKey)&id=\(CityId)")!
        self.getWeatherWith(weatherRequestURL: weatherRequestURL, withCompletion: {
            (response) in
            completion(response)
        })
    }
    func getWeatherWith(weatherRequestURL: URL, withCompletion completion: @escaping (([String:AnyObject]) -> Void)) {
        let session = URLSession.shared
    
        print("url = \(weatherRequestURL)")
        
        let request: NSURLRequest = NSURLRequest(url: weatherRequestURL as URL)
       // var response: URLResponse?
        
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            let defaultResult : [String:AnyObject] = ["error" :"no connection" as AnyObject]
            var result : [String:AnyObject] = defaultResult
            if error != nil{
                return
            }
            do {
                result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] ?? defaultResult
                
                print("Result",result)
                
            } catch {
                print("Error -> \(error)")
            }
            completion(result)
            
        })
        task.resume()

    }
}
