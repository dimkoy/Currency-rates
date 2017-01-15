//
//  DataStack.swift
//  Rates
//
//  Created by Dmitriy on 14/01/2017.
//  Copyright © 2017 Dmitriy. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class DataStack {
    
    var currency: Dictionary<String,Double> = [
        "usd": 0.0,
        "eur": 0.0,
        "oldusd": 0.0,
        "oldeur": 0.0
    ]

    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    let url = URL(string: "http://api.fixer.io/latest?symbols=RUB,USD")
    
    func getValue() -> Dictionary<String,Double> {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error")
            }
            else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary {
                            
                            let newCurrency = NSEntityDescription.insertNewObject(forEntityName: "Currency", into: context)
                            for (key, value) in rates {
                                
                                self.myCurrency.append((key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            newCurrency.setValue(rates["RUB"] as! Double, forKey: "eur")
                            let a:Double = (rates["RUB"] as! Double)/(rates["USD"] as! Double)
                            newCurrency.setValue(a, forKey: "usd")
                            
                            do {
                                try context.save()
                            }
                        }
                        
                    }
                    catch {
                        
                    }
                }
            }
        }
        
        task.resume()
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Currency")
        request.returnsObjectsAsFaults = false
        

        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    currency["oldusd"] = currency["usd"]
                    currency["usd"] = result.value(forKey: "usd") as? Double
                    currency["oldeur"] = currency["eur"]
                    currency["eur"] = result.value(forKey: "eur") as? Double
                    
                }
            }
        }
            
        catch {
            //Error
        }
        
    return currency
    }


}
