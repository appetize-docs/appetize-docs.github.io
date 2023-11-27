---
title: "Order Placement APIs"
permalink: /docs/order-placement-apis
excerpt: "Summary of APIs that can be utilized to place Orders with {{site.product_name}}"
published: false
layout: default
createdAt: "2023-08-25T19:54:47.654Z"
updatedAt: "2023-08-28T23:58:31.777Z"
---
{{site.product_name}} provides three different avenues for placing Orders with our system, each suited for different scenarios:

1. [Ordering API](<>)
2. [Check Management](<>)
3. [Mobile API](<>)

To best choose which product suits your needs, let's dive into how they work and what they provide.

# Ordering API

[Ordering API](<>) is a fully-featured set of HTTP endpoints enabling online ordering application use cases. It leverages most aspects of the {{site.product_name}} platform, like location selection, catalog consumption, cart calculation, payments, and checkout.

> 👍 Optimal Uses
> 
> - Building a consumer-facing ordering application powered by or integrated with the {{site.product_name}} platform
> - Retrieving ordering related location configuration for a given venue or vendor
> - Retrieving `Mobile Ordering`enabled catalog data for display purposes
> - Calculating items in a cart, considering taxes, discounts, and more
> - Performing payment operations through supported partners like FreedomPay or Elavon
> - Submitting a completed order to the {{site.product_name}} Platform

> 🚧 Non-Optimal Uses
> 
> - Reporting
> - Catalog management
> - Tabs and open order management

# Check Management

[Check Management](<>) is an HTTP endpoint API currently in development that enables tab creation and order management. Users can add items, send them to the kitchen instantly, collect payment information, and close orders when customers are ready.

> 📘 Currently in Development!
> 
> Check back soon for more information

> 👍 Optimal Uses
> 
> - Building a consumer-facing ordering application powered by or integrated with the {{site.product_name}} platform
> - Creating and managing open orders on the {{site.product_name}} platform
> - Triggering specific items in an open order to be sent to Kitchen (KDS)
> - Associating a completed payment with an open order
> - Closing an open order

> 🚧 Non-Optimal Uses
> 
> - Reporting
> - Location or Catalog retrieval/management
> - Payment operations

# Mobile API

[Mobile API](<>) is our legacy HTTP API that enables users to build an online ordering application utilizing many legacy {{site.product_name}} features.

> 👍 Optimal Uses
> 
> - Building a consumer-facing ordering application powered by or integrated with the {{site.product_name}} platform, only with use of our old mods paradigm, and classic checkout
> - Retrieving ordering related location configuration for a given venue or vendor
> - Retrieving catalog data for display purposes
> - Calculating items in a cart, considering taxes, discounts, and more
> - Performing payment operations through supported partners
> - Submitting a completed order to the {{site.product_name}} Platform

> 🚧 Non-Optimal Uses
> 
> - Use-cases requiring our New Mods paradigm or modern checkout process
