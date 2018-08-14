//
//  CardBrand.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

@objc public enum CardBrand: Int, RawRepresentable {
    case visa
    case mastercard
    case maestro
    case chinaUnionPay
    case none
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .visa:
            return "Visa"
        case .mastercard:
            return "Mastercard"
        case .maestro:
            return "Maestro"
        case .chinaUnionPay:
            return "ChinaUnionPay"
        case .none:
            return "None"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "Visa":
            self = .visa
        case "Mastercard":
            self = .mastercard
        case "Maestro":
            self = .maestro
        case "ChinaUnionPay":
            self = .chinaUnionPay
        default:
            self = .none
        }
    }
}
