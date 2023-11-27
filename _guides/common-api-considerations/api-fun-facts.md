---
title: "API Fun Facts"
permalink: /docs/api-fun-facts
published: false
layout: default
createdAt: "2022-11-03T19:16:57.909Z"
updatedAt: "2023-05-23T15:33:21.686Z"
---
- Lack of consistent error messages coming back from OAPI. Standardized error responses NB
  - Sync with Jonathon around 401 messages and how much we want to expose. Potentially just a single 401 error message to indicate that they aren't authenticated and need to reach out to {{site.product_name}} to resolve.
- Consistent logging to explain why there was a 422 and particularly around failures.
- Ingesting other peoples data - need a strategy around this. Understanding (especially with Frictionless commerce) how orders are being placed and a customer profile per-se.
- API for PPI was not designed for external use. Sync with Rob. Currently only known use cases are through IW - does this even need to be exposed?
- Long term - eat our own dog food, drink our own champagne. Our APIs that are client facing, should be consumed internally as well.
- API sunset plan NB - deprecating and shutting down older APIs
- Critical bug in reductions related to timestamp... Paul to find additional detail around this.
- All data going forward we should be using UTC for communication internally.
- For OAPI if its not sending recipes - they need to go to settings-mobile ordering - and make sure that “receipt” is enabled

Cloud Cart has a config which you can change to manage fees/discounts/calculations. Sample:  
{  
    "cloud_cart": {  
        "meta": {  
            "enabled": true,  
            "changed_at": "1672938377",  
            "last_change_by": "OAPI - Brendon Request"  
        },  
        "validate_prices": false,  
        "calculate_reductions": true,  
        "calculate_taxes": true,  
        "calculate_fees": false,  
        "validate_cart_sums": false  
    }  
}
