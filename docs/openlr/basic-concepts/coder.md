---
uid: openlr-coder
title: Coder
---

# Coder

The coder class is where all the magic happens. Once you have a @routerdb setup and a @openlr-coder-profile, you can create a coder. The code class functions as a façade for all encoding/decoding.

To encode the a location 

`string Encode(ReferencedLocation location)`

### Encoding

One of the most important functions of the router is the option to _resolve_ points. Read more about this in the @routerpoint section.

`RouterPoint Resolve(Profile profile, float latitude, float longitude)`

## Encoding

