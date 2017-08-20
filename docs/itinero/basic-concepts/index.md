---
uid: basic-concepts
title: Basic Concepts
---

# Basic Concepts

If you want to start using Itinero as a library it's crucial to understand it's basic concepts. The most important are @routerdb, @router, @profile and @routerpoint:

- @routerdb: Contains **the routing network**, all meta-data, restrictions and so on.
- @router: The router is **where you ask for routes**.
- @profile: Defines **vehicles and their behaviour**.
- @routerpoint: A **location on the routing network** to use as a start or endpoint of a route.

How these tie together:

The @router uses the @routerdb data to calculate routes for a given @profile. It starts and ends the @route at a @routerpoint.

## Example

You can see all of these in action in the following example:

```csharp
// using Itinero;
// using Itinero.IO.Osm;
// using Itinero.Osm.Vehicles;

// load some routing data and build a routing network.
var routerDb = new RouterDb();
using (var stream = new FileInfo(@"/path/to/some/osmfile.osm.pbf").OpenRead())
{
    routerDb.LoadOsmData(stream, Vehicle.Car); // create the network for cars only.
}

// create a router.
var router = new Router(routerDb);

// get a profile.
var profile = Vehicle.Car.Fastest(); // the default OSM car profile.

// create a routerpoint from a location.
// snaps the given location to the nearest routable edge.
var start = router.Resolve(profile, 51.26797020271655f, 4.801905155181885f);
var end = router.Resolve(profile, 51.26797020271655f, 4.801905155181885f);

// calculate a route.
var route = router.Calculate(profile, start, end);
```

So this is happening in the sample, in the same order:
1. Building a routing network from raw OSM-data.
2. Creating a router.
3. Define a profile.
4. Snap the start and end locations of the route to het network.
5. Ask the router for a route.

## What to read next?

Learn more about the individual concepts, starting with the first step, the @routerdb.