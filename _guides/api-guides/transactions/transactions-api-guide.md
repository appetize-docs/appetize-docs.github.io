---
title: "Transactions API"
parent: Orders
grand_parent: API Guides
nav_order: 3
permalink: /docs/transactions-api-guide
excerpt: "Guide for navigating Transactions API"
layout: default
createdAt: "2023-08-21T20:07:55.817Z"
updatedAt: "2023-08-23T19:03:13.352Z"
---
# Description

Transactions API facilitates the retrieval of raw, historical order data by enabling calls to pull shallow lists of bulk order data and deep individual order data.

## Use Cases

- Retrieving a snapshot of completed orders in a given time range
- Pulling large quantities of completed orders, infrequently
- Populating a data warehouse for long-term, aggregate reporting purposes

## Caveats & Limitations

- Only supports orders placed using our new mods paradigm for items. It does not currently support orders placed with our legacy modifiers paradigm.
- Only provides orders that have been completed and synced to our cloud-based system. It does not contain pending orders or completed orders that have not made it to our system (i.e., orders placed on a Point of Sale device operating in offline mode).
- Does not provide synthesization of order data for aggregated reporting purposes. The data provided is just raw, individual-order data.
- Required to be enabled for each customer. The data it can retrieve is limited to the orders that flow in _after_ that date. It does not have access to orders beyond that date.

# Getting Started

The first step is to ensure you have a [valid authentication token]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) that has not expired.

You have the option to retrieve either a single order or a list of orders depending on your use case.

# Retrieving a Single Order

Retrieving a single order is usually leveraged for two main reasons:

1. Financial or Loss Prevention reasons by a client
2. For experience purposes to display detailed order history

Take a look at the [API Reference]({{site.baseurl}}/reference/transactions#/GetOrder/getOrder) for more details.

> 📘 Only Completed Orders Are Reported
> 
> Currently we only report fully completed orders. Any order that is still partially complete will not show up when trying to retrieve a single or multiple orders. Orders that do not qualify:
> 
> - Orders with status other than "Completed" (like "Pending")
> - Orders with status "Completed" but tip status "Pending"
>   - Tip status also needs to be closed before the order will be reported, so if you are seeing orders not show up that allow for tips post-completion, this is likely the reason.

# Retrieving Multiple Orders

The intended use case for [this endpoint]({{site.baseurl}}/reference/transactions#/ListOrders/listOrders) is for end-of-day reconciliation or for integration partners to retrieve a list of orders that were placed for specific locations they are interested in. 

Currently, we do not support retrieving orders by customer ID, so this would not fulfill a use case of listing orders for an individual customer. 

There are two ways you can filter results by date/time - either when the transaction actually happened or when the transaction was recorded to the cloud. This is important to note, particularly for orders that originated from the POS (Activate), as those orders could have been placed in offline mode and only synced to the backoffice at a later date/time.

> 📘 Date / Time Filters
> 
> **start_date** : Start date and time of when orders were placed  
> **end_date** : End date and time of when orders were placed
> 
> Format used is ISO standard for all the date and time filters: `2021-05-24T00:01:00Z`

There are two retrieval statuses that TAPI supports: Complete and Incomplete.

> 📘 Order Status Filter
> 
> **retrieval_status** : Limit the list of orders returned to just the status you are interested in. NOTE this currently only supports a single status per request.

Finally, you also have standard `limit` and `page` filters that allow you to control the results returned to best suit your implementation and/or average order size.

> 📘 Pagination Filters
> 
> **limit** :  Restrict the number of results returned in the payload  
> **page** : Indicate which page number you wish to retrieve. If no limit is set, there is only 1 page available. If, for example, you have 100 orders and set the limit to 5, page 20 would return orders 96 - 100.

> 🚧 How to ensure ALL orders are retrieved
> 
> Currently this endpoint ONLY returns completed/successful orders. If you need to see all orders that we're recorded including those that had issues, you also need to ensure you are retrieving all [quarantined orders]({{site.baseurl}}/docs/managing-quarantined-orders)

# Transactions API Usage Restrictions

- The List Orders endpoint is designed for infrequent, bulk order use. `ListOrders` call cadence should adhere to the following formula: for the number of hours in a window, divide those by two to determine the maximum call frequency. Examples:
  - A 30-minute window can be made once every 15 minutes
  - A 1-hour window can be made once every 30 minutes
  - A 24-hour window can be made once every 12 hours
  - A 72-hour window can be made once every 36 hours
- The single-order`Order` endpoint is designed to expand the results of`ListOrders` when required. Please limit single-order calls to no more than 30 per second when batching multiple `Order` calls.
