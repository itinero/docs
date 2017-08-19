# Itinero

Welcome to the Itinero routing core documentation. 

You can use Itinero as a library or as a routing server. This documentation is focused on using Itinero as a library, **to quickly setup a routing server, check [this part](routing-api.md) of the docs**.

## Getting started

Working with Itinero almost always works in two steps:

1. Load data from some source to build a routing network.
2. Use the preprocessed data in some application.

So to get started with Itinero it's recommend to first check these sections:

- [Basic concepts](basic-concepts/index.md): The basic concepts of Itinero.
- [Data sources](data-sources/index.md): Where to get data.

### Install Itinero in a .NET project

The following packages are available:
- Itinero [![NuGet](https://img.shields.io/nuget/v/Itinero.svg?style=flat)](https://www.nuget.org/packages/Itinero/) : The Itinero routing core, this is usually the only package you need to install.
- Itinero.Geo [![NuGet](https://img.shields.io/nuget/v/Itinero.Geo.svg?style=flat)](https://www.nuget.org/packages/Itinero.Geo/) : This package ensures compatibility with [NTS](https://github.com/nettopologysuite/nettopologysuite).
- Itinero.IO.Osm [![NuGet](https://img.shields.io/nuget/v/Itinero.IO.Osm.svg?style=flat)](https://www.nuget.org/packages/Itinero.IO.Osm/) : This package contains code to load OSM data.
- Itinero.IO.Shape [![NuGet](https://img.shields.io/nuget/v/Itinero.IO.Shape.svg?style=flat)](https://www.nuget.org/packages/Itinero.IO.Shape/) : This package contains code to load data from shapefiles.

### Example

For those who really can't wait to get something up-and-running: A routing example to calculate one A->B route. First build a router db and a router, and then calculate a route:

```csharp
// using Itinero;
// using Itinero.IO.Osm;
// using Itinero.Osm.Vehicles;

// load some routing data and create a router.
var routerDb = new RouterDb();
using (var stream = new FileInfo(@"/path/to/some/osmfile.osm.pbf").OpenRead())
{
    routerDb.LoadOsmData(stream, Vehicle.Car);
}
var router = new Router(routerDb);

// calculate a route.
var route = router.Calculate(Vehicle.Car.Fastest(),
    51.26797020271655f, 4.801905155181885f, 51.26100849597512f, 4.780721068382263f);
var geoJson = route.ToGeoJson();
```
