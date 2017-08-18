Itinero Documentation
=====================

This is the main technical documentation for Itinero and related tools.

# Itinero

![Build status](http://build.osmsharp.com/app/rest/builds/buildType:(id:Itinero_RoutingDevelop)/statusIcon)
[![GPL licensed](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://github.com/itinero/routing/blob/develop/LICENSE.md)

- Itinero: [![NuGet](https://img.shields.io/nuget/v/Itinero.svg?style=flat)](https://www.nuget.org/packages/Itinero/)  
- Itinero.Geo: [![NuGet](https://img.shields.io/nuget/v/Itinero.Geo.svg?style=flat)](https://www.nuget.org/packages/Itinero.Geo/)  
- Itinero.IO.Osm: [![NuGet](https://img.shields.io/nuget/v/Itinero.IO.Osm.svg?style=flat)](https://www.nuget.org/packages/Itinero.IO.Osm/)
- Itinero.IO.Shape: [![NuGet](https://img.shields.io/nuget/v/Itinero.IO.Shape.svg?style=flat)](https://www.nuget.org/packages/Itinero.IO.Shape/)

**Itinero** is a library for .NET/Mono to calculate routes in a road network. By default the routing network is based on OpenStreetMap (OSM) but it's possible to load any road network. The most important features:

- Calculating routes from A->B.
- Calculating distance/time matrices between a set of locations.
- Processing OSM-data into a routable network.
- Processing data from shapefiles into a routable network.
- Generating turn-by-turn instructions.
- Memory-mapped data storage for routing on mobile devices and lower-resource environments.

Several algorithms are implemented for different scenarios: Dijkstra, A*, and Contraction Hierarchies.

# GTFS

.NET implementation of a General Transit Feed Specification (GTFS) feed parser. (see https://developers.google.com/transit/gtfs/reference)

![Build status](http://build.osmsharp.com/app/rest/builds/buildType:(id:Itinero_Gtfs)/statusIcon)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/itinero/GTFS/blob/develop/LICENSE)

- GTFS: [![NuGet](https://img.shields.io/nuget/v/GTFS.svg?style=flat)](http://www.nuget.org/packages/GTFS)  

# OpenLR

![Build status](http://build.itinero.tech/app/rest/builds/buildType:(id:Itinero_Openlr)/statusIcon)
[![GPL licensed](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://github.com/itinero/openlr/blob/develop/LICENSE.md)

- OpenLR: [![NuGet](https://img.shields.io/nuget/v/OpenLR.svg?style=flat)](https://www.nuget.org/packages/OpenLR/)  
- OpenLR.Geo: [![NuGet](https://img.shields.io/nuget/v/OpenLR.Geo.svg?style=flat)](https://www.nuget.org/packages/OpenLR.Geo/)  

An implementation of the OpenLR (Open Location Reference) protocol using Itinero. Development was initially sponsered by via.nl (http://via.nl/) and Be-Mobile (http://www.be-mobile-international.com/). 
