

Advanced options
================

This document details more features of the library.

Loading timeframes automatically and automatic database management
------------------------------------------------------------------

This sections introduces all the different ways to automatically load data into the database and a way to execute tasks on scheduled intervals - a bit like crontab does.

### Using a fixed time window

When only a small, fixed time window has to be loaded once, use


        DateTime windowStart = ...
        DateTime windowEnd = ...
        transitDb.UseLinkedConnections(connections, locations, windowStart, windowEnd);
        
This will download all the connections between `windowStart` and `windowEnd`. They will _not_ be updated automatically.

### Using an update policy

A second option is to pass an _update policy_, an object which tells what data should be updated at which intervals.

One update policy is the `SynchronizedWindow`, which is regularly invoked and will calculate a timewindow that should be updated.

One can be created with:

        var updatePolicy = new SynchronizedWindow(
                        // The number of seconds between each invokement of this update
                        (uint) interval
                        // Determines the start of the updated time window. 
                        // InvokeTime - timeBefore = the start of the updated window
                        TimeSpan.FromSeconds(timeBefore),
                        // Determines the end of the updated time window
                        // InvokeTime + timeAfter = the end of the updated window
                        TimeSpan.FromSeconds(timeAfter),
                        // If something fails, how many retries are attempted
                        // Default value: 0
                        (uint) retries,
                        // If false, if a certain part of the time window is already downloaded, it will not be redownloaded
                        // If true, the entire time window will be downloaded and updated
                        // Default value: false
                        update
                    );


Using this update policy, the Linked Connections can be installed with:


        transitDb.UseLinkedConnections(connections, locations, updatePolicy);
        
        
This will _immediately_ invoke the update policy on a seperate thread. After the specified number of seconds, the update window will trigger again.

### Using multiple update policies

Having a single update policy can be limiting. For example, the data for the next week should be cached and downloaded e.g. daily, while the data for the next hour contains realtime delay information and should be downloaded every minute.

For this, multiple update policies can be specified:

        var weekUpdate = new SynchronizedWindow(
                        (uint) 24*60*60, // daily
                        TimeSpan.FromSeconds(0), // From now...
                        TimeSpan.FromDays(7), // ... till the next week
                        // update is not specified: if a day is already downloaded, no new download will be attempted
                    );

        var hourUpdate = new SynchronizedWindow(
                        (uint) 60, // every minute
                        TimeSpan.FromSeconds(0),
                        TimeSpan.FromHours(1), // Update the next hour
                        update = true // Do redownload the data
                    );


        transitDb.UseLinkedConnections(connections, locations, weekUpdate, hourUpdate);
        
There is no limit on the number of update policies:

        transitDb.UseLinkedConnections(connections, locations, updatePolicy1, updatePolicy2, updatePolicy3, ...);

Alternatively, a list of update policies can be given:

        List<UPdatePolicy> allUpdatePolicies = ...
        transitDb.UseLinkedConnections(connections, locations, allUpdatePolicies);

### Having a look into the state of the database and the running processes

**Advanced feature**: _This feature is only added for convenience_

When installing Linked Connections with at least one update policy, the object responsible for executing them is returned together with the underlying linked connections dataset. They can be captured with


         var (synchronizer, lcProfile) = transitDb.UseLinkedConnections(connections, locations, ... one or more update policies ...)
         
The synchronizer can give some insight in the state of the database. To know what process is currently running, use:

        synchronizer.CurrentlyRunning.ToString()
        
To know what time windows are loaded, use

         synchronizer.LoadedTimeWindows
        

### Adding your own processess


 **Advanced feature**: _This feature is only added for convenience_
 
For some applications, an extra, regularly timed task should be run - e.g. to determine the importance of stations based on the number of trains.

This can be done by implementing `UpdatePolicy` and passing your own update policy when invoking as above.

The most important method to implement is `public void Run(DateTime triggerDate, TransitDbUpdater updater)`, giving the date of invocation and an object allowing updates.

To get the latest snapshot out of the updater, use:  `updater.TransitDb.Latest`.

Also note that the `triggerDate` is rounded down and stabilized. Never use `DateTime.Now` within the method.

Apart of the `Run`-method, some straightforward properties should be implemented. Refer to the documentation and let your IDE guide you for those.

Setting up a advanced profile
-----------------------------

The *profile* contains personal preferences of the traveller, such as:

- Which public transport providers are available
- The walking time between stops
- How much time is needed to get from one vehicle to another
- Which metrics are used to compare journeys

