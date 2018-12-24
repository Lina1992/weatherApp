//
//  SavedCityViewController.swift
//  WeatherApplication
//
//  Created by pazl992 on 21.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit

class SavedCityViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewWithCity: UITableView!
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.navigationController?.dismiss(animated: false, completion: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewWithCity.delegate=self
        self.tableViewWithCity.dataSource=self
        self.createCitiesArray()
    }
    var selectedCity :City!
    var citiesArray : NSMutableArray = []
    func createCitiesArray(){
        citiesArray = NSMutableArray.init()
        let del :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        citiesArray = del.citiesArray
    }
    
    // table view stuffs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city : City = citiesArray.object(at: indexPath.row) as! City
        let cell =  tableView.dequeueReusableCell(withIdentifier: "savedCityCell")! as UITableViewCell
        cell.textLabel?.text = city.cityName
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("dalete cell at index path ",indexPath.row)
            citiesArray.removeObject(at: indexPath.row)
            self.tableViewWithCity.deleteRows(at: [indexPath], with: .automatic)
            //delete from file here
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity=citiesArray.object(at: indexPath.row) as? City
        self.performSegue(withIdentifier: "detailPushFromSavedCityStoryboardSegueId", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPushFromSavedCityStoryboardSegueId"
        {
            let controller = segue.destination as! DetailCityViewController
            controller.cityToShow = self.selectedCity
        }
    }

}
