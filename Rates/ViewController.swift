//
//  ViewController.swift
//  Rates
//
//  Created by Dmitriy on 14/01/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var usdValue: UILabel!
    @IBOutlet weak var usdOldValue: UILabel!
    @IBOutlet weak var eurValue: UILabel!
    @IBOutlet weak var eurOldValue: UILabel!
    @IBOutlet weak var usdView: UIView!
    @IBOutlet weak var eurView: UIView!
 
    @IBOutlet weak var menuBar: UIToolbar!
    
    
    @IBAction func changeTheme(_ sender: Any) {
        
        UIView.animate(withDuration: 0.8, animations: {
        if self.usdValue.textColor == UIColor.black {
            self.view.backgroundColor = UIColor.gray
            self.usdValue.textColor = UIColor.white
            self.eurValue.textColor = UIColor.white
            self.usdView.backgroundColor = UIColor.gray
            self.eurView.backgroundColor = UIColor.gray
            } else {
            self.view.backgroundColor = UIColor.white
            self.usdValue.textColor = UIColor.black
            self.eurValue.textColor = UIColor.black
            self.usdView.backgroundColor = UIColor.white
            self.eurView.backgroundColor = UIColor.white
            
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.update()
 
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        let data = DataStack()
        let value = data.getValue()
        usdValue.text = String(format: "%.2f", value["usd"]!)
        usdOldValue.text = String(format: "%.2f",(value["usd"]! - value["oldusd"]!))
        eurValue.text = String(format: "%.2f",value["eur"]!)
        eurOldValue.text = String(format: "%.2f",(value["eur"]! - value["oldeur"]!))
        
        if value["usd"]! >= value["oldusd"]! {
            usdOldValue.textColor = UIColor.green
            usdOldValue.text = "+" + String(format: "%.2f",(value["usd"]! - value["oldusd"]!))
        } else {
            usdOldValue.textColor = UIColor.red
        }
        if value["eur"]! >= value["oldeur"]! {
            eurOldValue.textColor = UIColor.green
            eurOldValue.text = "+" + String(format: "%.2f",(value["eur"]! - value["oldeur"]!))
        } else {
            eurOldValue.textColor = UIColor.red
        }
    }
    

}

