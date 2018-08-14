Credit Card Number Evaluator

Simple Framework for the validating a number of the credit card and check the brand the number belongs to.


Task: Credit Card Number Evaluator
We are working with credit card numbers on a daily basis. One of the routine tasks is to
filter lists of numbers based on two factors:
• the validity of the number
• the brand the number belongs to
Your task is to design and implement a Swift/ Objective C framework which provides
methods to perform this filtering. All the details of the API design are up to you.
Definitions
Assume that a credit card number is valid if:
• it contains only numbers and no leading 0
• it is 12-19 digits long
• It passes the Luhn check (https://en.wikipedia.org/wiki/Luhn_algorithm). For credit
card numbers, the Luhn check digit is the last digit of the sequence.
The card number belong to a brand if the first 6 digits of the number fall in the following
ranges:
• Visa
o 400000-499999
• Mastercard
o 222100 – 272099
o 510000 - 559999
• Maestro
o 500000 - 509999
o 560000 - 699999
• China Union Pay
o 620000 - 629999 (takes priority over Maestro)

Sample Data

Card Number             Brand     	Validity
4929804463622139 	Visa              Valid
4929804463622138 	Visa              Invalid
6762765696545485 	Maestro           Valid
5212132012291762 	Mastercard        Invalid
6210948000000029 	China Union Pay   Valid
