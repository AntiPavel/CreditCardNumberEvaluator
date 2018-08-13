//
//  EvaluationError.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

@objc public enum EvaluationError: Int {
    case wrongLengh
    case nonNumeric
    case leadingZero
    case unknownBrand
}
