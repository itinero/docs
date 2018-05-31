---
uid: dev-feature-map-matching
title: Map Matching
---

# Map Matching

## Goal

Implement a [map matching algorithm](https://en.wikipedia.org/wiki/Map_matching) based on Itinero.

## Approach

Use the same algorithm as [here](https://github.com/graphhopper/map-matching), they implement [this](https://www.researchgate.net/publication/221589790_Hidden_Markov_map_matching_through_noise_and_sparseness).

The basic steps we need to complete.

- Cleanup source data. This means removing data is probably due to noise instead of actual movement.
- Implement or use the current implementation of multiple-resolve. Search for the n-closest points and do it fast.
- Calculate travel distances/times between these points.
- Calculate probabilities on state changes.
- Calculate best sequence and drop unmatchable segments in the process.

## Status

Draft
