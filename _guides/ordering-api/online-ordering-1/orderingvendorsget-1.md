---
title: "Get List of Vendors"
permalink: /docs/orderingvendorsget-1
excerpt: "Returns complete list of vendors provided in the given credentials. Access to vendors is granted after successful request to */auth/ordering* endpoint based on *X-API-Key*).\n<br />List can be filtered by optional query parameters:\n * seat ID - internal seat identifier assigned to vendors. Useful when vendor list must be narrowed down and displayed for the specific seat only (please see */venues/{venue_id}/levels/{level_id}/seats* endpoint for complete list of seat IDs)\n * venue ID - internal venue identifier associated with vendors. Since the complete list contains all venues/vendors provided in the credentials this filter could be used when vendor list must be retrieved for specific venue only\n * external ID - external identifier assigned to vendors"
layout: default
published: false
createdAt: "2023-01-20T21:20:22.348Z"
updatedAt: "2023-07-11T19:33:04.448Z"
---
\*Background:\*\*

This is a happy path flow for retrieving a list of vendors that are available for mobile ordering

> 🚧 Please Note
> 
> The Ordering API Vendors endpoint only shows Vendors that have been enabled for Mobile Ordering in Connect. This is by design. For a complete list of Vendors please reference the Vendors endpoint in the Catalogue collection. 

Link to the Order API Reference [Ordering API]({{site.baseurl}}/reference/orders)

This assumes you have already pulled the item information from the Menu Endpoint in OAPI or through Items API.

> 📘 Information Needed to Retrieve the list of Vendors
> 
> - Valid API Key
> - Valid JWT Token
> - Vendor ID that the Venue belongs toExample

> 👍 Key information Returned
> 
> - General Vendor Information such as (but not limited to):  
>   Name  
>   Alchohol Information  
>   Hours of Operation  
>   Fees  
>   Tipping  
>   Venue assigned to  
>   Payment types
>   A full schema is available in the ordering API reference.
