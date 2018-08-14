//
//  Result.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

@objc public final class Result: NSObject {
    @objc public private(set) var isValid: Bool
    @objc public private(set) var error: EvaluationError
    @objc public private(set) var cardBrand: String?
    
    @objc public init(isValid: Bool = false, error: EvaluationError = .none, cardBrand: String? = nil) {
        self.isValid = isValid
        self.error = error
        self.cardBrand = cardBrand
        super.init()
    }
}
