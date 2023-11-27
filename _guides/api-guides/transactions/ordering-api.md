---
title: "Ordering API"
permalink: /docs/ordering-api
excerpt: "Guide for navigating Ordering API"
published: false
layout: default
createdAt: "2023-08-29T19:48:14.107Z"
updatedAt: "2023-08-29T23:46:25.094Z"
---
# Description

Ordering API facilitates online ordering application use cases. It leverages most aspects of the {{site.product_name}} platform, like location selection, catalog consumption, cart calculation, payments, and checkout.

## Use Cases

- Building a consumer-facing ordering application powered by or integrated with the {{site.product_name}} platform
- Retrieving ordering-related location configuration for a given venue or vendor
- Retrieving `Mobile Ordering`enabled catalog data for display purposes
- Calculating items in a cart, considering taxes, discounts, and more
- Performing payment operations through supported partners like FreedomPay or Elavon
- Submitting a completed order to the {{site.product_name}} Platform

## Caveats & Limitations

- Catalog, calculation, and checkout endpoints only support items utilizing our new mods paradigm.
- Required to be enabled for each customer. Location and catalog data retrieved from Ordering API only includes locations flagged for \`Mobile Ordering' in Connect.
- Location and Catalog operations are read-only. Payment and Order operations are create-only.

# Ordering API Functionality

Ordering APIs general functionality is segmented into five areas, roughly following the typical path of an online ordering application:

- Location Information
- Catalog Data
- Calculating an Order
- Processing a Payment
- Completing an Order

## Location Information

## Catalog Data

## Calculating an Order

## Processing a Payment

## Completing an Order

# Ordering API Usage Restrictions

- Ordering API is built and optimized for use within online ordering applications, being called as needed along the user's journey through the ordering path. It gracefully handles several large events happening concurrently so is built for steady order transmission as well as "spiky" use cases such as half-time events.
- Ordering API is _not_ built or optimized for sustained bulk operations like reporting or automated batch ordering.
- We suggest making no more than X requests per second to OAPI, and no more than X concurrent requests
  - Variables like location hierarchy complexity, catalog nesting breadth and depth, and order size can dramatically reduce these suggestions when operating under non-typical use cases
