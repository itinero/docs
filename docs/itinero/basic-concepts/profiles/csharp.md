---
uid: csharp-profile
title: C# Profile
---

# C# Profile

Defining a C# based profile works pretty much the same as the @lua-profile alternative but it has the disadvantage of not being embeddable in the @routerdb.

## Factor and Speed

Define a vehicle can be done by implementing the @Itinero.Profiles.Vehicle class and overriding the one method FactorAndSpeed:

```csharp
/// <summary>
/// Calculates a factor and speed and adds keys to the given whitelist that are relevant.
/// </summary>
/// <returns>A non-zero factor and speed when the edge with the given attributes is usefull for this vehicle.</returns>
FactorAndSpeed FactorAndSpeed(IAttributeCollection attributes, Whitelist whitelist);
```

The @Itinero.Profiles.FactorAndSpeed struct defines:

- Speed: The speed in m/s over the edge with the given attributes.
- Factor: The factor, in the default case 1/Speed.
- Direction: 
  - 0: Bidirectional.
  - 1: Oneway in the direction of the edge.
  - 2: Oneway agains the direction of the edge.

When Factor > 0 the edge is considered routable.