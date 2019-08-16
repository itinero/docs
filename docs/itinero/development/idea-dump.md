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

### General ideas

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
