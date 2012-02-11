//
//  CTPerformanceMeasurement.h
//  SampleApplication
//
//  Created by Oliver Letterer on 11.02.12.
//  Copyright (c) 2012 Home. All rights reserved.
//

typedef uint64_t CTTimeInterval;

typedef enum {
    CTTimeUnitSeconds = 0
} CTTimeUnit;

/**
 Starts counting time.
 */
void CTTick(void);

/**
 Stops counting time and returns 
 */
CTTimeInterval CTTock(void);

/**
 Converts CTTimeInterval into a given unit.
 */
CFTimeInterval CTTimeIntervalConvert(CTTimeInterval timeInterval, CTTimeUnit destinationUnit);
