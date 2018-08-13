//
//  Default.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/13/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import Foundation

public struct Default {
    static public let rules = [BrandRules(defaultCardBrand: .visa, range: 400000...499999),
                               BrandRules(defaultCardBrand: .mastercard, range: 222100...272099),
                               BrandRules(defaultCardBrand: .mastercard, range: 510000...559999),
                               BrandRules(defaultCardBrand: .maestro, range: 500000...509999),
                               BrandRules(defaultCardBrand: .maestro, range: 560000...699999),
                               BrandRules(defaultCardBrand: .chinaUnionPay, range: 620000...629999, priority: 1)]
    
    static public let numderOfDigitsToRecognize = 6
    static public let length = 12...19
    static public let priority = 0
}
