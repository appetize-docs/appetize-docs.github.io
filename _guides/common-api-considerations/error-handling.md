---
title: "Error Handling"
parent: Common API Considerations
nav_order: 2
permalink: /docs/error-handling
layout: default
createdAt: "2022-09-21T16:44:45.914Z"
updatedAt: "2022-11-14T15:59:07.158Z"
---
Error handling is a key part of a successful customer or client experience, as it is a guarantee in the vast ecosystem of technologies we all implement. 

As a company we have realized the value in robust error handling within our own APIs and have made efforts to ensure your implementation is predictable and reliable. We are currently working on the next phase of our error handling to provide a full library of error codes with reasons and suggested resolutions (see sample below)! Look for this in 2023.

### Current HTTP status codes we return
**500** - Unknown Failure - This is most likely something you need to engage {{site.product_name}} for support, as it is an abnormal error
**422** - Invalid Payload - Currently a generic catch-all for field validation issues. Two most likely causes are either an incorrectly structured payload or data that is invalid (i.e for Ordering trying to purchase items that aren't available)
**401** - Unauthorized - Assuming non malicious intent, either your API Key is invalid or your Authentication token has expired. 
**200** - Success - This is exactly what we want to see!
<br/>

## Sample Error Codes - Coming Soon!

| HTTP Response Code | {{site.product_name}} error Code | Error Description                              | Suggested Resolution                              |
|--------------------|--------------------|------------------------------------------------|----------------------------------------------------|
| 422                | S0_0001            | Payload is missing required field <field>     | Include <field.json.path> which should be of datatype <datatype> |

## Sample Error Codes - Coming Soon!
