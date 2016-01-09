//
//  AppDelegate.h
//  AppleMailTOCParser
//
//  Created by Alfonso Maria Tesauro on 04/01/16.
//  Copyright © 2016 Alfonso Maria Tesauro. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDelegate,NSTextViewDelegate>

@property (strong) NSArray                      *parsedObjects;
@property (weak)   IBOutlet  NSArrayController  *parsedObjectsController;
@property (assign) IBOutlet  NSTextView         *wholeMboxTextView;
@property (assign) NSInteger                    mailCount;
@property (assign) NSInteger                    selectionOffset;
@property (assign) NSInteger                    selectionLength;

@end

