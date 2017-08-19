Itinero Documentation
=====================

Published here => http://docs.itinero.tech/

# Structure

The mains structure of these docs are as follows:

- Documentation section: The manually writting docs.
  - Introduction: Introduction into the structure of the docs.
  - Itinero: The main starting point for the Itinero routing core docs.
    - Basic Concepts: Explains shortly all the basic concepts.
      - Profiles: Explains vehicle profiles.
      - RouterDb: Explains the routerdb.
      - Router: Explains the router class.
      - Route: Explains the route class.
    - Data sources:
      - OpenStreetMap (OSM): Explains how to load OSM data.
      - Shapfiles: Explains how to load shapefiles.
    - Tutorials:
      - Routing server: Explains how to use Itinero when building a routing services.
      - Mobile app: Explains how to use Itinero to do offline routing in a mobile app.
   - OpenLR: The main starting point for the OpenLR docs.
     - Basic Concepts: Explains shortly all the basic concepts.
       - Coder: Explains the coder class.
       - RouterDb: Explains the Itinero RouterDb in the contexts of OpenLR.
       - Locations: Explains the concept of locations.
     - Tutorials:
       - Encoding/decoding on OSM: A full tutorial on how to setup encoding/decoding on OSM.
       - Encoding routes: A tutorial on how to create an application encoding entire routes.
   - GTFS: The main starting point of the GTFS docs and a short overview of what the library does.
- Itinero API: Automatically generated API docs from the .NET XML comments.
- GTFS API: Automatically generated API docs from the .NET XML comments.
- OpenLR API: Automatically generated API docs from the .NET XML comments.