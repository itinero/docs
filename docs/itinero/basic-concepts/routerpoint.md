---
uid: routerpoint
title: RouterPoint
---

# RouterPoint

A router point is a location on the network. Usually a router point is the result of _snapping_ a location to the closest edge.

<p>
<img src="../../images/routerpoint.png" style="max-height: 400px"><br/>
_Image 1: A visualisation of the routerpoint concept._
</p>

## Resolving

In Itinero, **the process of _snapping_ a location to the closest edge** is called **resolving** that location. You can resolve a location using the @router:

```csharp
// snaps the given location to the nearest routable edge.
var routerPoint = router.Resolve(profile, 51.26797020271655f, 4.801905155181885f);
```

Usually a routerpoint is resolved with a given @profile in mind, making sure the routerpoint is accessible and not snapping to another closer edge, think about a cylepath next to a road.

## Why?

We introduced this concept to give applications using Itinero full control over this part of the routing process. There are two main motivations for this:

#### Performance

The routing algorithm can be so fast that the resolving process takes up a signficant part of the time when calculating a route. Routerpoints make it possible to cache the result, use a faster but less accurate resolving algorithm in one application, a slower but better one in another.

#### Advanced usecases

It's often not obvious where to start a route, just given the lat/lon. Just taking the closest street is sometimes not good enough, perhaps the snapping of a location to the network can depend on the streetname.

## What to read next?

Learn more about the @router concept.