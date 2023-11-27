---
title: "Cart Calculate"
permalink: /docs/cart-calculate
published: false
layout: default
createdAt: "2023-06-29T14:03:11.173Z"
updatedAt: "2023-07-05T12:48:05.157Z"
---
**Background:**

This page will walk you through features and details about calling calculate on an order.

**Assumptions:**

This assumes you have already reviewed the create order guide and have an order

**Features:**

## Behavior

> 👍 Calculations Behavior
> 
> - Calculate looks at manual discounts, automatic discounts, items, price overrides, qty, charity flag to build up-to-date order totals and items 
> - Calculate returns a payload containing a Signed Cart

> 🚧 How do I know if the orders needs to be calculated or re-calculated?
> 
> - Any action on the client side that could impact an order's totals and potentially alter the item structure should result in submitting a new Calculate call. These actions may in cluse but are not limited to:
>   - Adding / Removing Items 
>   - Adding / Removing Discounts
>   - Changing Item QTY

## When to Call?

> 📘 Required Situations
> 
> 1. Call Calculate Before Submitting a Checkout call
> 
> The system will prevent you from checking out without having a valid signed cart. If the signed cart is not valid, the system will return an error code and message reminding you to call the calculate endpoint.

> 🚧 Conditional or Optional Situations
> 
> 1. Call Calculate if you need totals information for calculating tips
> 2. Call Calculate if you are finalizing for payment either through our system or via an external payment integration

> ❗️ Don't Call Calculate after every action
> 
> - Calculate is a heavy call (time and processing) and should only be called when up-to-date totals are required
> - Calling calculate after every action (like adding or removing items) will create unnecessary load on the system and impact response times

## Payload

> 📘 Calculations Payload Quick Reference
> 
> - For the full description on all the fields, please see the Calculate API Reference Page

> 📘 Order Totals Payload Quick Reference
> 
> - For the full description on all the fields, please see the Calculate API Reference Page
