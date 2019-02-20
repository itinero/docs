---
uid: dev-speed-areas
title: Speed Limit Areas
---

# Speed Limit Areas

## Goal

Support adding extra data to a routerdb based on areas (polygon) and updating the edge profiles and meta data. This would lead to support for areas that have a predefined speed limit for example or newer trends like low-emission zones.

## Approach

- [DONE] Make a routerdb editable after it has been written. Currently the edge meta data and edge profiles can be edited after serialization. This is related to [this issue](https://github.com/itinero/reminiscence/issues/12) and [this one](https://github.com/itinero/routing/issues/146).
- Implement an easy to use API allowing the areas to be processed.

## Status

Ongoing

- Support is there but this needs to be exposed with an easy-to-use API.
