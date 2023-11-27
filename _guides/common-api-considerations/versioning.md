---
title: "Versioning"
parent: Common API Considerations
nav_order: 1
permalink: /docs/versioning
layout: default
createdAt: "2022-09-28T16:42:33.880Z"
updatedAt: "2023-04-04T20:10:51.874Z"
---
Now that you have validate access to the APIs and have your first store setup (yay!), the very next thing to do is to determine what version of the APIs you are using.

If you are a first-time user, you should always be using the most recent version - this way you can ensure you are current with our features and are operating under ideal circumstances. If you are an existing customer, however, you may opt to stay with the version you originally started with for consistency and to avoid rework. Either way, make sure to note what version of the API you are viewing when in the reference guide section, as there can be large differences between major versions.

### API Versioning Strategy

All our APIs use the "Content-Type" header to determine what version of that endpoint the API will respect. For example when sending a cart-calculate request, the value for V1 is "application/com.appetize.oapi.cart.v1+json" while the value for V2 is "application/com.appetize.oapi.cart.v2+json".

> 🚧 Important Notes
> 
> - Versions can be found for each API in their API Reference Guide (likewise for Swagger documentation)
> - Versions are unique to each endpoint, so be sure to pay attention to the content-type header and set the right value per request.
> - If you are working with V1 of the API, ensure that ALL your content types align with a V1 version. 
> - If you are working with V2, you will notice some endpoints have still not moved past V1. This is ok, as long as you ensure your requests specify the V2 header for ALL endpoints that DO support it.
> - If you are referencing the Swagger documentation, the sample request payloads will change based on the content-type header you select, so pay close attention to V1 vs V2 to ensure you're implementing according to the right specifications.

### Previous Versions

YAML files for previous versions of the APIs can be found below:

Transaction API:  [Link]({{site.baseurl}}/page/tapi-yaml-files)

Ordering API: [Link]({{site.baseurl}}/page/oapi-yaml-files)