A profile can be constructed with:

        var p = new Profile
                <TransferMetric>         // The metrics used, here total travel time and number of transfers are minimized
                    (
                    
                    // The time it takes to transfer from one train to another (and the underlying algorithm, in this case: always the same time)
                    new InternalTransferGenerator(180 /*seconds*/), 

                    // The intermodal stop algorithm. Note that a transitDb is used to search stop location
                    new CrowsFlightTransferGenerator(transitDb, maxDistance: 500 /*meter*/,  walkingSpeed: 1.4 /*meter/second*/),
                    
                    // The object that can create a metric
                    TransferMetric.Factory,
                    
                    // The comparison between routes. _This comparison should check if two journeys are covering each other, as seen in core concepts!_
                    TransferMetric.ProfileTransferCompare
                    ); 
                    
                    
Different calculation modes
---------------------------

The library allows a few different modes to calculate journeys, depending on your needs.

### General notes

All functions calculating journeys require a transitdb (actually a `snapshot`) with the connections, a `profile` with preferences and a timeframe with `departure time` and `arrival time`.

It can be tempting to pass `DateTime.MaxValue` if no arrival time is specified (or analogously `DateTime.MinValue` for departure time). **Don't do this**. If an unreachable location is passed, the program will never stop.

Most functions will also take a `from` and `to`, identifiers for the locations where the traveller whishes to departs or to arrive.




### Earliest Arrival

If only the first journey from a certain stop to another is needed, use 'CalculateEarliestArrival'. This give will you the journey which arrives the earliest at the destination.
This will _not_ calculate alternatives, so the calculation is very fast. However, a journey which is just as fast and has e.g. less transfers will not be found.


        public static Journey<T> CalculateEarliestArrival<T>(
                this TransitDb.TransitDbSnapShot snapshot,
                Profile<T> profile, 
                string fromId, string toId, 
                DateTime departure, DateTime lastArrival) where T : IJourneyMetric<T>
    
    
    
There is a special variation available too. If the EAS is just a first step onto calculating a set of possible journeys, the calculations here can make a run of `CalculateJourneys` faster.
The requirements for these are:

- The departure station should be the same
- The departure time should be the same
- The passed arrival time (which acts as a timeout) should fall at or behind the arrival time of the 'calculateJourneys'.

If these requirements are fullfilled, use the following function and save the 'IConnectionFilter' for later use:

        public static Journey<T> CalculateEarliestArrival<T>(
            this TransitDb.TransitDbSnapShot snapshot,
            Profile<T> profile,
            LocationId fromId, LocationId toId, 
            out IConnectionFilter filter,
            DateTime departure, Func<DateTime, DateTime, DateTime> stopCalculatingAt = null) where T : IJourneyMetric<T>
   
The passed function will force the algorithm to extend the scanned timeframe.

### Latest Departure

If the traveller wishes to arrive at a certain location at a certain time and wishes to know at what latest time she should depart to still arrive in time, then `snapshot.CalculateLatestJourney` is the needed function.

### Isochrones

If a traveller wishes to know everywhere they could get by a certain time if departing at a certain location at a certain time, the needed function is:

        public static IReadOnlyDictionary<LocationId, Journey<T>> CalculateIsochrone<T>(this TransitDb.TransitDbSnapShot snapshot, Profile<T> profile, string from, DateTime departure, DateTime lastArrival);
    
    
Analogously, if the traveller wishes to arrive at a certain location at a certain time, they can calculate at what places they should depart at what times with:

        public static IReadOnlyDictionary<LocationId, Journey<T>> CalculateIsochroneLatestArrival<T>(this TransitDb.TransitDbSnapShot snapshot, Profile<T> profile, string from, DateTime departure, DateTime lastArrival);
    
### Multiple, optimal journeys within a timeframe

Of course, the most useful function is to calculate all optimal, possible journeys from A to B wihtin a timeframe.

  public static List<Journey<T>> CalculateJourneys<T>(this TransitDb.TransitDbSnapShot snapshot,
            Profile<T> profile,
            LocationId departureStop, LocationId arrivalStop,
            DateTime departure,
            DateTime arrival,
            IConnectionFilter filter = null)
            
If an Earliest Arrival Journey has been calculated previously, use the then constructed filter to dramatically speed up the calculations.

These journeys are optimal with respect to the comparator defined in the profile, over a metric such as `TransferMetric`. These can be changed or custom-made if necessary.



















