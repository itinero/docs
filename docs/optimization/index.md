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

## Basic usage

The following package is available:
- Itinero.Optimization [![NuGet](https://img.shields.io/nuget/v/Itinero.Optimization.svg?style=flat)](https://www.nuget.org/packages/Itinero.Optimization/)

When installed the following extension methods are available on the @router class. For each method there is a Try alternative that doesn't raise any exceptions when something goes wrong but gracefully reports on the error(s):

- CalculateTSP (profile, locations, first, last): Calculates a default TSP.
  - profile: The vehicle profile.
  - locations: The locations.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.
- CalculateTSPDirected (profile, locations, turnPenaltyInSeconds, first, last): Calculates a default TSP with u-turn costs.
  - profile: The vehicle profile.
  - locations: The locations.
  - turnPenaltyInSeconds: Turn penalty in seconds.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.
- CalculateTSPTW (profile, locations, windows, first, last): Calculates a TSP with time windows.
  - profile: The vehicle profile.
  - locations: The locations.
  - windows: The time window constraints.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.
- CalculateTSPTWDirected  (profile, locations, windows, turnPenaltyInSeconds, first, last)
  - profile: The vehicle profile.
  - locations: The locations.
  - windows: The time window constraints.
  - turnPenaltyInSeconds: Turn penalty in seconds.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.
- CalculateSTSP (profile, locations, max, first, last): Calculate a STPS solution.
  - profile: The vehicle profile.
  - locations: The locations.
  - max: The maximum travel time of a tour.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.
- CalculateSTSPDirected (profile, locations, turnPenaltyInSeconds, max, first, last): Calculate a directed STPS solution.
  - profile: The vehicle profile.
  - locations: The locations.
  - turnPenaltyInSeconds: Turn penalty in seconds.
  - max: The maximum travel time of a tour.
  - first: The location to start at.
  - last (option): The location to end up at, when last=first the route will be a loop.