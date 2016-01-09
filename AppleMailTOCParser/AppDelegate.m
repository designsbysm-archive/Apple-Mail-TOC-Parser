//
//  AppDelegate.m
//  AppleMailTOCParser
//
//  Created by Alfonso Maria Tesauro on 04/01/16.
//  Copyright © 2016 Alfonso Maria Tesauro. All rights reserved.
//

#import "AppDelegate.h"
#import "AppleMailTOCParser.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

@synthesize parsedObjects;
@synthesize parsedObjectsController;
@synthesize wholeMboxTextView;
@synthesize mailCount;
@synthesize selectionOffset;
@synthesize selectionLength;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSURL *t_o_cFileURL = [[NSBundle mainBundle] URLForResource:@"test.mbox/table_of_contents" withExtension:@""];
    
    NSURL *mboxFileURL = [[NSBundle mainBundle] URLForResource:@"test.mbox/mbox" withExtension:@""];

    
    AppleMailTOCParser *parser = [[AppleMailTOCParser alloc] initWithURL:t_o_cFileURL];
    
    self.mailCount = [parser mailCount];
    
    self.parsedObjects = [parser parse];
    
    [parsedObjectsController rearrangeObjects];
    
    NSString *wholeMailboxFileAsString = [NSString stringWithContentsOfURL:mboxFileURL encoding:NSASCIIStringEncoding error:NULL];
    
    [[self.wholeMboxTextView textStorage] setAttributedString:[[NSAttributedString alloc] initWithString:wholeMailboxFileAsString attributes:[NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Monaco" size:12] forKey:NSFontAttributeName]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewSelectionDidChange:) name:NSTextViewDidChangeSelectionNotification object:NULL];
    
    
    NSOperatingSystemVersion myInfo = [[NSProcessInfo processInfo] operatingSystemVersion];
    
    if (myInfo.minorVersion > 10)
        self.window.titlebarAppearsTransparent = YES;
    
    [self.wholeMboxTextView setSelectedRange:NSMakeRange(0,4)];
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark NSTableViewDelegate methods

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    
    [self.wholeMboxTextView setSelectedRange:NSMakeRange([[[self.parsedObjectsController selection] valueForKey:@"emailOffset"] integerValue],4)];
    
    [self.wholeMboxTextView scrollRangeToVisible:NSMakeRange([[[self.parsedObjectsController selection] valueForKey:@"emailOffset"] integerValue],4)];
}



-(void)textViewSelectionDidChange:(NSNotification *)notification
{
    NSTextView *sourceTextView = [notification object];
    
    NSRange selectedRange = [sourceTextView selectedRange];
    
    self.selectionOffset = selectedRange.location;
    self.selectionLength = selectedRange.length;
}

@end
