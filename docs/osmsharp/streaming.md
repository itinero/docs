---
uid: streaming-model
title: Streaming Model
---

# Streaming Model

OsmSharp uses a streaming model to handle OSM-data. The OSM-database is growing every day and an architecture that can handle larges amounts of data is no luxury. 

<img src="http://www.osmsharp.com/static/osmsharp-streaming-model.png"/>

The basic types that are used in the streaming model are:

- **OsmStreamSource**: Abstract representation of a source of an OSM data stream. There are several implementations available, the most important ones being:
  - **XmlOsmStreamSource**: Reads OSM-XML files.
  - **PBFOsmStreamSource**: Reads OSM-PBF files.
- **OsmStreamFilter**: Abstract representation of a filter, also a source, that can be used to filter a stream. Implementations are **OsmStreamFilterBoundingBox** and **OsmStreamFilterTags**.
- **OsmStreamTarget**: Abstract representation of a target for an OSM data stream. There are several implementations available, the most important ones being:
  - **XmlOsmStreamTarget**: Writes OSM-XML files.
  - **PBFOsmStreamTarget**: Writes OSM-PBF files.

All sources and filters are also IEnumerable<T> meaning you can use Linq to work with the streams:

```csharp
using (var fileStream = File.OpenRead("path/to/file.osm.pbf"))
{
  // create source stream.
  var source = new PBFOsmStreamSource(fileStream);
  
  // filter all powerlines and keep all nodes.
  var filtered = from osmGeo in source
   where osmGeo.Type == OsmSharp.OsmGeoType.Node || 
    (osmGeo.Type == OsmSharp.OsmGeoType.Way && osmGeo.Tags != null && osmGeo.Tags.Contains("power", "line"))
   select osmGeo;

  // convert to complete stream.
 // WARNING: nodes that are partof powerlines will be kept in-memory.
  //          it's important to filter only the objects you need **before** 
  //          you convert to a complete stream otherwise all objects will 
  //          be kept in-memory.
  var complete = filtered.ToComplete();
}

