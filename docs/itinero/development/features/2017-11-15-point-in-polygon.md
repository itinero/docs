---
uid: dev-feature-point-in-polygon
title: Point in polygon
---

# Isochrones

## Goal

Implement a point in polygon algorithm. Itinero can't depend on another Geo/GIS library just for a few core algorithms so the only other option is to implement some basics ourselves.

## Approach

Implement or port on the existing C# implementations. Some inspiration:

- https://en.wikipedia.org/wiki/Point_in_polygon
- https://github.com/NetTopologySuite/NetTopologySuite/blob/develop/NetTopologySuite/Geometries/Geometry.cs#L884

## Status

Draft