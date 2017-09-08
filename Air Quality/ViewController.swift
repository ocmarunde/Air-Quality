//
//  ViewController.swift
//  Air Quality
//
//  Created by Olivia Marunde on 8/28/17.
//  Copyright © 2017 Olivia Marunde. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ci
         var cityArray = [city1, city2, city3, city4, city5]
    }
    
    @IBAction func onSearchButtonPressed(_ sender: UIButton)
    {
        if let city = textField.text
        {
            getJSONData(city: city)
        }
            
        else
        {
            print("Error")
        }
    }
    
    func getJSONData(city: String)
    {
        let urlString = "http://http://api.airvisual.com//v2/city?country=usa&state=\(state)&city=\(city)&key=P4GBg9iaHxi8zauQx"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url, completionHandler: { (myData, response, error) in
            if let JSONObject = try? JSONSerialization.jsonObject(with: myData!, options: .allowFragments) as! NSDictionary {
                
                self.data = [String]()
                //let coord = JSONObject.object(forKey: "coord") as! NSDictionary
                let lat = coord.object(forKey: "lat") as! Double
                self.data.append("\(lat)")
                let lon = coord.object(forKey: "lon") as! Double
                self.data.append("\(lon)")
                
                let weatherArray = JSONObject.object(forKey: "weather") as! NSArray
                let weatherDictionary = weatherArray.firstObject as! NSDictionary
                let weather = weatherDictionary.object(forKey: "description") as! String
                self.data.append(weather)
                
                let main = JSONObject.object(forKey: "main") as! NSDictionary
                let temperature = main.object(forKey: "temp") as! Double
                let temp = temperature * 9.0/5.0 - 459.67
                self.data.append("\(temp)")
                
                let pressure = main.object(forKey: "pressure") as! Double
                self.data.append("\(pressure)")
                
                let humidity = main.object(forKey: "humidity") as! Double
                self.data.append("\(humidity)")
                
                let wind = JSONObject.object(forKey: "wind") as! NSDictionary
                let speed = wind.object(forKey: "speed") as! Double
                self.data.append("\(speed)")
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
                
            }
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = lables[indexPath.row] + ": " + data[indexPath.row]
        //cell.backgroundColor = .blue
        return cell
    }

}

