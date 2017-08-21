---
uid: routerdb
title: RouterDb
---

# RouterDb

The router db **contains all data related to a routing network**:

- **Geometry**: The location of vertices and the shapes of the edges.
- **Topology**: How vertices and edges linked together.
- **Meta-data**: Data about edges and vertices, think streetnames and road classifications.

On top of that it can also contain optimized versions of the network dedicated to specific routing profiles.

## Reading/Writing

A fresh router db can be created by using an external [data source](../data-sources/index.md). Afterwards it can be written to disk, as a single file, and loaded again for later use. It can be transferred to mobile devices or used inside a routing service.

## Creating a database

For more information on creating a router db check the @data-sources section. The most basic example is creating a router db from RAW @openstreetmap data:

```csharp
// using Itinero;
// using Itinero.IO.Osm;
// using Itinero.Osm.Vehicles;

// load some routing data and build a routing network.
var routerDb = new RouterDb();
using (var stream = new FileInfo(@"/path/to/some/osmfile.osm.pbf").OpenRead())
{
    // create the network for cars only.
    routerDb.LoadOsmData(stream, Vehicle.Car); 
}

// write the routerdb to disk.
using (var stream = new FileInfo(@"/path/to/some/file.routerdb").Open(FileMode.Create))
{
   routerDb.Serialize(stream);
}
```

## Loading a router db

To load a router db just install the Itinero package. Loading the router db can be done in two ways:

#### In memory
This just loads all the data in RAM, usually the best option:

```csharp
var routerDb = RouterDb.Deserialize(stream);
```

#### Memory mapped
This is the alternative for when on a mobile device or when you don't have a lot for memory available. **Routing will be slower** when using this option and you need to keep the stream open:

```csharp
var routerDb = RouterDb.Deserialize(stream, RouterDbProfile.NoCache);
```

## Why?

Loading raw data, [OpenStreetMap (OSM)](../data-sources/openstreetmap.md) or a routing network from [shapefiles](../data-sources/shapefiles.md), takes a while and is very inefficiënt. There is so much more data in OSM than just the road network, so it's also more efficiënt to only keep what we need. 

It all comes down to this:

- The router db can be used to prevent the need to reload the entire network from it's raw data. 
- It can be used on mobile devices using a memory mapping strategy.
- It can be preprocessed somewhere and used somewhere else.
- The routing application is independent of the data-source format.

## What to read next?

Learn more about the @profile concept.