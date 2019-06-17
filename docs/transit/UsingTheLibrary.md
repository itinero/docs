Once the [core concepts](index.md) are clear, using the library in your project should be quite easy.
This document gives a minimal example to calculate routes. More features are explained [here](MoreOptions.md)

**Important**: This section describes the 1.0-API, which might still slightly change. v1.1 might slightly change.

Performing route planning queries (at the bare minimum) consists of the following parts:

1. Creating a TransitDb
2. Loading data into the TransitDb
3. Setting up a profile
4. Asking a query


Creating a TransitDb
--------------------

Creating a TransitDb can be done trivially:


        using Itinero.Transit;
        using Itinero.Transit.Data;
        
        ...
        
        var transitDb = new TransitDb();
        

Setting up a Linked-Connections provider
----------------------------------------

The library needs a server which offers all the information as [Linked Connections](linkedconnections.org).
A linked Connections dataset has two entry points:

 - A web resource which contains all stops
 - Multiple web resources which contain the connections in a timewindow (with a link to a next and previous timetable)

Search for these links on your public transport provider website or ask for them.

When found, the linked connections can be loaded into the Transit Database.
The simplest way is to load a certain timeframe - although automatically reloading them at regular intervals is supported too.


        using Itinero.Transit.IO.LC;
        
        ...
        
        Uri connections = <...>
        Uri locations = <...>
        

For each of these use cases, methods are provided.

The simplest way of loading data is simply to request a fixed timeframe once:

        DateTime windowStart = ...
        DateTime windowEnd = ...
        transitDb.UseLinkedConnections(connections, locations, windowStart, windowEnd);


Setting up a profile
--------------------

A profile contains all preferences of the traveller, e.g. how long they takes to transfer trains within a station, how fast they walk, ...

For now, we'll keep things simple and use a default profile:

        var profile = new DefaultProfile();

                    
Asking a query
--------------

Now that all data is gathered, a journey can be requested. To request queries, an object has to be created which contains all the parameters and settings.

        // Find a departure stop by closes coordinate
        var departureStop = snapshot.FindClosestStop(4.9376678466796875,51.322734170650484); // Turnhout
        // Alternatively, find a stop by URL
        var arrivalStop = snapshot.FindStop("http://irail.be/stations/NMBS/008833001"); // Leuven


        var preferences =
                // Start with a (collection of) transitDb 
                snapshot                        
                    // Select the profile to use. Note that this uses '.Latest' in the background; this is thus threadsafe and transitDBs can be updated in the background in the meanwhile
                    .SelectProfile(profile)     
                    
                    // OPTIONAL: calculate all the walking routes between all the stations. Takes a few seconds and MB-rams but speeds up queries
                    .PrecalculateClosestStops()
                    
                    // Select the stops from and to. These can be lists of stops too
                    .SelectStops(departureStop, arrivalStop)

                    // And at last, select a timeframe. When should the journey depart and arrive?
                    .SelectTimeFrame(DateTime.Now, DateTime.Now.AddHours(3))

Once the preferences are constructed, this can be used to generate journeys, such as a single earliest arriving journey:

        var eas = preferences.EarliestArrival();

Or a list of pareto-optimal journeys for the given timeframe:

        // And at last, actually calculate the journeys!
        var journeys = preferences.AllJourneys(); 
        

Always try to reuse the preferences-object as calculating one piece (such as the `isochroneFrom`) can speed up others (such as `Alljourneys`).

There are more options available (such as Isochrone lines, Earliest arriving journey or latest arriving journey).
Have a look at [the advanced section](MoreOptions.md)
