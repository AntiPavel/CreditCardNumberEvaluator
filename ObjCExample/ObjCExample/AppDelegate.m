//
//  AppDelegate.m
//  ObjCExample
//
//  Created by Antonov, Pavel on 8/14/18.
//  Copyright © 2018 Pavel Antonov. All rights reserved.
//

#import "AppDelegate.h"
@import CreditCardNumberEvaluator;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *myArray = @[@"329804463622139", @"4929804463622139", @"4929804463622138", @"6762765696545485", @"5212132012291762", @"6210948000000029", @"492980446362", @"149298044636", @"4929804463622139492", @"49298044636221394920", @"04929804463622139", @"49298044636", @"12345test"];
    
    CardNumberEvaluator *evaluator = [CardNumberEvaluator new];
    
    Result *result = [evaluator tryEvaluateWith:@"4929804463622139"];
    NSLog (@"result:");
    NSLog (@"cardBrand: %@ isValid: %s error: %d", result.cardBrand, result.isValid  ? "true" : "false", result.error);
    
    BrandRules *rule = [[BrandRules alloc] initWithNumderOfDigitsToRecognize:4 length:NSMakeRange(15, 1) defaultCardBrand: CardBrandNone customCardBrand:@"Amex" range:NSMakeRange(3000, 1000) priority:12 ];
    
    //CardNumberEvaluator *anotherEvaluator = [[CardNumberEvaluator alloc] initWith: @[rule]];
    
    NSMutableArray  *mutableRulesArray = [NSMutableArray arrayWithArray:evaluator.rules];
    [mutableRulesArray addObject:rule];
    evaluator.rules = [mutableRulesArray copy];
    
    NSLog (@"\nresults:");
    NSArray *results = [evaluator tryEvaluateArrayWith:myArray];
    
    for (Result *result in results) {
        NSLog (@"cardBrand: %@ isValid: %s error: %d", result.cardBrand, result.isValid  ? "true" : "false", result.error);
    }
    
    NSLog (@"\nfiltered results:");
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.cardBrand contains[cd] %@",@"Amex"];
    NSArray *filteredResults = [results filteredArrayUsingPredicate:predicate];
    NSLog(@"filtered: %@",filteredResults);
    
    return YES;
}

@end
