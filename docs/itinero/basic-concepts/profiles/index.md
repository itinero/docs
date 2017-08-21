---
uid: profile
title: Profile
---

# Profile

A profile is the most important concept to configure routing. There are two important concepts related to this:

- Vehicle: A **definition of a vehicle** that travels the network. This can be a _car_ but also a _pedestrian_ for example.
- Profile: A profile describes **the behaviour of a vehicle**. 

## Default profiles

A few default vehicle profiles are available, but only for @openstreetmap.

#### OpenStreetMap (OSM)

If you are only planning on using @openstreetmap and you just need a default profile these are available:

- _Car_ (```Itinero.Osm.Vehicles.Vehicle.Car```): A default car profile, all restrictions enabled.
	- _Fastest_: Calculates fastest functional routes.
	- _Shortest_: The shortest route.
	- _Classifications_: Follows a bit more aggressively the road classifications.
- Bicycle (```Itinero.Osm.Vehicles.Vehicle.Bicycle```): A default bicycle profile.
	- _Fastest_: Calculates fastest functional routes.
	- _Shortest_: The shortest route.
	- _Balanced_: Chooses dedicated cycling infrastructure.
	- _Networks_: Chooses dedicated cycling networks.
- _Pedestrian_ (```Itinero.Osm.Vehicles.Vehicle.Pedestrian```): A default pedestrian profile.
	- _Shortest_: The shortest route.

You can use the profiles as follows:

```csharp
// using Itinero;
// using Itinero.IO.Osm;
// using Itinero.Osm.Vehicles;

// get a profile.
var profile = Vehicle.Car.Fastest(); // the default OSM car profile.
```

## Custom profiles

One of the most important features in Itinero is the option to define your own profiles and completely customize them using either:

- @lua-profile: A scripting language, this allows embedding the profiles in the @routerdb. **This is the default and preferred option.**
- @csharp-profile: Define your profiles in C#, or any other .NET language for that matter.

## What to read next?

Learn more about the @routerpoint concept.