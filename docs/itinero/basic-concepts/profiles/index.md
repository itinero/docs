---
uid: profile
title: Profile
---

# Profile

A profile is the most important concept to configure routing. There are two important concepts related to this:

- Vehicle: A **definition of a vehicle** that travels the network. This can be a _car_ but also a _pedestrian_ for example.
- Profile: A profile describes **the behaviour of a vehicle**. 

For a car for example there is the definition of _car_, this means, where can it travel over the network, what is it's maximum speed and so on. How the car behaves, the profile, defines the route it will take, for example _fastest_ or _shortest_. For bicycles this could be _recreational_ meaning this profile focuses on nice routes quiet routes.

## Default profiles

A few default vehicle profiles are available, but only for @openstreetmap.

#### OpenStreetMap (OSM)

If you are only planning on using @openstreetmap and you just need a default profile these are available:

- Car (```Itinero.Osm.Vehicles.Vehicle.Car```): A default car profile, all restrictions enabled.
	- Fastest: Calculates fastest functional routes.
	- Shortest: The shortest route.
	- Classifications: Follows a bit more aggressively the road classifications.
- Bicycle (```Itinero.Osm.Vehicles.Vehicle.Bicycle```): A default bicycle profile.
	- Fastest: Calculates fastest functional routes.
	- Shortest: The shortest route.
	- Balanced: Chooses dedicated cycling infrastructure.
	- Networks: Chooses dedicated cycling networks.
- Pedestrian (```Itinero.Osm.Vehicles.Vehicle.Pedestrian```): A default pedestrian profile.
	- Shortest: The shortest route.

## Custom profiles

You can define profiles and completely customize them using either:

- @lua-profile: A scripting language, this allows embedding the profiles in the @routerdb. **This is the default and preferred option.**
- @csharp-profile: Define your profiles in C#, or any other .NET language for that matter.

## What to read next?

Learn more about the @routerpoint concept.