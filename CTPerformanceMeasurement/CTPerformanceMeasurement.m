//
//  CTPerformanceMeasurement.c
//  SampleApplication
//
//  Created by Oliver Letterer on 11.02.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "CTPerformanceMeasurement.h"
#import <CoreFoundation/CoreFoundation.h>
#import <dispatch/dispatch.h>
#include <mach/mach_time.h>
#import <Foundation/Foundation.h>

#pragma mark - private

static CFMutableArrayRef _timeArray = NULL;

const void *CTArrayRetainCallBack(CFAllocatorRef allocator, const void *value);
const void *CTArrayRetainCallBack(CFAllocatorRef allocator, const void *value)
{
    return value;
}

void CTArrayReleaseCallBack(CFAllocatorRef allocator, const void *value);
void CTArrayReleaseCallBack(CFAllocatorRef allocator, const void *value)
{
    
}

CFStringRef	CTArrayCopyDescriptionCallBack(const void *value);
CFStringRef	CTArrayCopyDescriptionCallBack(const void *value)
{
    return CFStringCreateWithFormat(NULL, NULL, CFSTR("%llu"), (uint64_t)value);
}


Boolean	CTArrayEqualCallBack(const void *value1, const void *value2);
Boolean	CTArrayEqualCallBack(const void *value1, const void *value2)
{
    return value1 == value2;
}

#pragma mark - public

void CTTick(void)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFArrayCallBacks callbacks = {
            0,
            CTArrayRetainCallBack,
            CTArrayReleaseCallBack,
            CTArrayCopyDescriptionCallBack,
            CTArrayEqualCallBack};
        _timeArray = CFArrayCreateMutable(NULL, 0, &callbacks);
    });
    CFArrayAppendValue(_timeArray, (void *)mach_absolute_time());
}

uint64_t CTTock(void)
{
    if (!_timeArray) {
        return 0;
    }
    
    CFIndex count = CFArrayGetCount(_timeArray);
    if (count > 0) {
        uint64_t lastTime = (uint64_t)CFArrayGetValueAtIndex(_timeArray, count - 1);
        CFArrayRemoveValueAtIndex(_timeArray, count - 1);
        return mach_absolute_time() - lastTime;
    } else {
        return 0;
    }
}

CFTimeInterval CTTimeIntervalConvert(CTTimeInterval timeInterval, CTTimeUnit destinationUnit)
{
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    
    timeInterval *= info.numer;
    timeInterval /= info.denom;
    
    switch (destinationUnit) {
        case CTTimeUnitSeconds:
            return (CFTimeInterval)timeInterval * 1e-9;
            break;
            
        default:
            return 0.0;
            break;
    }
}
