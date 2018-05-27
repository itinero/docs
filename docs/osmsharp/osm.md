---
uid: openstreetmap-data-model
title: OpenStreetMap Data Model
---

# OpenStreetMap Data Model

There are three basic objects in the OpenStreetMap data model: Nodes, Ways and Relations. 

<img src="http://www.osmsharp.com/static/osm-data-model.png"/>

* Node: A simple object that has key-value tags and a latitude/longitude pair. Represents any point information like POI's. 
* Way: A sorted sequence of nodes and a collection of key-value tags. With the geographical information in the nodes and the key-value tags a way can represents rivers, roads, houses, ...
* Relation: Relations can model any relationship between nodes, ways and relations. This is used to represent more complex objects like polygons with holds, administrative boundaries and busroutes.

For more information check the [OSM-wiki](http://wiki.openstreetmap.org/wiki/Elements).