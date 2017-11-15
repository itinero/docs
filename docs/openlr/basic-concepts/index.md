---
uid: openlr-basic-concepts
title: Basic Concepts
---

# Basic Concepts

If you want to start using the OpenLR library it's crucial to understand it's basic concepts. The most important are @routerdb, @coder and @coderprofile:

- @routerdb: Contains **the routing network**, all meta-data, restrictions and so on.
- @openlr-coder-profile: A profile to **configure** encoding/decoding parameters.
- @openlr-coder: Interface to all the functionality to **encode/decode**.

How these tie together:

The @openlr-coder uses the @openlr-coder-profile to interpret the data in the @routerdb to encode/decode OpenLR locations.

## Example

You can see all of these in action in the following example:

```csharp
// using Itinero;
// using Itinero.IO.Osm;
// using Itinero.Osm.Vehicles;
// using OpenLR;
// using OpenLR.Osm;
// using OpenLR.Referenced.Locations;
// using System;
// using System.IO;

// load some routing data and build a routing network.
var routerDb = new RouterDb();
using (var stream = new FileInfo(@"/path/to/some/osmfile.osm.pbf").OpenRead())
{
    routerDb.LoadOsmData(stream, Vehicle.Car); // create the network for cars only.
}

// create coder.
var coderProfile = new OsmCoderProfile();
var coder = new Coder(routerDb, coderProfile);

// build a line location from a shortest path.
// REMARK: this functionality is NOT part of the OpenLR-spec, just a convenient way to build a line location.
var line = coder.BuildLine(
    new Itinero.LocalGeo.Coordinate(49.67218282319583f, 6.142280101776122f),
    new Itinero.LocalGeo.Coordinate(49.67776489459803f, 6.1342549324035645f));

// encode this location.
var encoded = coder.Encode(line);

// decode this location.
var decodedLine = coder.Decode(encoded) as ReferencedLine;
```

So this is happening in the sample, in the same order:
1. Building a routing network from raw OSM-data.
2. Define a @openlr-coder-profile.
3. Create the @openlr-coder.
4. Build a line location.
5. Encode the line location.
6. Decode the line location.

## What to read next?

Learn more about the individual concepts, starting with the first step, the @openlr-coder-profile.