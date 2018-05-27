---
uid: osmsharp
title: OsmSharp
---

# Overview

OsmSharp is a project that started with using [OpenStreetMap (OSM)](http://osm.org) data for some pretty awesome mapping projects. You can use OsmSharp in your projects when you need to work with OSM data.

OsmSharp is written in C# and can be used anywhere where the language is supported.

# Documentation

1. @openstreetmap-data-model
1. **Samples**
  - [Filtering](https://github.com/OsmSharp/core/tree/develop/samples/Sample.Filter)
  - [Complete Streams](https://github.com/OsmSharp/core/tree/develop/samples/Sample.CompleteStream)
  - [Converting to geometries/features](https://github.com/OsmSharp/core/tree/develop/samples/Sample.GeometryStream)
  - [Filtering by polygon/bounding box](https://github.com/OsmSharp/core/tree/develop/samples/Sample.GeoFilter)

# Related projects

OsmSharp used to do anything mapping-related: routing, data processing, rendering vector data. That's just too much for one project so we collaborate with other projects in the .NET space:

* [NTS](https://github.com/NetTopologySuite/NetTopologySuite): A geo-library, you can use this together with **OsmSharp.Geo** to convert OSM data to shapefile or filter out some data and convert it to GeoJSON.
* [Itinero](https://github.com/itinero/): Itinero is a routing project for .NET. Orignally a part of OsmSharp as _OsmSharp.Routing_, now renamed **Itinero**. 
* [Mapsui](https://github.com/pauldendulk/Mapsui): One of the better mapping UI components in the .NET space. Use this if you need a mapping component!