---
title: "TAPI 2.3.0"
permalink: /docs/tapi-230
createdAt: "2023-02-21T20:15:31.484Z"
published: false
layout: default
---
### Feature Updates:

* Added additional internal metrics and logging to aid with troubleshooting
* Optimized database connectivity
* Added unique_id field for items in the transaction response
* order.items.identifiers.unique_id

```json
{ 
 "order_id": 280318673,
 ... 
 "items": [ 
    { 
    ... 
    "identifiers": { 
      "sku": "SKU1513554", 
      "external_id": "ex1513554", 
      "item_id": 1513554, 
      "name": "Burger",
      "unique_id": "u1513554"
      },
    } 
  ], 
  ...
} 
```


### Bug Fixes:  
* Addressed the increased response time for List Order endpoint
