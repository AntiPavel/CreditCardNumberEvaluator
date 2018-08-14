//
//  CardNumberEvaluator.swift
//  CreditCardNumberEvaluator
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import Foundation

@objc public final class CardNumberEvaluator: NSObject {
    
    private var _rules: [BrandRules] = []
    @objc public var rules: [BrandRules] {
        set { _rules = newValue.sorted { $0.priority > $1.priority } }
        get { return _rules }
    }
    
    @objc public override init() {
        super.init()
        self.rules = Default.rules
    }
    
    @objc public init(with rules: [BrandRules]) {
        super.init()
        self.rules = rules
    }
    
    @objc public func tryEvaluateArray(with brands:[String]) -> [Result] {
        return brands.map { tryEvaluate(with: $0) }
    }
    
    @objc public func tryEvaluate(with brand:String) -> Result {
        
        guard brand.isNumeric, let isZero = brand.hasLeadingZero else {
            return Result(error: .nonNumeric)
        }
        
        guard !isZero else { return  Result(error: .leadingZero) }
        
        let filteredByLength = filterByLength(brand, rules: rules)
        guard !filteredByLength.isEmpty else { return Result(error: .wrongLengh) }
        let filteredByFirstDigits = filterByFirstDigits(brand, rules: filteredByLength)
        guard let rule = filteredByFirstDigits.first else { return Result(error: .unknownBrand) }
        
        if case .none = rule.defaultCardBrand {
            return Result(isValid: brand.luhnCheckValid,
                          cardBrand: filteredByFirstDigits.first?.customCardBrand)
        } else {
            return Result(isValid: brand.luhnCheckValid,
                          cardBrand: filteredByFirstDigits.first?.defaultCardBrand.rawValue)
        }
    }
    
    private func filterByLength(_ brand: String, rules: [BrandRules]) -> [BrandRules] {
        return rules.filter { $0.length.contains(brand.count) }
    }
    
    private func filterByFirstDigits(_ brand: String, rules: [BrandRules]) -> [BrandRules] {
        
        return rules.filter { rule in
            
            guard rule.numderOfDigitsToRecognize <= brand.count else { return false }
            
            let start = String.Index(encodedOffset: 0)
            let end = String.Index(encodedOffset: rule.numderOfDigitsToRecognize)
            guard let firstDigits = Int(brand[start..<end]) else { return false }
            
            return rule.range.contains(firstDigits)
        }
    }
    
}

public extension Array where Element == Result {
    func filter(isValid: Bool? = nil,
                error: EvaluationError = .none,
                cardBrand: String? = nil) -> [Result] {
        let errorFilter: EvaluationError? = error == .none ? nil : error
        return self.filter {
            $0.isValid == (isValid ?? $0.isValid) &&
                $0.error == (errorFilter ?? $0.error) &&
                $0.cardBrand == (cardBrand ?? $0.cardBrand)
        }
    }
}

private extension String {
    var isNumeric: Bool {
        return checkIfNumeric(self)
    }
    
    private func checkIfNumeric(_ string: String) -> Bool {
        
        var numeric = true
        if string.count > 18 {  //the Int max value is 9223372036854775807 so if we got an 19th characters string we should split it
            numeric = (checkIfNumeric(String(string.prefix(18))) && checkIfNumeric(String(string.dropFirst(18))))
        } else {
            numeric = (numeric && Int(string) != nil )
        }
        return numeric
    }
    
    var hasLeadingZero: Bool? {
        guard let firstChar = self.first, let firstInt = Int(String(firstChar)) else { return nil }
        return firstInt == 0
    }
    
    var luhnCheckValid: Bool {
        var sum = 0
        let reversedCharacters = self.reversed().map { String($0) }
        for (index, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((index % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
}
