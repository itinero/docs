# Roadmap

This is an overview of features that are either in development or on the roadmap. This roadmap is determined by a few factors:

- Priorities of our clients: This is the main factor because we're getting paid to build this stuff and this means more time and resource to get things done.
- Technical dependencies: We can't build things out of order, some features depend on others. We cant support turning costs for example without implementing edge-based routing.
- Priorities of Itinero and it's maintainers: We will don't include things in Itinero that we believe don't belong in the core library, even for clients. We also try to determine what is most valuable for as many users. 

This means you can influence this roadmap by either becoming a client, help with solving technical dependencies or communicate about what you think is missing in Itinero.

## Itinero

This is the roadmap for the Itinero core project. This corresponds to the following packages:

- Itinero: [![NuGet Badge](https://buildstats.info/nuget/Itinero)](https://www.nuget.org/packages/Itinero/)
- Itinero.Geo: [![NuGet Badge](https://buildstats.info/nuget/Itinero.Geo)](https://www.nuget.org/packages/Itinero.Geo/)
- Itinero.IO.Osm: [![NuGet Badge](https://buildstats.info/nuget/Itinero.IO.Osm)](https://www.nuget.org/packages/Itinero.IO.Osm/)
- Itinero.IO.Shape: [![NuGet Badge](https://buildstats.info/nuget/Itinero.IO.Shape)](https://www.nuget.org/packages/Itinero.IO.Shape/)

### Itinero 1

#### Version 1.1

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.1.0.md*

This contains some ideas on some non-breaking extensions on top of v1.0.

- Add a weight matrix calculation algorithm that calculates edge->edge weights excluding the source-target edge weights. *DONE*
  - Check to see if the current edge-based matrix algorithm can be replaced by this more general case. *DONE*
- And several other issues and ideas: [Milestone for 1.1](https://github.com/itinero/routing/milestone/3) *DONE*

#### Version 1.2

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.2.0.md*

- Fixed maxspeed normalization issue.
- Implemented support for nested relations by allowing multiple passes over relations if requested.
- Implemented support for nested cycle route relations in the default bicycle profile.
- Fixed directed weight matrix issue related to resolved points on oneway segments.

#### Version 1.3

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.3.0.md*

- Meta-data on vertices: More details [here](https://github.com/itinero/routing/wiki/Development-Plan:--Meta-data-on-vertices).
- A way to extract parts of the network and save them as a new routerDb.

#### Version 1.4

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.4.0.md*

- Added support for elevation, an example with [SRTM](https://github.com/itinero/srtm) is available [here](https://github.com/itinero/routing/tree/develop/samples/Sample.Elevation).
- .NET core support for Itinero.IO.Shape and Itinero.Geo. (Thanks NTS!)
- CancellationToken support in most algorithms.
- Improved the Itinero native Geo operations.
- Support for extra data (non-attributes) to be linked to edges and vertices.
- Support for keeping OSM way/node IDs.
- Support for removing restrictions from RouterDb.
- AttributesIndex is writeable after serializing RouterDb.
- Support to start/end routes in a given direction (angle).
- Support for island detection: this feature makes sure all resolved points can be routed.
- Support for optimizing a sequence to prevent u-turns.
- Support for cached routerpoints to prevent recalculation.
- Support for disabling tag 'normalization' in (lua) vehicle profiles.

Bugfixes:

- We don't register profiles globally anymore, it's now possible to load multiple routerdbs in the same process.
- Fixed #157 'Route.ProjectOn timeFromStartInSeconds is always 0'.
- Fixed #153 'DirectionCalculator sometimes erroneously returns default turn direction of 'Left''.
- Fixed #141 'Add extension method to get directed edge id on routerpoint.'
- Fixed #203 'One-to-many routing returns only first path'.
- Fixed #214 'The index out of range exception has been thrown when I try to build the whole US router db'
- Fixed #209 'AddContraction Stalls'
- Fixed #238 'DynamicProfile is not thread safe'
- Fixed #253 'Exception contracting europe-latest.osm.pbf'

#### Version 1.5

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.5.0.md*

This is a minor update.

- It is now possible to control node-based restrictions in the lua profiles.
- Updated Reminiscense to 1.3.0.

#### Version 1.6 and beyond

*An idea of the next priorities, this is subject to changes!*

- [ ] Implement a proper @dev-feature-isochrones algorithm.
- [ ] Figure out @dev-unity-support.
- [ ] Implement support for @dev-speed-areas.

### Itinero 2

STATUS: **Planned**  
ETA: **01-07-2020**  

This will be the first update of Itinero with breaking changes. The work is ongoing here:

https://github.com/openplannerteam/itinero-tiled-routing  

The goal is to use lessons learned from building Itinero 1 and use this towards a simpler Itinero 2. Basically we want to be on-par feature-wise with Itinero 1 when we release Itinero 2, you should be able to port any project using Itinero 1 to Itinero 2.

**What we plan to support starting 2.0:**
- Routeable tiles: We support loading data on-the-fly and consuming routeable tiles. This enables projects to use Itinero without the need to worry about routing data.
- Contraction: Support contraction. We are still looking at options to support this best but we definetely want to be on-par feature-wise with Itinero 1. This means supporting:
  - Planet-wide contraction.
  - Restrictions support.
  - Edge-based directed routing.
  - Once contracted it won't be possible to add extra data to the network. 
- Better profiles: We want to simplify the lua profiles. There is too much legacy in the profiles. We also want to:
  - Seperate loading data from the supported profiles. It should be possible to create a routerdb without defining profiles and add them afterwards.
  - Support different weights going forward or backwards on the same edge.
- Itinero 1 features:
  - Elevation support: support adding elevation data to the routerdb.
  - Island detection: support island detection to make sure routes are always found.

**What we won't be implementing just yet but we keep in mind designing the API:**
- Elevation-aware routing: Support profiles that take into account elevation.
- Support for turning-costs: We want to support scenarios where it is important to add costs to turns. Turning right can be cheaper compared to turning left in right-hand driving countries.
- Support for vertex-weights: We want to support extra costs on vertices, for example a cost associated with traffic lights or toll-booths.

**Updating depending projects:**
Check this section of you use Itinero but also one it's depending projects. How will we be handling updates to depending projects like OpenLR, IDP and the routing-api:

- OpenLR: We will start updating this only after the release of 2.0.
- Itinero.IO.OpenLR: We will start updating this only after the release of 2.0.
- vector-tiles: If you use Itinero 1 to generate vector-tiles, it's not sure yet we will be updating the vector-tiles module.
- optimization: The optimization module will also be update after the 2.0 release but we will probably has a prerelease version reading at the time of the 2.0 release.
- IDP: Same time as 2.0 release.
- routing-api: Same time as 2.0 release.

## Itinero.IO.Osm.Tiles

This package enables Itinero 1.X to use [routeable tiles](https://github.com/openplannerteam/routable-tiles).

### Version 1

*this is currently unreleased*  
STATUS: **Planned**  
ETA: **31-10-2019**  

The package is already largely functional but some crucial options are missing:
- [ ] Use compression to consume tiles.
- [ ] Add support for restrictions.
