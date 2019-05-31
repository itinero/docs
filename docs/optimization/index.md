# Itinero.Optimization

Welcome to the docs about the Itinero optization library. This documentation is focused on usage of the library and on usages of this library as a base to develop your own optimization algorithms.

## Supported problems

There is a set of _supported problems_, those implementations are considered finished. Current we have the following problems supported:

- TSP: The default travelling salesman problem.
- Directed TSP: The TSP with costs for turns.
- TSP-TW: The TSP with time window constraints.
- Directed TSP-TW: The TSP-TW with costs for turns.
- STSP: The selective travelling salesman problem, generates routes with as much locations as possible with a maxium travel time.
- DirectedSTSP: Identical to the STSP but with u-turn prevention.

# Basic Concepts

To explain how this library works and how you can use it it's imporant to know about the basic concepts use in the code:

- Strategy: A strategy or algorithm that is used as a component in a solution, like a genetic algorithm (GA) or variable neighbourhood search (VNS).
- Operator: An operation that can be applied to a potential solution either improving it or making it worse.
- Solver: A **collection of operators and strategies to solve a specific problem** (think TSP or TSP-TW, the both have their own solver).
- Model: This is an abstract **definition of the problem to solve**. It contains all data the solvers need to calculate a solution.

How these tie together:

The **solver** uses a collection of **strategies** & **operators** to solve a problem defined by its **model**.

## Basic usage

The following package is available:
- Itinero.Optimization [![NuGet](https://img.shields.io/nuget/v/Itinero.Optimization.svg?style=flat)](https://www.nuget.org/packages/Itinero.Optimization/)

When installed there are a few extension methods available on the @router class. If you don't know yet how to use Itinero we suggest reading the [Itinero docs](../itinero/index.md) first so you know how to setup a @router.

### TSP or Directed TSP

To calculate a TSP solution or a directed TSP use:
   
`router.Optimize (string profileName, Coordinate[] locations, out IEnumerable<(int location, string message)> errors, int first = 0, int? last = 0, float max = float.MaxValue, float turnPenalty = 0, Action<Result<Route>> intermediateResultsCallback = null)`

When you call this method with an array of locations and your @profile it will calculate a TSP. For the directed TSP add a turn penalty. And example for the TSP:

```csharp
// initialize a router here.
var router = ...

// define locations
var locations = new Coordinate[]
{
    new Coordinate(51.270453873703080f, 4.8008108139038080f),
    new Coordinate(51.264197451065370f, 4.8017120361328125f),
    new Coordinate(51.267446600889850f, 4.7830009460449220f),
    new Coordinate(51.260733228426076f, 4.7796106338500980f),
    new Coordinate(51.256489871317920f, 4.7884941101074220f)
};

// run the TSP calculation.
var route = router.Optimize("car", locations, out _);

// run the TSP-D calculation (with a 60 seconds turn penalty).
route = router.Optimize("car", locations, out _, turnPenalty: 60);
```

### TSP-TW

To calculate a TSP-TW (TSP with time windows) solution:
   
`router.Optimize (VehiclePool vehicles, Visit[] visits, 
            out IEnumerable<(int visit, string message)> errors, Action<IEnumerable<Result<Route>>> intermediateResultsCallback = null)`

When you call this method with an array of locations and your @profile it will calculate a TSP. For the directed TSP add a turn penalty. And example for the TSP:

```csharp
// initialize a router here.
var router = ...

// define visits (a visit is a location with meta-data)
var visits = new Visit[]
{
    new Visit()
    {
        Latitude = 51.270453873703080f,
        Longitude = 4.8008108139038080f,
        TimeWindow = new TimeWindow()
        { // time in seconds relative to the start time of the route.
            Min = 0, 
            Max = 3600
        }
    },
    new Visit()
    { // you don't need to define a time window on all visits.
        Latitude = 51.270453873703080f,
        Longitude = 4.8008108139038080f
    },
    new Visit()
    { // time in seconds relative to the start time of the route.
        Latitude = 51.270453873703080f,
        Longitude = 4.8008108139038080f,
        TimeWindow = new TimeWindow()
        {
            Min = 5400,
            Max = 6600
        }
    },
    ...
};

// create a vehicle pool with 1 vehicle.
var vehiclePool = VehiclePool.FromProfile(router.Db.GetSupportedProfile("car"));

// run the TSP-TW calculation.
var route = router.Optimize(vehiclePool, visits, out _);

// REMARK: the TSP-TW with turn penalty is not supported currently.
```

### STSP or Directed STSP

The STSP is the selective TSP, it places as many stops as possible into a route given a maximum travel time. To calculate a STSP solution or a directed STSP use:
   
`router.Optimize (string profileName, Coordinate[] locations, out IEnumerable<(int location, string message)> errors, int first = 0, int? last = 0, float max = float.MaxValue, float turnPenalty = 0, Action<Result<Route>> intermediateResultsCallback = null)`

When you call this method with an array of locations, your @profile and set max it will calculate an STSP. For the directed STSP add a turn penalty. And example:

```csharp
// initialize a router here.
var router = ...

// define locations
var locations = new Coordinate[]
{
    new Coordinate(51.270453873703080f, 4.8008108139038080f),
    new Coordinate(51.264197451065370f, 4.8017120361328125f),
    new Coordinate(51.267446600889850f, 4.7830009460449220f),
    new Coordinate(51.260733228426076f, 4.7796106338500980f),
    new Coordinate(51.256489871317920f, 4.7884941101074220f)
};

// run the TSP calculation.
var route = router.Optimize("car", locations, out _, max: 3600);

// run the STSP-D calculation (with a 60 seconds turn penalty).
route = router.Optimize("car", locations, out _, max: 3600, turnPenalty: 60);
```