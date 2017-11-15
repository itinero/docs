---
uid: dev-feature-isochrones
title: Isochrones
---

# Isochrones

## Goal

Implement a proper isochrone builder.

## Approach

We adapt the current [implementation](https://github.com/itinero/routing/tree/develop/src/Itinero/Algorithms/Networks/Analytics/Isochrones) with a proper polygon building algorithm like [CONREC](http://paulbourke.net/papers/conrec/).

The main TODO's are:
- [ ] Implement [CONREC](http://paulbourke.net/papers/conrec/) or use/port one of the existing implementations when open-source.
  - Produce a LocalGeo.Polygon object from a set of points.
- [ ] Find a way to adjust the current implementation without breaking it.

## Status

Unplanned