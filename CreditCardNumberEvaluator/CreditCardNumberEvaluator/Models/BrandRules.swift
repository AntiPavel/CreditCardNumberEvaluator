//
//  BrandRules.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import Foundation

@objc public final class BrandRules: NSObject {
    private(set) var numderOfDigitsToRecognize: Int
    private(set) var length: CountableClosedRange<Int>
    private(set) var range: CountableClosedRange<Int>
    private(set) var defaultCardBrand: CardBrand
    private(set) var priority: Int
    private(set) var customCardBrand: String?
    
    public init(numderOfDigitsToRecognize: Int = Default.numderOfDigitsToRecognize,
                length: CountableClosedRange<Int> = Default.length,
                defaultCardBrand: CardBrand,
                customCardBrand: String? = nil,
                range: CountableClosedRange<Int>,
                priority: Int = Default.priority) {
        self.numderOfDigitsToRecognize = numderOfDigitsToRecognize
        self.length = length
        self.defaultCardBrand = defaultCardBrand
        self.range = range
        self.priority = priority
        self.customCardBrand = defaultCardBrand == .none ? "Custom brand" : customCardBrand
        super.init()
    }
}
