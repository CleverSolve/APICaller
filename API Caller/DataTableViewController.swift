//
//  DataTableViewController.swift
//  API Caller
//
//  Created by Work on 8/29/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit
import Foundation

class DataTableViewController: UITableViewController
{
    var jsonFile = "MSFT.json"
    
    //var dataDict:[String: [String: Double]] =
    
    var dataDict:[String: [String: Double]] = ["2018-08-29": ["open": 110.45, "close": 111.85, "high": 112.0, "low": 110.27, "volume": 14900748 ]]
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "MSFT", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>  {
                    print(jsonResult)
                    print("BLAH BLAH BLAH BLAH")
                    print(jsonResult.keys)
                     print("BLAH BLAH BLAH BLAH")
                    for key in jsonResult.keys{
                        print("SEPERATOR")
                    print(jsonResult[key])
                    }
                    print("Outside the loop now")
                    let myDict  = jsonResult["Time Series (Daily)"]
                   
                    print("type is \(type(of: myDict))")
                    print("myDict is \(myDict!)")
                }
            } catch {
                print("error loading")
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    // NUMBER OF SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    // NUMBER OF ROWS IN SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    // HEIGHT FOR ROW
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! DataTableViewCell
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        switch indexPath.row{
        case 0:
        if let myData = dataDict["2018-08-29"]{
            cell.Name.text = "MSFT"
            
            //If close >= open, make cell.Price textColor green (rgb: 0,1.0, 0)
            //else make cell.price text color red rgb: 1,0,0
            
            if(myData["close"]! >= myData["open"]!)
            {
                cell.Price.textColor = UIColor .green
            }
            else
            {
                cell.Price.textColor = UIColor .red
            }
            
            cell.Price.text = numberFormatter.string(from: myData["close"] as! NSNumber)
            cell.stat1.text = "Low: " + numberFormatter.string(from: myData["high"] as! NSNumber)!
            cell.stat2.text = "High: "  + numberFormatter.string(from: myData["low"] as! NSNumber)!
            cell.stat3.text = "Open: " + numberFormatter.string(from: myData["open"] as! NSNumber)!
            
            
            cell.stat4.text = "Volume: " + formatNumber(Int(myData["volume"]!))
            let mCap = myData["volume"]! * myData["close"]!
            
            
            cell.stat5.text = "MarketCap: " + formatNumber(Int(mCap))
            
            cell.stat6.text = "Mid: " +  numberFormatter.string(from: ((myData["low"]! + myData["high"]!) / 2.0) as! NSNumber)!
        }
        else{
            print("not able to get myData?")
        }
        default:
            print("not doing anything for the other cells")
        }
        return cell
    }
//    case 1:
//    if let myData = dataDict["2018-08-29"]
//    {
//
//    }
    
    // FORMAT NUMBER
    func formatNumber(_ n: Int) -> String
    {
        
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num {
            
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"
            
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"
            
        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"
            
        case 0...:
            return "\(n)"
            
        default:
            return "\(sign)\(n)"
            
        }
        
    }
    
    
//    “2018-08-29”: {
//    “1. open”: “110.4500”,
//    “2. high”: “112.0000”,
//    “3. low”: “110.2700”,
//    “4. close”: “111.8500”,
//    “5. volume”: “14900748”
//    },
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
// ?
extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
