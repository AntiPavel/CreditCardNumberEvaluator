//
//  AppDelegate.swift
//  SwiftExample
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import UIKit
import CreditCardNumberEvaluator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let test = ["329804463622139", "4929804463622139", "4929804463622138", "6762765696545485", "5212132012291762", "6210948000000029", "492980446362", "149298044636", "4929804463622139492", "49298044636221394920", "04929804463622139", "49298044636", "12345test"]
        
        let evaluator = CardNumberEvaluator()
        let customBrandRules = (BrandRules(numderOfDigitsToRecognize: 4,
                                           length: NSRange(location: 15, length: 1),
                                           defaultCardBrand: .none,
                                           customCardBrand: "Amex",
                                           range: NSRange(location: 3000, length: 1000 ),
                                           priority: 12))
        
        //let anotherEvaluator = CardNumberEvaluator(with: [customBrandRules])
        
        evaluator.rules = evaluator.rules + [customBrandRules]
        
        print("results by one:")
        for number in test {
            let result = evaluator.tryEvaluate(with: number)
            print("brand: \(result.cardBrand ?? "none") validity: \(result.isValid) error: \(result.error.rawValue)")
        }
        
        print("\narray results:")
        let results = evaluator.tryEvaluateArray(with: test)
        for result in results {
            print("brand: \(result.cardBrand ?? "none") validity: \(result.isValid) error: \(result.error.rawValue)")
        }
        
        print("\nfiltered results:")
        let filteredResults = results.filter(cardBrand: "Amex")
        for result in filteredResults {
            print("brand: \(result.cardBrand ?? "none") validity: \(result.isValid) error: \(result.error.rawValue)")
        }
        
        return true
    }

}

