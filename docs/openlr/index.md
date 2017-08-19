---
uid: openlr
title: OpenLR
---

# OpenLR

OpenLR is a tool to encode/decode location references based on the OpenLR-specification:

[http://www.openlr.be/](http://www.openlr.be/)

## Use Cases

OpenLR is used to communicate information about locations a routing network between devices and between different routing networks. It's possible to encode information linked to a part of a network in a network-agnostic way, allowing information to be stored independently of the actual edge or link id's of the network. This information can be decoding using another routing network for the same location.

Information that can be encoded/decoded:

- Traffic information linked to segments on the network.
- Traffic information linked to a point on the network.
- Statistics and history of a link between networks.
- ...

## Project structure

There are two core projects:

- OpenLR: Contains all location types and enumerations from the OpenLR-specification and encoding/decoding base functionality.
- OpenLR.Geo: Contains extension methods to convert locations to Features and Geometries.

Test project:

- OpenLR.Tests: The unitttests.
- OpenLR.Tests.Functional: Functional testing and regression testing of actual real-life encoding/decoding scenario's.

## Usage

There are two main steps in using this library. First you need to create a routable network in the form of an Itinero @routerdb. You can find more info about this [here](../itinero/data-sources/index.md). After that load the RouterDb and create an encoder/decoder using this data.

You can check the samples to learn more about how this works in code:

- [Samples.OSM](https://github.com/itinero/OpenLR/tree/develop/samples/Samples.OSM): Shows how to encode/decode on top of OSM.
- [Samples.NWB](https://github.com/itinero/OpenLR/tree/develop/samples/Samples.NWB): Shows how to encode/decode on top of networks in shapefile format, more info about this can also be found in the Itinero docs.

## Help or support?

Need help or support you can get in toch with us via the issue tracker, just post whatever issue you have. We can also offer support, feel free to contact use via the contact form on [itinero.tech](http://www.itinero.tech/#contact).