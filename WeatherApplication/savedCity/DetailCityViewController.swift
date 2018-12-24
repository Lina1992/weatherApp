//
//  DelailCityViewController.swift
//  WeatherApplication
//
//  Created by pazl992 on 23.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit

class DetailCityViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createDesign()
        self.reloadCollectionView()
    }
    func createDesign()
    {
        print("cityToShow",cityToShow)
        self.title = cityToShow?.cityName
    }
    //кнопки переключатели
    @IBOutlet weak var daysSegmentedControl: UISegmentedControl!
    @IBAction func daysSegmentedControlValueChanged(_ sender: Any) {
        self.getInfoForCollectionView()
    }
    var cityToShow : City!
    //загрузка данных для коллекции
    func reloadCollectionViewBySegmentControl()
    {
        self.collectionView.reloadData()
    }
    
    func getInfoForCollectionView()
    {
        let weather = WeatherGetter()
        weather.getWeatherForDays(CityId: cityToShow.cityCode,  withCompletion: {
            (response) in
            DispatchQueue.main.async {
                //arrayWithWeather=response.va
                self.collectionView.reloadData()
            }
        })
    }
    var arrayWithWeather : NSArray = NSArray.init()
    
    //рисуем коллекцию
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayWithWeather.count
    }
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDayCellIdentifer",
                                                      for: indexPath) as! weatherDayCollectionViewCell
        cell.configure(with: arrayWithWeather[indexPath.row] as! NSDictionary)
        return cell
    }
}
