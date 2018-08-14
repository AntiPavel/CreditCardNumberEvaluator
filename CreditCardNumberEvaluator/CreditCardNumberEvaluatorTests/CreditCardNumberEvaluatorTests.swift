//
//  CreditCardNumberEvaluatorTests.swift
//  CreditCardNumberEvaluatorTests
//
//  Created by Antonov, Pavel on 8/13/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

import XCTest
@testable import CreditCardNumberEvaluator

class CreditCardNumberEvaluatorTests: XCTestCase {
    
    var creditCardNumberEvaluator: CardNumberEvaluator!
    
    override func setUp() {
        super.setUp()
        creditCardNumberEvaluator = CardNumberEvaluator()
    }
    
    override func tearDown() {
        creditCardNumberEvaluator = nil
        super.tearDown()
    }
    
    func testBrandRulesInit() {
        
        let defaultBrandRules = BrandRules(defaultCardBrand: .visa, range: (400000...499999).nsRange)
        XCTAssertEqual(defaultBrandRules.defaultCardBrand, .visa)
        XCTAssertNil(defaultBrandRules.customCardBrand)
        
        let customBrandRules = BrandRules(numderOfDigitsToRecognize: 4,
                                          length: NSRange(location: 15, length: 1),
                                          defaultCardBrand: .none,
                                          customCardBrand: customBrandeName,
                                          range: NSRange(location: 3000, length: 1000 ),
                                          priority: 12)
        XCTAssertEqual(customBrandRules.defaultCardBrand, .none)
        XCTAssertEqual(customBrandRules.customCardBrand, customBrandeName)
        
        let customBrandRulesWithoutName = BrandRules(numderOfDigitsToRecognize: 4,
                                          length: NSRange(location: 15, length: 1),
                                          defaultCardBrand: .none,
                                          customCardBrand: nil,
                                          range: (3000...3999).nsRange,
                                          priority: 12)
        XCTAssertEqual(customBrandRulesWithoutName.defaultCardBrand, .none)
        XCTAssertEqual(customBrandRulesWithoutName.customCardBrand, Default.kCustomBrand)
    }
    
    func testCardNumberEvaluatorInit() {
        let creditCardNumberEvaluatorInitiatedWithRules = CardNumberEvaluator(with: Default.rules)
        XCTAssertEqual(creditCardNumberEvaluatorInitiatedWithRules.rules, creditCardNumberEvaluator.rules)
    }
    
    func testTryEvaluate() {
        let visaValidString = "4929804463622139"
        let expectedResult = Result(isValid: true, error: .none, cardBrand: visaBrandName)
        let result = creditCardNumberEvaluator.tryEvaluate(with: visaValidString)
        XCTAssertEqual(result.isValid, expectedResult.isValid)
        XCTAssertEqual(result.error, expectedResult.error)
        XCTAssertEqual(result.cardBrand, expectedResult.cardBrand)
       // let rule = BrandRules(defaultCardBrand: .visa, range: (400000...499999).nsRange)
    }
    
    func testTryEvaluateArray() {
        let results = creditCardNumberEvaluator.tryEvaluateArray(with: testNumbers)
        let validities = results.map{ $0.isValid }
        let errors = results.map{ $0.error }
        let brands = results.map{ $0.cardBrand }
        XCTAssertEqual(validities, expectedValidities)
        XCTAssertEqual(errors, expectedErrors)
        XCTAssertEqual(brands, expectedBrands)
    }
    
    func testTryEvaluateArrayWithCustomRule() {
        let customBrandRules = BrandRules(numderOfDigitsToRecognize: 4,
                                          length: NSRange(location: 15, length: 1),
                                          defaultCardBrand: .none,
                                          customCardBrand: customBrandeName,
                                          range: NSRange(location: 3000, length: 1000 ),
                                          priority: 12)
        expectedErrors[0] = .none
        expectedBrands[0] = customBrandeName
        
        creditCardNumberEvaluator.rules = creditCardNumberEvaluator.rules + [customBrandRules]
        let results = creditCardNumberEvaluator.tryEvaluateArray(with: testNumbers)
        let validities = results.map{ $0.isValid }
        let errors = results.map{ $0.error }
        let brands = results.map{ $0.cardBrand }
        XCTAssertEqual(validities, expectedValidities)
        XCTAssertEqual(errors, expectedErrors)
        XCTAssertEqual(brands, expectedBrands)
    }
    
    func testFilteredTryEvaluateArray() {
        let results = creditCardNumberEvaluator.tryEvaluateArray(with: testNumbers).filter(isValid: true, error: .none, cardBrand: visaBrandName)
        XCTAssertEqual(results.count, 2)
    }
    
    let customBrandeName = "Amex"
    let visaBrandName = "Visa"
    let testNumbers = ["329804463622139",
                       "4929804463622139",
                       "4929804463622138",
                       "6762765696545485",
                       "5212132012291762",
                       "6210948000000029",
                       "492980446362",
                       "149298044636",
                       "4929804463622139492",
                       "49298044636221394920",
                       "04929804463622139",
                       "49298044636",
                       "12345test"]
    
    let expectedValidities = [false,
                              true,
                              false,
                              true,
                              false,
                              true,
                              true,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false]
    
    var expectedErrors = [EvaluationError.unknownBrand,
                          .none,
                          .none,
                          .none,
                          .none,
                          .none,
                          .none,
                          .unknownBrand,
                          .none,
                          .wrongLengh,
                          .leadingZero,
                          .wrongLengh,
                          .nonNumeric]
    
    var expectedBrands = [nil,
                          "Visa",
                          "Visa",
                          "Maestro",
                          "Mastercard",
                          "ChinaUnionPay",
                          "Visa",
                          nil,
                          "Visa",
                          nil,
                          nil,
                          nil,
                          nil]
}
