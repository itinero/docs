---
uid: router
title: Router
---

# Router

The router class is where all the magic happens. Once you have a @routerdb setup, you can create a router. The router class functions as a façade for most if not all routing requests.

An overview of available features:

- Resolving: _Snapping_ locations to the network.
- Routing: Calculating one, multiple routes or a matrix of routes.
- Weight Matrices: Calculating weight matrices between a collection of locations.
- Connectivity checks: Check if a @routerpoint is connected to the rest of the network.

The router is setup with the following priorities in mind:

- Correctness: A route has to be correct as requested.
- Performance: Performance is the next primary choice.

#### Result object

Each method has two counterparts, one that returns the result in a @Itinero.Result`1 object and one that doesn't:

- Calculate: As expected just returns the route or routes that have been calculated. 
- TryCalculate: Also returns the route or routes that have been calculated but in a @Itinero.Result`1 object. When, for whatever reason, calculation fails, route is not found or resolving fails, the result object just contains the error message.

We do this because exceptions are bad for performance, if you are in a high-performance environment, consider using the TryCalculation methods and checking the result object.

### Resolving

One of the most important functions of the router is the option to _resolve_ points. Read more about this in the @routerpoint section.

`RouterPoint Resolve(Profile profile, float latitude, float longitude)`

- _profile_: The @profile, defines the vehicle to resolve for.
- _latitude_,_longitude_: Defines the location to resolve.

There are several more overloads and functions to resolve multiple locations at the same time. Check the API documentation for the @Itinero.Router object and the extension methods in @Itinero.RouterBaseExtensions.

### Routing

The most basic function of the router is to calculate routes:

`Route Calculate(Profile profile, float sourceLatitude, float sourceLongitude, float targetLatitude, float targetLongitude)`

- _profile_: The @profile, defines the vehicle's behavour to calculate a route for.
- _latitude_,_longitude_: Defines the source and target location of this route.

There are several more overloads, to calculate multiple routes at the same time or to calculate matrices of routes. Check the API documentation for the @Itinero.Router object and the extension methods in @Itinero.RouterBaseExtensions.

### Weight Matrices

The most basic function of the router is to calculate routes:

`float[][] CalculateWeight(IProfileInstance profile, RouterPoint[] locations, ISet<int> invalids)`

- _profile_: The @profile, defines the vehicle's behavour to calculate a route for.
- _locations_: The locations to calculate the matrix for.
- _invalids_: The set of invalid locations, some may not be routable.

There are several more overloads. Check the API documentation for the @Itinero.Router object and the extension methods in @Itinero.RouterBaseExtensions.

### Check Connectivity

Checks connectivity of the given router point:

`bool CheckConnectivity(IProfileInstance profile, RouterPoint point, float radiusInMeters)`

- _profile_: The @profile, defines the vehicle's behavour to calculate a route for.
- _point_: The point to check for.
- _radiusInMeters_: The radius in meter to check.

There are several more overloads. Check the API documentation for the @Itinero.Router object and the extension methods in @Itinero.RouterBaseExtensions.

## What to read next?

If you followed the _what to read next_ sections you pretty much covered all the most important concepts. Interesting could be the information about the @route concept.