---
uid: dev-feature-multigraph
title: Multigraph
---

# Multigraph

## Goal

Implement support in the graph data structure to handle a [multigraph](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)#Multigraph). 

For some usecases this is very convenient and it can also [improve the code used to load data](https://github.com/itinero/routing/issues/110):

_Perhaps we should consider two steps in loading the network. Because duplicate edges are not allowed we prevent them by adding intermediate vertices along the edge shape, that's probably whats going wrong here. If we work in two steps we could greatly simplify this process:_

  - _Load from OSM while allowing duplicate edges._
  - _Postprocess network to remove the duplicates._

_This has only advantages:_

  - _Performance should be better because it takes some work checking for duplicates and fixing on the fly when adding edges._
  - _This will also benefit the plan to keep orginal id's if needed along with vertices._
  - _The postprocessing code can be shared between IO.Osm and IO.Shape or any other future network loader, now that code it specific for each._

We also need to:
- Implement an algorithm to convert a multigraph into a [simple graph](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)#Simple_graph) because the routing code relies on this being the case.
- Make sure to check the type of the graph before routing or contracting to prevent routing bugs.

## Approach

Unknown yet but a list could be:

- [ ] Implement support for a multigraph.
  - [ ] Enable support to add duplicate edges.
  - [ ] Enable support enumerating duplicate edge.
  - [ ] Make the edge-enumeration depend on the graph type, simple or multi.
- [ ] Implement a conversion method to remove loops and doubles to convert to simple.
- [ ] Check for graph type where needed.
  - [ ] Check before contraction.
  - [ ] Check before routing.

## Status

Unplanned
