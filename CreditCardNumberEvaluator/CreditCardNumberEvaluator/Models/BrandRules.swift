//
//  BrandRules.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import Foundation

@objc public final class BrandRules: NSObject {
    @objc public private(set) var numderOfDigitsToRecognize: Int
    @objc public private(set) var length: NSRange
    @objc public private(set) var range: NSRange
    @objc public private(set) var defaultCardBrand: CardBrand
    @objc public private(set) var priority: Int
    @objc public private(set) var customCardBrand: String?
    
    @objc public init(numderOfDigitsToRecognize: Int = Default.numderOfDigitsToRecognize,
                length: NSRange = Default.length,
                defaultCardBrand: CardBrand,
                customCardBrand: String? = nil,
                range: NSRange,
                priority: Int = Default.priority) {
        self.numderOfDigitsToRecognize = numderOfDigitsToRecognize
        self.length = length
        self.defaultCardBrand = defaultCardBrand
        self.range = range
        self.priority = priority
        self.customCardBrand = customCardBrand ??
                            (defaultCardBrand == .none ? Default.kCustomBrand : customCardBrand)
        super.init()
    }
}
