# CTPerformanceMeasurement

## Usage

```c
// start counting time
CTTick();

// perform some heavy task

// stop counting time
CTTimeInterval difference = CTTock();

// convert into seconds
CFTimeInterval timeInSeconds = CTTimeIntervalConvert(difference, CTTimeUnitSeconds);
```

## License
MIT