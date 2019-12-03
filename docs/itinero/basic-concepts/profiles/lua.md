---
uid: lua-profile
title: Lua Profiles
---
# Lua

The default way to define a vehicle profile is by using [Lua](https://en.wikipedia.org/wiki/Lua_(programming_language)). You can control pretty much everything about a vehicle.

## An example

A vehicle can be defined by one lua script. This vehicle definition gets embedded in a @routerdb when created. This is the minimum code needed to define a profile:

```lua

-- every vehicle type has a name:
name = "car"

-- Enable extra optimizations; stronlgy urged to set to 'true'. No functional impact towards route planning
normalize = true

-- Turn restrictions applying to these vehicles will be applied:
vehicle_types = {"vehicle", "car"}

-- which tags can be used by the profile to calculate weights - see explanation below
profile_whitelist = {
	"highway"
}

-- which tags are kept in the output profile - see explanation below
meta_whitelist = {
	"name"
}


--[[ 
Profiles is used by itinero to know what behaviours of the vehicle are known; in this case these are 'car', 'car.shortest' and 'car.specificProfile'.

Each profile has the following attributes:

- name: the name of the subprofile
- function_name: a function that calculates the behaviour of this profile, for each segment:
    - the speed for this segment in km/h that segment
    - the factor (per meter) for that segment
- metric: what is the metric that we will optimize for. Can be one of the following:
    - distance: only keep distance into account, neither speed nor factor will be used. Think speed=1 and factor=1
    - time: for every segment, the factor used is 1/speed (aka: time needed for this segment); the routeplanner will optimize for that
    - custom: the weight (per meter) for each segment will be used. This custom factor will be minimized


--]]
profiles = {
	{
		name = "",
		function_name = "factor_and_speed",
		metric = "time"
	},
	{ 
		name = "shortest",
		function_name = "factor_and_speed",
		metric = "distance",
	},
	{
        name = "specificProfile",
        function_name = "some_factor_and_speed",
        metric = "custom"
    }
}

--[[

A "factor and speed function" converts a set of attributes into a speed and/or factor.
The input 'attributes' are the tags of the segment, as saved in OSM.
The input 'result' is pointer to a table where some values have to be specified by the end of the procedure call - see in this procedure for docs


Usually the default _factor_and_speed_ will define a speed for each possible set of profile attributes. Based on this Itinero can define a _fastest_ and a _shortest_ profile with metrics being _time_ and _distance_ respectively.

A _custom_ profile uses a _factor_ to define weights of edges. This way, the factor can be used to guess a feeling of comfort, safety, preferences for certain roads, ...

- With metric _distance_: Itinero will use the function to get the speed and set factor to a constant, usually 1.
- With metric _time_: Itinero will use the function to get the speed and set factor to 1/speed.
- With metric _custom_: Itinero will use the function to get the speed and the factor.

NOTE: the name of this function can be chosen, it only has to match the name given above.

]]--
function factor_and_speed (attributes, result)

    --[[ 
    Can this edge be accessed?
    0: no
    1: yes
    ]]--
    result.access = 0


    --[[ 
    Do we have to drive in a certain direction?
    0: twoway
    1: oneway with the drawing direction of the highway
    -1: oneway against the drawing direction of the highway
    ]]
    result.direction = 0

    --[[
    Can a vehicle stop halfway the edge?
    (e.g. can we drop of a package in the middle of the motorway or do we have to drive around to the nearby residential?)
    ]]
	result.canstop = true

    --[[
    On average, how fast would we be driving here (in km/h)?
    This is used exclusively if 'time' is the used metric
    Note: this should never exceed the legal max speed
    ]]
    result.speed = 0

    --[[
    What is the weight (per kilometer) of this edge?
    This is used exclusively if 'custom' is the used metric and will be minimized.
    Note that setting `result.factor = 1 / speed` is equivalent to using the `time`-metric
    ]]
    result.factor = 0

    --[[
    Which attributes (aka. key/value-pairs aka. tags)  of this highway did we use to determine speed and factor ?
    ]]
	result.attributes_to_keep = {}
	
	
     -- An example is:
	 local highway = attributes.highway
	 if highway == "motorway" or 
	    highway == "motorway_link" then
		result.speed = 100 -- speed in km/h
		result.direction = 0
		result.canstop = true
		result.attributes_to_keep.highway = highway
	end
end
```

The main _factor_and_speed_ is function is the most important active part of the vehicle definition but these variables/functions need to be defined in any vehicle definition:

- _name_: The name of the vehicle, should be unique for all loaded profiles.
- _profile_whitelist_: A list of all attributes that will be added to an edge as part of the profile.
- _meta_whitelist_: A list of all attributes will be added to an edge as meta data.
- _profiles_: Defines the profiles for this vehicle, by default at minimum _fastest_ (with no name) and _shortest_ have to be defined.
- _factor_and_speed_: The core of the vehicle definition, converts edge attributes into a factor and speed.


#### The profile and meta whitelists

_summary_:
    - Tags of which the key is in `profile_whitelist` are used to determine speed and factor and visible in the called procedure. They must be copied if the tag is used to determine a factor.
    - Tags of which the key is in `meta_whitelist` are copied from OSM and only visible in the constructed route.
    - There are a few subtle pitfalls, read them below.

When building a route planner, the routeplanner cares about certain information at certain times. The first phase consists of knowing how much time every street takes, the second phase is to find a sequence of streets so that the resulting sequence has a minimal time. At last, this sequence has to be translated into a useable format which has extra information such as streetnames.

Ofcourse, the streetname has no effect on the speed or comfort of a street. In other words, it is only necessary to load the streetnames during the last phase, the translation.

To support this, two lists are defined: `profile_whitelist` and `meta_whitelist`.

The *profile_whitelist* contains the keys that can be used during the weight calculation. Typical examples are `highway` (in order to read the road classification), `access` (to know if a vehicle is allowed on the path), `maxspeed`, `surface` (to calculate comfort or even incorportate that a bad surface will go slower).

The function called by the profile (in the example `factor_and_speed`) gets a table called `attributes`. This table only contains tags where the key is within `profile_whitelist`.

Note that, whenever an attribute is used to determine speed and/or factor, the value must ALWAYS be added to `result.attributes_to_keep`. Itinero uses further optimizations based on the attribute table. Using a tag and not adding it will result in bugs.


The *meta_whitelist* contains values that are needed only in the output route. The prime example here is `name` and `ref`, the streetname of the road. Other examples are `bridge` and `tunnel` - they do not have an impact on speed or comfort, but they can be important clues for navigation. Another example is `colour` can contain colour of (cycle)networks, which might be needed as well.

Having a value in the `meta_whitelist` means that the OSM tag is immediatly copied to the output.

### Handling relations

If you need information from relations to do route planning (e.g. prefer cycling networks), add a function called `relation_tag_processor`.
Important: the keys mentioned in `attributes_to_keep` have to be in the `profile_whitelist`, the keys needed by this function must be in `meta_whitelist`.

```Lua

-- Processes the relation. All tags which are added to result.attributes_to_keep will be copied to 'attributes' of each individual way
function relation_tag_processor (attributes, result)
	result.attributes_to_keep = {}
	if attributes.network == "lcn" then
		result.attributes_to_keep.lcn = "yes"
	end
	
	if attributes.colour ~= nil and 
	    (result.attributes_to_keep.brussels == "yes" or result.attributes_to_keep.genk == "yes")
	        then
		result.attributes_to_keep.cyclecolour = attributes.colour
	end
end
```

### Logging and debugging

In case of debugging, the following code can be used to debug a table (e.g. attributes):


    for k, v in pairs( attributes ) do
      itinero.log(tostring(k) .. "-->" .. tostring(v))
    end
    itinero.log("\n------------------\n")

This kills performance, don't use in production

## Default profiles

There are some [vehicle definitions](https://github.com/itinero/routing/blob/develop/src/Itinero/Osm/) included in Itinero by default assuming OSM data is used. A few examples here:

- The [car](https://github.com/itinero/routing/blob/develop/src/Itinero/Osm/Vehicles/car.lua) vehicle: Defines a default _factor_and_speed_ function but also a custom function to define a car profile called **classifications** to prefer higher classified roads even more than the regular profile.  
- The [bicycle](https://github.com/itinero/routing/blob/develop/src/Itinero/Osm/Vehicles/bicycle.lua) vehicle: Also definas a default _factor_and_speed_ function but in addition it defines two more:
  - **balanced**: Aggressively chooses bicycle-only parts of the network.
  - **networks**: Aggressifely chooses bicycle routing networks.

## Build a routerdb with embedded vehicles

By default all vehicles that are used to build a routerdb are embedded into it. When you have your own custom lua profile you can build a routerdb as follows:

```csharp
var vehicle = DynamicVehicle.LoadFromStream(File.OpenRead("path/to/custom.lua"));
var routerDb = new RouterDb();
// load the raw osm data.
using (var stream = new FileInfo(@"/path/to/some/osmfile.osm.pbf").OpenRead())
{
    routerDb.LoadOsmData(stream, vehicle);
}
// write the routerdb to disk.
using (var stream = new FileInfo(@"/path/to/some/osmfile.routerdb").OpenWrite())
{
    routerDb.Serialize(stream);
}
```

Now the vehicles are embedded in the routerdb, you can get them by their name, in this case assumed to be _custom_:

```csharp
var routerDb = RouterDb.Deserialize(File.OpenRead(@"/path/to/some/osmfile.routerdb"));
var vehicle = routerDb.GetSupportedVehicle("custom");
var router = new Router(routerDb);

var route = router.Calculate(vehicle.Fastest(), ...);
```

