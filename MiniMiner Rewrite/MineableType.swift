//
//  MineableType.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/5/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class MineableType{
    
    static let all = [MineableType(id: 0, name: "RoundGem"), MineableType(id: 1, name: "DiamondGem")]
    
    let id: Int
    let name: String
    let size: CGSize
    var stockName: String
    var stockData: [Int]
    
    var loaded: Bool
    
    private init(id: Int, name: String)
    {
        self.id = id
        self.name = name
        loaded = false
        size = CGSize(width: 2, height: 2)
        
        let userDefaults = UserDefaults.standard
        
        stockName = ""
        stockData = [Int]()
        
        if(userDefaults.value(forKey: name) == nil){
            StockManager.instance.setStocks(callback: load)
        }
        else{
            stockName = userDefaults.value(forKey: name) as! String
            StockManager.instance.setStocks(stockName: stockName, callback: load)
        }
    }
    
    func load(stockName: String, stockData: [Int]){
        self.stockName = stockName
        self.stockData = stockData
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(stockName, forKey: name)
        
        loaded = true
    }
    
    func load(stockData: [Int]){
        self.stockData = stockData
        loaded = true
    }
    
    func reset(){
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: name)
        
        print("called")
        
        StockManager.instance.setStocks(callback: load)
    }
    
    func getValueAtTime(_ normalizedTime: Float) -> Int{
        if(loaded)
        {
            return stockData[Int(Float(stockData.count) * normalizedTime)]
        }
        else
        {
            return 0
        }
    }
}
