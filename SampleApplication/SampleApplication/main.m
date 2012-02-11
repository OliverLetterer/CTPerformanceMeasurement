//
//  main.m
//  SampleApplication
//
//  Created by Oliver Letterer on 11.02.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTPerformanceMeasurement.h"

int main (int argc, const char * argv[])
{
    @autoreleasepool {
        NSUInteger iterations = 3;
        
        for (int i = 0; i < iterations; i++) {
            CTTick();
            sleep(1);
        }
        
        for (int i = 0; i < iterations; i++) {
            CTTimeInterval time = CTTock();
            
            NSLog(@"difference: %llu = %f seconds", time, CTTimeIntervalConvert(time, CTTimeUnitSeconds));
        }
    }
    
    return 0;
}

