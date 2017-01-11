//
//  StockManager.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/5/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}

class StockManager{
    
    static let instance = StockManager()
    
    var stocks: [String : [Int]] = [:]
    
    private init()
    {}
    
    func getRandomStockName() -> String{
        var stockStrings: [String] = []
        
        if let path = Bundle.main.path(forResource: "Stocks", ofType: "txt")
        {
            do{
                let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                
                stockStrings = content.lines
                
            } catch _ as NSError {
                return ""
            }
        }
        
        return stockStrings[Int(arc4random_uniform(UInt32(stockStrings.count)))]
    }
    
    func setStocks(callback: @escaping (String, [Int]) -> ())
    {
        let stockName = getRandomStockName()
        
        let urlString:String = ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.historicaldata where symbol = \"" + stockName + "\" and startDate = \"2016-01-01\" and endDate = \"2016-12-01\" &format=json&env=http://datatables.org/alltables.env").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if(error != nil){
                print(error!.localizedDescription)
            }
            else{
                do{
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    var stockHighs = [Int]()
                    
                    if let query = jsonDict.object(forKey: "query") as? NSDictionary{
                        if let results = query.object(forKey: "results") as? NSDictionary{
                            if let quotes = results.object(forKey: "quote") as? NSArray{
                                for quote in quotes{
                                    stockHighs.append(Int(Float(((quote as AnyObject).object(forKey: "High") as! String))! * 100))
                                }
                            }
                        }
                    }
                    
                    if(stockHighs.count < 50)
                    {
                        self.setStocks(callback: callback)
                    }
                    else
                    {
                        callback(stockName, stockHighs)
                    }
                }
                catch let jsonError as NSError {
                    print(jsonError.localizedDescription)
                }
            }
        })
        
        task.resume()
    }
    
    func setStocks(stockName: String, callback: @escaping ([Int]) -> ())
    {
        let urlString:String = ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.historicaldata where symbol = \"" + stockName + "\" and startDate = \"2016-01-01\" and endDate = \"2016-12-01\" &format=json&env=http://datatables.org/alltables.env").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if(error != nil){
                print(error!.localizedDescription)
            }
            else{
                do{
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    
                    var stockHighs = [Int]()
                    
                    if let query = jsonDict.object(forKey: "query") as? NSDictionary{
                        if let results = query.object(forKey: "results") as? NSDictionary{
                            if let quotes = results.object(forKey: "quote") as? NSArray{
                                for quote in quotes{
                                    stockHighs.append(Int(Float(((quote as AnyObject).object(forKey: "High") as! String))! * 100))
                                }
                            }
                        }
                    }
                    
                    callback(stockHighs)
                }
                catch let jsonError as NSError {
                    print(jsonError.localizedDescription)
                }
            }
        })
        
        task.resume()
    }

}
