---
title: A cacheable edge-based weight matrix algorithm.
---

# A cacheable edge-based weight matrix algorithm.

## Goal

The many-to-many calculations don't take into account duplicate locations on edges while still calculating on an edge-to-edge bases. This leads to double work, we want to get rid of these duplicated calculations.

Another goal is the option to cache weights between edges preventing the need to calculate them again.

We will not enable this by default but provide an extension method to use. This may become the default method at a later stage.

## Approach

We adapt the current edge-based contracted algorithm to:

- Build a unique list of edges.
- Check the cache.
  - IF all are cached, THEN result is available.
  - ELSE calculate non-cached and callback with results to cache.
- Convert the edge-to-edge matrix back to the original routerpoints.

## Status

Planned