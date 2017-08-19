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

#### Why?
Loading raw data, [OpenStreetMap (OSM)](../data-sources/openstreetmap.md) or a routing network from [shapefiles](../data-sources/shapefiles.md), takes a while and is very inefficiënt. There is so much more data in OSM than just the road network, so it's also more efficiënt to only keep what we need. 

It all comes down to this:

- The router db can be used to prevent the need to reload the entire network from it's raw data. 
- It can be used on mobile devices using a memory mapping strategy.
- It can be preprocessed somewhere and used somewhere else.
- The routing application is independent of the data-source format.

## Creating a database

For more information on creating a router db check the @data-sources section.

## Loading a router db

Loading a router db can be done with just the Itinero package installed and can be done in two ways:

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

## What to read next?

Learn more about the @router.