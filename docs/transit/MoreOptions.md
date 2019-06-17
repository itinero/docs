

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
                    
                    
Creating an object with preferences
-----------------------------------


All algorithms need some basic data - the transitdb (or collection of transitdbs) to route over, the profile of the traveller, the timeframe, stops, ...

Keeping track of all those parameters happens by constructing an object which keeps track of all those. 
Such a preference object is constructed by chaining a few calls, each with their own objects and very specific methods. These classes are constructed so that an IDE can maximally help you.

### The WithProfile-object

When having one or more transitDbs and a profile to use, one can create a `WithProfile`-object with:

        var withProfile = transitDb.SelectProfile(profile);
        
If one of the algorithm needs walking routes from one stop to another (as specified by the profile), these routes are calculated and cached in the withProfile-object.
Therefore, it is recommended to reuse the withProfile as much as possible. This cache can also be prepoluated by calling `PrecalculateClosestStops()`. 


### Selecting locations

The next steps are selecting locations. In most circumstances, a departure and arrival location are needed. These can be selected with `SelectStops(from, to)`. For your convenience, there are quite some overloads giving freedom in how the stops are identified: using the URI of a stop, the locationId or accepting multiple departurestops and multiple arrivalStops. In the case of e.g. multiple departure stops, the algorithms will choose one of the items in the list to depart from, depending on which one is the fastest (e.g. the latest to depart from, or the earliest to arrive)


When only isochronelines are needed, the method `SelectSingleStop` can be used. Note that `IsochroneFrom` and `IsochroneTo` can still be used if two stops are provided.

### Selecting a timeframe

Once locations have been added, the timeinfo can be added by chaining `.SelectTimeFrame(start, end)`. It is not allowed to pass `DateTime.MaxValue`, `DateTime.MinValue` or similar values. For some cases, this seems contra-intuitive and cumbersome. For example, when the traveller wishes to know when he could arrive if he has to go from A to B, departs at time T0. In this case, no end-time is known and the algorithm should figure that out itself. Here, it is very tempting to pass `DateTime.MaxValue` as default, which normally works... unless the destination B is unreachable! If this is the case, the algorithm will scan away till the end of time, crashing in the end.
We recommend to solve this by using a sensible end time, such as the departure time plus a few hours. 

### Calculating a journey


A this point, a typical program could look like:


        var transitDbs = <... one or more transitdbs, initialized ...>
        var profile = < ... the profile of the traveller ...>
        
        var startTime, endTime = <...>
        
        
        var departureStops = <... one or more departure stops, of which all are equally preferred to depart ...>
        var arrivalStops = <... one or more arrival stops, of which all are equally preferred to arrive ..> 
        
        var withProfile = transitDbs.SelectProfile(profile);
        profile.PrecalculateClosestStops();
        
        var withTime = withProfile.SelectStops(departureStops, arrivalStops)
                            .SelectTimeFrame(startTime, endTime)


The `withTime` object allows to make queries to get the desired results, such as:

        withTime.EarliestJourney()
        withTime.LatestJourney()
        withTime.IsochroneFrom()
        withTime.IsochroneTo()
        withTime.AllJourneys()
        
        
It should be obvious what each of those methods calculate. Refer to the generated documentation of the package for all details.
