//
//  BitCoinTVC.swift
//  API Caller
//
//  Created by Work on 9/10/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit

class BitCoinTVC: UITableViewController
{
    // Data Array
    var bcArray = [bcStruct]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        apiCall()

    }
    
    // Struct
    struct bcStruct: Decodable
    {
        let volume: Double?
        let latest_trade: Int?
        let weightedPrice: Double?
        let bid: Double?
        let high: Double?
        let currency: String?
        let low: Double?
        let ask: Double?
        let close: Double?
        let avg: Double?
        let symbol: String?
        let duration: Int?
        let currency_volume: Double?
    }
    
    
    // API CALL Function
    fileprivate func apiCall()
    {
        
        // JSon URL
        let jsonUrlString = "https://api.bitcoincharts.com/v1/markets.json"
        
        guard let url = URL(string: jsonUrlString) else
        {return}
        
        URLSession.shared.dataTask(with: url)
        {
            (data, _, err) in
            
            DispatchQueue.main.async
                {
                    if let err = err
                    {
                        print("Failed to get data from url:", err)
                        return
                    }
            }
            
            
            // Check that the url exists?
            guard let data = data else {return}
            
            do{
                
                let decoder = JSONDecoder()
                
                // Swift 4.1
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.bcArray = try decoder.decode([bcStruct].self, from: data)
                self.tableView.reloadData()
            }catch let jsonErr
            {
                print("Failed to decode:", jsonErr)
            }
            
            
            }.resume()
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bcArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BitCoinCell", for: indexPath) as! BitCoinTableViewCell
        let bcCompany = bcArray[indexPath.row]
        
     
        cell.High.text = bcCompany.high == nil ? "High: NA" :  "High: " + String(bcCompany.high!)
        cell.Symbol.text = bcCompany.symbol!
        //cell.Bid.text = "Bid: " //+ String(bcCompany.bid!)
        cell.Bid.text = bcCompany.bid == nil ? "Bid: NA" : "Bid: " + String(bcCompany.bid!)
        cell.Currency.text = bcCompany.currency!
        cell.Duration.text = "Duration: " + String(bcCompany.duration!)
        cell.Volume.text = "Volume: " + String(bcCompany.volume!)
        //cell.Latest_Trade.text = "Latest Trade" //+ String(bcCompany.latest_trade!)
        cell.Latest_Trade.text = bcCompany.latest_trade == nil ? "Latest Trade: NA" : "Latest Trade: " + String(bcCompany.latest_trade!)
        //cell.Weighted_Price.text = "Weighted Price: " //+ String(bcCompany.weightedPrice!)
        cell.Weighted_Price.text = bcCompany.weightedPrice == nil ? "Weighted Price: NA" : "Weighted Price: " + String(bcCompany.weightedPrice!)
        //cell.Low.text = "Low: " //+ String(bcCompany.low!)
        cell.Low.text = bcCompany.low == nil ? "Low: NA" : "Low: " + String(bcCompany.low!)
        //cell.Ask.text = "Ask: " //+ String(bcCompany.ask!)
        cell.Ask.text = bcCompany.ask == nil ? "Ask: NA" : "Ask: " + String(bcCompany.ask!)
        cell.Close.text = "Close: " + String(bcCompany.close!)
        //cell.Average.text = "Avg: " //+ String(bcCompany.avg!)
        cell.Average.text = bcCompany.avg == nil ? "Avg: NA" : "Avg: " + String(bcCompany.avg!)
        cell.Currency_Volume.text = "Currency Volume: " //+ String(bcCompany.currency_volume!)
        cell.Currency_Volume.text = bcCompany.currency_volume == nil ? "Currency Volume: NA" : "Currency Volume: " + String(bcCompany.currency_volume!)
        cell.Bid.text = bcCompany.bid == nil ? "Bid: NA" : "Bid: " + String(bcCompany.bid!)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let bcCompany = bcArray[indexPath.row]
        
        // <ggonza> Deselects the row after it has been selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // FORMAT NUMBER
    func formatNumber(_ n: Int) -> String
    {
        
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""
        
        switch num
        {
            
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
  
}// End of Class

// Extension for Doubles
//extension Double
//{
//    func truncate(places: Int) -> Double
//    {
//        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
//    }
//}

// For Making Text Bold
//extension NSMutableAttributedString
//{
//    @discardableResult func bold(_ text: String) -> NSMutableAttributedString
//    {
//        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "Roboto-Bold", size: 17)!]
//        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
//        append(boldString)
//
//        return self
//    }
//
//    @discardableResult func normal(_ text: String) -> NSMutableAttributedString
//    {
//        let normal = NSAttributedString(string: text)
//        append(normal)
//
//        return self
//    }
//}
