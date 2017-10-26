//
//  ViewController.swift
//  OscarArias-Lab1
//
//  Created by labuser on 9/11/17.
//  Copyright © 2017 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discountPercent: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UITextField!
    
    @IBOutlet weak var couponCode: UILabel!
    @IBOutlet weak var couponDescription: UILabel!
    var couponValue = 0.0
    var clicks = 0
    
    @IBAction func changedOriginalPrice(_ sender: UITextField!) {
        if let text = sender.text {
            if Double(text) != nil, Double(text)! >= 0.0 {
                calculateFinalPrice()
            }
            else {
                finalPrice.text = ""
            }
        }
    }
    
    @IBAction func changedDiscount(_ sender: UITextField!) {
        if let text = sender.text {
            if Double(text) != nil, Double(text)! >= 0.0, Double(text)! <= 100.0 {
                calculateFinalPrice()
            }
            else {
                finalPrice.text = ""
            }
        }
    }
    
    @IBAction func changedSalesTax(_ sender: UITextField!) {
        if let text = sender.text {
            if Double(text) != nil, Double(text)! >= 0.0 {
                calculateFinalPrice()
            }
            else {
                finalPrice.text = ""
            }
        }
    }
    
    @IBAction func loadCoupon(_ sender: UIButton!) {
        var codes = [("BACK2SCHOOL", "25 % off school supplies", 0.25), ("XMAS", "30 % off gifts", 0.30), ("FORDAFREE", "Giveaway! Free!", 1)]
        
        clicks += 1
        let index = clicks % codes.count
        
        couponCode.text = codes[index].0
        couponDescription.text = codes[index].1
        couponValue = codes[index].2
        
        calculateFinalPrice()
        
    }
    
    @IBAction func clearCoupon(_ sender: Any) {
        couponCode.text = ""
        couponDescription.text = ""
        couponValue = 0
        
        calculateFinalPrice()
    }
    
    func calculateFinalPrice() {
        if let price = Double(originalPrice.text!), let discount = Double(discountPercent.text!), let tax = Double(salesTax.text!)  {
            let afterDiscount = price - (price * (discount/100.0))
            let value = (afterDiscount - (afterDiscount * couponValue)) * (1.0 + tax/100.0)
            let displayText = "$\(String(format: "%.2f", value))"
            finalPrice.text = displayText
        }
    }
    
}

