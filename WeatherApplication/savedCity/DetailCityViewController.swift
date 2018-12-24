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

    @IBOutlet weak var daysSegmentedControl: UISegmentedControl!
    @IBAction func daysSegmentedControlValueChanged(_ sender: Any) {
        self.reloadCollectionView()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    //weatherDayCellIdentifer
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createDesign()
    }
    
    var cityToShow : City!
    func createDesign()
    {
        print("cityToShow",cityToShow)
        self.title = cityToShow?.cityName
    }
    func reloadCollectionView()
    {
        if(self.daysSegmentedControl.selectedSegmentIndex==0)
        {
            self.reloadCollectionView(daysNumber: 3)
        }
        else
        {
            self.reloadCollectionView(daysNumber: 7)
        }
    }
    func reloadCollectionView(daysNumber:NSInteger)
    {
        
    }
}
