# Roadmap

This is an overview of features that are either in development or on the roadmap. This roadmap is determined by a few factors:

- Priorities of our clients: This is the main factor because we're getting paid to build this stuff and this means more time and resource to get things done.
- Technical dependencies: We can't build things out of order, some features depend on others. We cant support turning costs for example without implementing edge-based routing.
- Priorities of Itinero and it's maintainers: We will don't include things in Itinero that we believe don't belong in the core library, even for clients. We also try to determine what is most valuable for as many users. 

This means you can influence this roadmap by either becoming a client, help with solving technical dependencies or communicate about what you think is missing in Itinero.

## Version 1.1

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.1.0.md*

This contains some ideas on some non-breaking extensions on top of v1.0.

- Add a weight matrix calculation algorithm that calculates edge->edge weights excluding the source-target edge weights. *DONE*
  - Check to see if the current edge-based matrix algorithm can be replaced by this more general case. *DONE*
- And several other issues and ideas: [Milestone for 1.1](https://github.com/itinero/routing/milestone/3) *DONE*

## Version 1.2

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.2.0.md*

- Fixed maxspeed normalization issue.
- Implemented support for nested relations by allowing multiple passes over relations if requested.
- Implemented support for nested cycle route relations in the default bicycle profile.
- Fixed directed weight matrix issue related to resolved points on oneway segments.

## Version 1.3

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.3.0.md*

- Meta-data on vertices: More details [here](https://github.com/itinero/routing/wiki/Development-Plan:--Meta-data-on-vertices).
- A way to extract parts of the network and save them as a new routerDb.

## Version 1.4

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

## Version 1.5

*This version has been released: https://github.com/itinero/routing/blob/master/docs/releasenotes/itinero-1.5.0.md*

This is a minor update.

- It is now possible to control node-based restrictions in the lua profiles.
- Updated Reminiscense to 1.3.0.

## Version 1.6 and beyond

*An idea of the next priorities, this is subject to changes!*

- [ ] Implement a proper @dev-feature-isochrones algorithm.
- [ ] Figure out @dev-unity-support.
- [ ] Implement support for @dev-speed-areas.

## Version 2.0 and beyond

These are issues/features that require breaking changes:

- Fixed the directed id issue: https://github.com/itinero/routing/issues/95
- Logging: use something like LibLog in v2.0:
  - http://forums.dotnetfoundation.org/t/logging-best-practices/2758
  - https://github.com/damianh/LibLog
- Figure out how to improve island detection, also including restrictions.
  - Also included edge-based routing and U-turn prevention: http://geojson.io/#id=gist:anonymous/89cf914f12693460bcb117599dc7593f&map=19/50.15657/6.05205
  - Goal is to get, once resolved 100% success rate from routing.
  - The only way to do this, to get a final solution, is to invalidate edges, in a given direction.
- Fix issue with float's not being good enough: https://github.com/itinero/routing/issues/120
- Move to netstandard2.0 *only*.
- Use the meta-data on vertices to paste networks back together by keeping node id's.
- [PLANNED](https://github.com/itinero/routing/tree/features/constraints): Constrained routing: Routing with constraints like weight limits or vehicle size (width and height).
- [PLANNED] Destination-only access: Handle access constraints where there is destination only access, also when using contracted graphs.
- Better CH: 
  - https://github.com/itinero/routing/issues/92
  - Check development plan here: @dev-feature-customizable-ch
- Reevaluate Lua profiles: https://github.com/itinero/routing/issues/102
- Figure out a way to better detect islands and route under all conditions: https://github.com/itinero/routing/issues/104
- Support for dynamic weights per edge, for example to handle floating car data: https://github.com/itinero/routing/issues/103
- Look at the filesize of the routerDb's: https://github.com/itinero/routing/issues/105
- Elevation-aware routing: Routing that takes into account elevation. Think avoiding steep hills for bicycles.
- No-go areas or maximum speeds based on areas: https://github.com/itinero/routing/issues/19
- Alternative routes.
- Map matching.
- Reevaluate lua for instruction generation of fix performance issues.
- Remove nullable booleans to describe directional information.
- Remove this fix: https://github.com/itinero/routing/issues/108
- cleanup weight handlers, let them die!
- cleanup old way of handling restrictions.
- cleanup using bool? for directions and replace by Dir structure.
- cleanup old way of doing edge-based routing.
- Consider implementing support for multi-level route relations: https://github.com/itinero/routing/wiki/Development-plan:-Handle-multi-level-route-relations.#process-relations-in-multiple-passes
- Move OSM specific parsing to the OSM namespace: IAttributeCollectionExtension
- Refactor the island detector to only accept a single profile.
- Consider implementing support for time-dependent restrictions: https://www.openstreetmap.org/relation/87146
- Fix the public API on the weight matrix algorithms, it's a mess and unclear what is meant with the supplied methods.
   - Talking about `CorrectedIndexOf` and `OriginalIndexOf` specifically.
- Implement a way for profiles to define a different factor/speed for each direction per edge.
  Sometimes factors differ depending on direction. Think about elevation but also https://github.com/oSoc18/bike4brussels-backend/issues/7
- Implement a way for profiles to use information on vertices for routing.
   - This is related to turning costs: https://github.com/oSoc18/bike4brussels-backend/issues/5
   - This is also related to avoiding traffic lights for example: https://github.com/oSoc18/bike4brussels-backend/issues/6
- Figure out a way or continue on with a way of implementing true memory mapping: https://github.com/itinero/routing/issues/206

## General ideas

A collection of general ideas that may or may not end up on the final roadmap.

https://github.com/AArnott/PdbGit/blob/master/README.md

- Add a more efficient data structure to represent restrictions
- [x] Add extension method to turn a routerpoint into GeoJSON

Just return geojson with all details included:

- Edge with start and end vertex.
- The location on the network.
- The original location.

Use arraypool for dykstra calculations to keep pathtree and other data:
- http://adamsitnik.com/Array-Pool/
