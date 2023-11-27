---
title: "Submit Order to Kitchen"
permalink: /docs/submit-order-to-kitchen
published: false
layout: default
createdAt: "2023-09-28T19:54:10.152Z"
updatedAt: "2023-10-02T13:44:52.581Z"
---
**Background:**

This page will walk you through features and details about maintaining your discounts in an open tab order.

**Assumptions:**

- This assumes you have already reviewed the create order guide, manage items guide, and have an open order with items

**Features:**

The system provides 1 endpoint to Submit the Order to the Kitchen

1. Submit to Kitchen  

## Submit Order to Kitchen

> 📘 Features
> 
> - Call the submit endpoint to send the order to the kitchen
> - Submitted orders should reach the kitchen in about 1 minute
> - The system will keep track of what items have already been submitted and what has not been submitted
> - When you review the order details payload, submitted items will have a kitchen block and a status of "submitted" and a timestamp of when it was submitted
> - Unsubmitted items will NOT have a kitchen block in the order details payload
> 
> **Submit to Kitchen Requirements:**
> 
> 1. The needs_to_be_recalculated flag needs to be false, you may need to call the calculate endpoint before submitting to kitchen
> 2. Order must have at least 1 item 
> 
> - If the above requirements are not met, the endpoint will return **error code 409**
> -

> 🚧 Callouts
> 
> - Call Calculate before submitting the order to Kitchen
> - Communication to QSRA is one way
> - You cannot delete or remove submitted items from the order
> 
> 

> ❗️ Out of Scope
> 
> - You cannot void or cancel items that have been submitted to the kitchen
