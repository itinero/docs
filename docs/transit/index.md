# Itinero.Transit

This is the documentation of Itinero.Transit, which calculates journeys over public transport networks.

## Quickstart

For those who can't wait to try this out, here is a copy-and-past example for the Belgian Railway, which calculates journeys between two stops:

```csharp
using System;
using Itinero.Transit;
using Itinero.Transit.Data;
using Itinero.Transit.IO.LC;

namespace Sample.SNCB
{
    internal static class Program
    {
        private static void Main(string[] args)
        {
            // create an empty transit db and specify where to get data from, in this case linked connections for the belgian rail operator.
            var transitDb = new TransitDb();
            Console.WriteLine("Loading connections...");
            transitDb.UseLinkedConnections("https://graph.irail.be/sncb/connections",
                "https://irail.be/stations", DateTime.Now, DateTime.Now.AddHours(5));
            
            // get a snapshot of the db to use.
            var snapshot = transitDb.Latest;

            // look up departure/arrival stops.
            var departureStop = snapshot.FindClosestStop(4.9376678466796875,51.322734170650484); // Turnhout
            var arrivalStop = snapshot.FindClosestStop(4.715280532836914,50.88132251839807); // Leuve

            // Create a traveller profile
            var p = new DefaultProfile();

            Console.WriteLine("Calculating journeys...");

            var journeys = snapshot
                .SelectProfile(new DefaultProfile())
                .SelectStops(departureStop, arrivalStop)
                .SelectTimeFrame(DateTime.Now, DateTime.Now.AddHours(3))
                .AllJourneys();
            if (journeys == null || journeys.Count == 0)
            {
                Console.WriteLine("No journeys found.");
            }
            else
            {
                foreach (var journey in journeys)
                {
                    Console.WriteLine(journey.ToString(snapshot));
                }
            }
        }
    }
}
```


## Getting started

Working with Itinero.Transit almost always works in two steps:

1. Setting up the transit data from some source.
2. Use the data do calculate journeys.

To get started it's recommend to check these sections:

- [Basic concepts](basic-concepts/index.md) explains the basic entities and core algorithm of the library
- [Using the library](UsingTheLibrary.md) builds upon the _basic concepts_ and gives the most important usage options.
- [Extensions on CSA](basic-concepts/CSA.md) gives a more thorough understanding of the core algorithm and what practical extensions are made in the library.
