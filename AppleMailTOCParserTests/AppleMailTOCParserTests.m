//
//  AppleMailTOCParserTests.m
//  AppleMailTOCParserTests
//
//  Created by Alfonso Maria Tesauro on 04/01/16.
//  Copyright © 2016 Alfonso Maria Tesauro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppleMailTOCParser.h"

@interface AppleMailTOCParserTests : XCTestCase

@end

@implementation AppleMailTOCParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.mbox/mbox" ofType:@""];
    
    NSString *tocpath = [[NSBundle mainBundle] pathForResource:@"test.mbox/table_of_contents" ofType:@""];
    
    AppleMailTOCParser *myParser = [[AppleMailTOCParser alloc] initWithData:[NSData dataWithContentsOfFile:tocpath]];
    
    NSArray *list = [myParser parse];
    
    NSError *error;
    
    NSData *myMboxVerifier = [@"From " dataUsingEncoding:NSASCIIStringEncoding];
    
    NSData *myProva = [@"\nFrom " dataUsingEncoding:NSASCIIStringEncoding];
    
    NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedAlways error:&error];
    
    if ([data length] == 0)
        XCTAssert(NO, @"Empty mbox file selected for testing.");
    
    
    if ([data rangeOfData:myMboxVerifier options:0 range:NSMakeRange(0,10)].location != 0)
        XCTAssert(NO, @"From Tag at the beginning not found.");
    
    NSInteger count = 0;
    
    NSRange mySearchRange = NSMakeRange(0, [data length]);
    
    NSRange myMessageRange;
    
    do{
        
        NSRange myRange = [data rangeOfData:myProva options:0 range:mySearchRange];
        
        if (myRange.location == NSNotFound)
        {
            count++;
            break;
            
        }
        if (count == 0)
            myMessageRange = NSMakeRange(0, myRange.location+1);
        else
            myMessageRange = NSMakeRange(mySearchRange.location-5, myRange.location-mySearchRange.location+6);
        
        if (myMessageRange.location != [[[list objectAtIndex:count] valueForKey:@"emailOffset"] integerValue])
            XCTAssert(NO, @"Email Offset Mismatch for Email number %ld",count);
        
        
        
        mySearchRange = NSMakeRange(myRange.location + myRange.length, [data length]-(myRange.location + myRange.length));
        
        count++;
        
    }while(1);
    
    NSLog(@"Emails count = %ld",count);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    NSString *tocpath = @"/Volumes/Mailbox Reader Test small/Mailboxes/Mbox with 72000 Messages.mbox/table_of_contents";
    
    AppleMailTOCParser *myParser = [[AppleMailTOCParser alloc] initWithData:[NSData dataWithContentsOfFile:tocpath]];
    
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSArray *list = [myParser parse];
        
        #pragma unused (list)
        
    }];
}

@end
