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

Now that all data is gathered, a journey can be requested.

        // Get a snapshot to work with. The transitDB can be updated in the meanwhile by another thread
        var snapshot = transitDb.Latest;

        // look up departure/arrival stops.
        var departureStop = snapshot.FindClosestStop(4.9376678466796875,51.322734170650484); // Turnhout
        var arrivalStop = snapshot.FindClosestStop(4.715280532836914,50.88132251839807); // Leuve

        // Alternatively, FindStop(this TransitDb.TransitDbSnapShot snapshot, string locationId, string errMsg = null) could be used

        Console.WriteLine("Calculating journeys...");

        var journeys = snapshot.CalculateJourneys(p, departureStop, arrivalStop, 
            DateTime.Now, DateTime.Now.Add(TimeSpan.FromHours(3))); 

This will give a list of pareto-optimal journeys between the given stops during the given timeframe.

There are more options available (such as Isochrone lines, Earliest arriving journey or latest arriving journey).
Have a look at [the advanced section](MoreOptions.md)
