//
//  AppleMailTOCParser.h
//  TocWrapper
//
//  Created by Alfonso Maria Tesauro on 01/01/16.
//  Copyright © 2016 Alfonso Maria Tesauro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppleMailTOCParser : NSObject

@property (strong) NSData    *tocAsData;

@property (readonly) int32_t    mailCount;

-(instancetype)initWithData:(NSData *)data;
-(instancetype)initWithPath:(NSString *)path;
-(instancetype)initWithURL:(NSURL *)url;
-(NSArray *)parse;


@end
