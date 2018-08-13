//
//  Result.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

@objc public final class Result: NSObject {
    let isValid: Bool
    let error: EvaluationError?
    let cardBrand: String?
    
    public init(isValid: Bool = false, error: EvaluationError? = nil, cardBrand: String? = nil) {
        self.isValid = isValid
        self.error = error
        self.cardBrand = cardBrand
        super.init()
    }
}
