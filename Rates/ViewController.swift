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
        if usdValue.textColor == UIColor.black {
            self.view.backgroundColor = UIColor.gray
            usdValue.textColor = UIColor.white
            eurValue.textColor = UIColor.white
            usdView.backgroundColor = UIColor.gray
            eurView.backgroundColor = UIColor.gray
            menuBar.backgroundColor = UIColor.gray
        } else {
            self.view.backgroundColor = UIColor.white
            usdValue.textColor = UIColor.black
            eurValue.textColor = UIColor.black
            usdView.backgroundColor = UIColor.white
            eurView.backgroundColor = UIColor.white
            menuBar.backgroundColor = UIColor.white

            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
       // let context = appDelegate.persistentContainer.viewContext
        
        let data = DataStack()
        let value = data.getValue()

        usdValue.text = String(format: "%.2f", value["usd"]!)
        usdOldValue.text = String(format: "%.2f",value["oldusd"]!)
        eurValue.text = String(format: "%.2f",value["eur"]!)
        eurOldValue.text = String(format: "%.2f",value["oldeur"]!)
        if value["usd"]! > value["oldusd"]! {
            usdOldValue.textColor = UIColor.green
        } else {
            usdOldValue.textColor = UIColor.red
        }
        if value["eur"]! > value["oldeur"]! {
            eurOldValue.textColor = UIColor.green
        } else {
            eurOldValue.textColor = UIColor.green
        }
        _ = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        let data = DataStack()
        let value = data.getValue()
        usdValue.text = String(format: "%.2f", value["usd"]!)
        usdOldValue.text = String(format: "%.2f",value["oldusd"]!)
        eurValue.text = String(format: "%.2f",value["eur"]!)
        eurOldValue.text = String(format: "%.2f",value["oldeur"]!)
        if value["usd"]! > value["oldusd"]! {
            usdOldValue.textColor = UIColor.green
        } else {
            usdOldValue.textColor = UIColor.red
        }
        if value["eur"]! > value["oldeur"]! {
            eurOldValue.textColor = UIColor.green
        } else {
            eurOldValue.textColor = UIColor.green
        }

    }

}

