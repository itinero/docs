---
uid: dev-feature-customizable-ch
title: Customizable Contraction Hierarchies
---

# Customizable Contraction Hierarchies

There was an [issue open](https://github.com/itinero/routing/issues/92) from [airbreather]():

_On what looks like April 1, 2016, J. Dibbelt et al. published "Customizable Contraction Hierarchies" (DOI: [10.1145/2886843](http://doi.org/10.1145/2886843))._

_If their abstract is to be believed, this splits the preprocessing up into two steps: the first step is still the expensive workhorse, but it's done in a way that's independent of the exact edge weights; the second step "customizes" the preprocessed graph by adding in actual edge weights and can run much faster._

_A hypothetical use case for this kind of thing would be if we wanted to route around bleeding-edge dynamic data.  Consider a live feed that provides information such as "an accident at this location is causing routes using this particular edge to take an extra 2 minutes to travel along that edge"._

_- Traditionally, in order to accommodate this kind of data efficiently, I believe we'd have to do a ton of re-processing that's almost certainly impractical to do on a very regular basis unless the data set is very localized: by the time you finish the preprocessing of a graph that incorporates this information, it's easy to imagine this data already being outdated._
_- If this CCH approach lives up to its claims, one could simply re-run "customization" to incorporate the new information into future route plans at a fraction of the cost of a traditional full contraction.  As a logical extension of this, mobile clients might be able to react to these re-"customizations" and compute new routes on-the-fly while a traveler is actively traversing the route; if the optimal route changes as a result, the application could alert the user that a better route may be available and offer to switch to the new route._

_[RoutingKit](https://github.com/RoutingKit/RoutingKit) (BSD 2-clause) has a sample implementation in C++ described [here](https://github.com/RoutingKit/RoutingKit/blob/101ce16ad0509041ccf60e63bd2cadf49b5bb97f/doc/CustomizableContractionHierarchy.md)._

## Goal

Implement a prototype of Customizable Contraction Hierarchies and:

- Test if it handles the current usecases as good as the current implementation.
- Test if it can handle dynamic weight recalculations as advertised.
- Test if it can handle [blocked parts of the network](https://github.com/itinero/routing/issues/127).
- Design a new way to handle contraction in Itinero if tests succeed.

## Approach

Start in a seperate branch and strip out all current contraction code and start experimenting.

## Status

Planned