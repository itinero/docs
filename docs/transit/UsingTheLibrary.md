Once the [core concepts](index.md) are clear, using the library in your project should be quite easy.
This document gives an overview of most of the important options.

**Important**: This section is subject to change! While the big outlines will remain the same, the code below will be streamlined. Expect (small) breaking changes in the coming months.

Performing route planning queries (at the bare minimum) consists of the following parts:

1. Setting up a provider
2. Setting up a profile
3. Asking a query


Setting up a Linked-Connections provider
----------------------------------------

As noted, the library needs a server which offers all the information as [Linked Connections](linkedconnections.org).
A linked Connections dataset has two entry points:

 - A web resource which contains all stops
 - Multiple web resources which contain the connections in a timewindow (with a link to a next and previous timetable)

Search for these links (or ask for them) on your public transport provider website.

Then, create a new TransitDB:


        using Itinero.Transit.IO.LC;
        
        ...
        
        Uri connections = <...>
        Uri locations = <...>
        
        TransitDB transitDb = new TransitDb();

After this, the linked connections can be loaded into the Transit Database. However, the database does not know what time period should be loaded. The coming week? The coming month? Perhaps yesterday as well? Should the data be refreshed regularly? If so, at what frequencies?

For each of these use cases, methods are provided.
The following paragraphs give each of the options, but should not be combined.


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

Setting up a profile
--------------------

The *profile* contains personal preferences of the traveller, such as:

- Which public transport providers are available
- The walking time between stops
- How much time is needed to get from one vehicle to another
- Which metrics are used to compare journeys

A profile is constructed with:

        var p = new Profile
                <TransferStats>         // The metrics used, here total travel time and number of transfers are minimized
                    (
                    
                    // The time it takes to transfer from one train to another (and the underlying algorithm, in this case: always the same time)
                    new InternalTransferGenerator(180 /*seconds*/), 

                    // The intermodal stop algorithm. Note that a transitDb is used to search stop location
                    new CrowsFlightTransferGenerator(transitDb, maxDistance: 500 /*meter*/,  walkingSpeed: 1.4 /*meter/second*/),
                    
                    // The object that can create a metric
                    TransferStats.Factory,
                    
                    // The comparison between routes. _This comparison should check if two journeys are covering each other, as seen in core concepts!_
                    TransferStats.ProfileTransferCompare
                    ); 
                    
Asking a query
--------------

Now that all data is gathered, a journey can be requested with:

        var possibleJourneys = transitDB.CalculateJourneys<TransferStats>
            (p,
            from, // a string containing the URI for the departure station
            to, // a string containing the URI for the arrival station
            DateTime? departure = null,     // The (earliest) departure time
            DateTime? arrival = null        // The (latest) arrival time
            );         

This will give a list of journeys.

There are more options available (such as Isochrone lines, Earliest arriving journey or latest arriving journy).
For a full overview, refer to [the generated docs](/_site/api/Itinero.Transit.Algorithms.CSA.ProfileExtensions.html).
