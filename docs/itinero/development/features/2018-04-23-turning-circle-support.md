---
uid: dev-turning-circle-support
title: Turning Circle
---

# Turning Circle

## Goal

By default Itinero blocks u-turns, an obvious requirement for any routing engine. 

An exception to this rule exists in the case of dead-end streets, or when there is no alternative. Or when there is a turning circle:

https://wiki.openstreetmap.org/wiki/Tag:highway%3Dturning_circle

In OSM for example turning circles are mapped as a node, usually like this:

https://www.openstreetmap.org/node/4676704559#map=19/51.23768/4.82439

The goal is to support these turning circles.

## Approach

TBD

Suggestion: Expand the graph by actually adding a circle, probably the simplest but sub-optimal solution.

## Status

Planned
