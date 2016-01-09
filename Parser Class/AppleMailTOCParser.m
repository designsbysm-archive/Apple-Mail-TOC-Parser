//
//  AppleMailTOCParser.m
//  TocWrapper
//
//  Created by Alfonso Maria Tesauro on 01/01/16.
//  Copyright © 2016 Alfonso Maria Tesauro. All rights reserved.
//

#import "AppleMailTOCParser.h"

@implementation AppleMailTOCParser

@synthesize tocAsData;

-(instancetype)initWithData:(NSData *)data
{
    self = [super init];
    
    if (self){
        self.tocAsData = data;
        if (!self.tocAsData)
            return NULL;
    }
    
    return self;
}

-(instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    
    if (self){
        self.tocAsData = [NSData dataWithContentsOfFile:path];
        if (!self.tocAsData)
            return NULL;
            
    }
    
    return self;
}

-(instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    
    if (self){
        self.tocAsData = [NSData dataWithContentsOfURL:url];
        if (!self.tocAsData)
            return NULL;
        
    }
    
    return self;
}

-(int32_t)mailcount
{
    if (self.tocAsData == NULL || [self.tocAsData length] < 10)
        return -1;
    
    NSRange countRange = NSMakeRange(4,4);
    
    NSData *countData = [self.tocAsData subdataWithRange:countRange];
    
    const int32_t *temp;
    
    temp = [countData bytes];
    
    int32_t swapped =  CFSwapInt32BigToHost(*temp);
    
    return swapped;
}

-(NSArray *)parse
{
    if (self.tocAsData == NULL || [self.tocAsData length] < 10)
        return NULL;
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSRange firstChunkSizeRange = NSMakeRange(35,1);
    
    NSData *firstChunkSizeData = [self.tocAsData subdataWithRange:firstChunkSizeRange];
    
    const unsigned char *chunkSize;
    
    chunkSize = [firstChunkSizeData bytes];
    
    int32_t chunkSizeAsInt = (int32_t)*chunkSize;
    
    int32_t chunkStart = 48;
    
    int32_t count = 0;
        
    int32_t nextEmailOffset = 0;
    
    while (count < self.mailcount)
    {

        NSRange emailLengthRange = NSMakeRange(chunkStart-8,4);
        
        NSData *emailLengthData = [self.tocAsData subdataWithRange:emailLengthRange];
        
        const int32_t *temp3;
        
        temp3 = [emailLengthData bytes];

        int32_t emailLength = CFSwapInt32BigToHost(*temp3);
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        char zeroByte = 0;
        
        NSData *dataForOneZeroByte = [NSData dataWithBytes:&zeroByte length:1];
        
        NSRange zeroByteAfterAddressRange = [self.tocAsData rangeOfData:dataForOneZeroByte options:0 range:NSMakeRange(chunkStart+4,[self.tocAsData length]-(chunkStart+4))];
        
        NSString *senderAddress = [[NSString alloc] initWithData:[self.tocAsData subdataWithRange:NSMakeRange(chunkStart+4,zeroByteAfterAddressRange.location - (chunkStart+4))] encoding:NSUTF8StringEncoding];
        
        [dictionary setValue:senderAddress forKey:@"senderAddress"];
        
        [dictionary setValue:[NSNumber numberWithUnsignedInteger:nextEmailOffset] forKey:@"emailOffset"];
        
        [dictionary setValue:[NSNumber numberWithUnsignedInteger:count] forKey:@"emailNumber"];
        
        [dictionary setValue:[NSNumber numberWithUnsignedInteger:emailLength] forKey:@"emailLength"];

        [array addObject:dictionary];
        
        count++;

        if (count == self.mailcount) // The last mail's tag data is not correctly formed in the format, so we skip
            continue;
        
        NSRange nextChunkSizeRange = NSMakeRange(chunkStart+chunkSizeAsInt-16,4);
    
        NSRange nextMailOffsetRange = NSMakeRange(chunkStart+chunkSizeAsInt-12,4);

        NSData *data1 = [self.tocAsData subdataWithRange:nextChunkSizeRange];
        NSData *data2 = [self.tocAsData subdataWithRange:nextMailOffsetRange];
        
        const int32_t *temp;
        const int32_t *temp2;

        temp = [data1 bytes];
        temp2 = [data2 bytes];
        
        chunkStart = chunkStart+chunkSizeAsInt;
        
        chunkSizeAsInt = CFSwapInt32BigToHost(*temp);
        
        nextEmailOffset = CFSwapInt32BigToHost(*temp2);
        
       
    }
    
    return [NSArray arrayWithArray:array];

}

@end
