//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    
    var delegate : CoinProtocol?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "CC4B6AF1-9F5D-43AA-B1CB-7ECFAA9F233A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCurrencyConversion(with row : Int ) {
        let urlString = "\(baseURL)/\(currencyArray[row])?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String ){
        
        let url = URL(string: urlString)
        
        if let safeURL = url {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: safeURL ,  completionHandler: { (data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(this:safeData)
                }
            })
            task.resume()
        }
    }
    
    
    func parseJSON(this dataString : Data) {
        let decoder = JSONDecoder()
        
        do {
            let retrivedData = try decoder.decode(CoinDecoder.self, from: dataString )
            let price = String(format:"%0.1f",retrivedData.rate)
            let coinLabel = retrivedData.asset_id_quote
            delegate!.coinPrice(price:price,coinLabel: coinLabel)
        } catch {
            delegate!.coinPrice(price: "Error",coinLabel: "#")
        }
    }
}


/*
 https://rest.coinapi.io/v1/exchangerate/BTC/BDT?apikey=CC4B6AF1-9F5D-43AA-B1CB-7ECFAA9F233A
 */
