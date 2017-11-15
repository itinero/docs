---
title: A boundingbox on all routerdb's
---

# Goal

It's very usefull to know what area a routerdb was generated for. We need to make sure any routerdb contains it's bounds or they can be easily generated.

# Approach

We add the bounds as meta-data to the routerdb using the name 'bounds' as GeoJSON and we try to make sure they are generated before serialization in all relevant tools.

- [ ] Generate or accept a custom polygon in IDP.
- [ ] Add the option to generate a polygon based on the data.
- [ ] Add a method to get/set the bounds.
- [ ] Add the bounds when extracting a routerdb from another routerdb.

For this we need some extra's to implement first:

- [ ] A GeoJSON generation for Polygons.
- [ ] A polygon generation method for a routerdb.

# Status

Unplanned