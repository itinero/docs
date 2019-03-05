# Itinero.Transit

This is the documentation of Itinero.Transit. Itinero.Transit calculates journeys over public transport networks.

## Quickstart

For those who can't wait to try this out, the most basic example:

```csharp
// using Itinero.Transit;

// create an empty transit db and specify where to get data from, in this case linked connections.
var transitDb = new TransitDb();
transitDb.UseLinkedConnections("https://graph.irail.be/sncb/connections",
        "https://irail.be/stations", DateTime.Now, DateTime.Now.AddHours(5));

// get a snapshot of the DB to use.
var snapshot = transitDb.Latest;

// look up departure/arrival stops.
var departureStop = snapshot.FindClosestStop(4.9376678466796875,51.322734170650484);
var arrivalStop = snapshot.FindClosestStop(4.715280532836914,50.88132251839807);

// calculate journeys.
var p = new DefaultProfile(); // create a user-profile.
var journeys = snapshot.CalculateJourneys(p, departureStop.Id, arrivalStop.Id, 
        DateTime.Now);
```


## Getting started

Working with Itinero.Transit almost always works in two steps:

1. Setting up the transit data from some source.
2. Use the data do calculate journeys.

To get started it's recommend to check these sections:

- [Basic concepts](basic-concepts/index.md): The basic concepts.
