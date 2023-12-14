//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource , UIPickerViewDelegate , CoinProtocol {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        coinManager.getCurrencyConversion(with: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCurrencyConversion(with: row)
    }
    
    func coinPrice(price:String, coinLabel:String) {
        DispatchQueue.main.async {
            self.currencyLabel.text = price
            self.coinLabel.text = coinLabel
        }
    }
    
    

}




