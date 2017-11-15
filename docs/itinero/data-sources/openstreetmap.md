---
uid: openstreetmap
title: OpenStreetMap (OSM)
---

# OpenStreetMap (OSM)

Itinero is built to idependent of it's data source but OSM is the preferred source of data and to be honest, we wouldn't know why you would use something else. It's open, it's free and you can fix issue in the data yourself.

## Getting data

Getting data is easy, just download one of the [osm.pbf](http://wiki.openstreetmap.org/wiki/PBF_Format) files [here](http://download.geofabrik.de/).

Itinero can handle any individual country, make sure you have enough time and RAM on your machine before trying to process the planet.

## Processing the data

You can do this in code, just install ```Itinero.IO.Osm``` and run the following code:

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

### IDP - Itinero Data Processor

We also provide a CLI tool, called [IDP](https://github.com/itinero/idp), to process raw OSM files and turn them into routerdb's.

#### Usage

You can download the latest builds here:

http://files.itinero.tech/builds/idp/

Build a RouterDb for cars

`idp --read-pbf path/to/some-file.osm.pbf --pr --create-routerdb vehicles=car --write-routerdb some-file.routerdb`

- read-pbf: reads an OSM-PBF file.
- pr: shows progress information.
- create-routerdb: creates a routerdb in this case only for cars.
- write-router: writes the routerdb to disk.

Build a RouterDb for pedestrians and bicycle and add a contracted graph for both:

`idp --read-pbf path/to/some-file.osm.pbf --pr --create-routerdb vehicles=bicycle,pedestrian --contract bicycle --contract pedestrian --write-routerdb some-file.routerdb`

- contract: adds a contracted version of the routing graph to the routerdb.

