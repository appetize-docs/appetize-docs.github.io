---
title: "Transactions PubSub"
parent: Orders
grand_parent: API Guides
nav_order: 4
permalink: /docs/transactions-pubsub-guide
excerpt: "Guide for navigating Transactions PubSub"
layout: default
createdAt: "2023-08-21T22:58:03.267Z"
updatedAt: "2023-08-23T23:27:55.591Z"
---
# Description

Transactions PubSub facilitates the retrieval of real-time, raw order data by enabling streamed connections that push individual orders as they enter the {{site.product_name}} Cloud. It utilizes queueing technology to ensure guaranteed at least once delivery.

## Use Cases

- Real-time reporting
- War Room dashboards
- Event Day financial, loss prevention, and inventory insight

## Caveats & Limitations

- Only gRPC streams are supported as a connection method
- Queuing does not retain order notifications that have been marked as delivered. Once a message has been sent with no connection error received, it will not be capable of replay.
- Should not be utilized as a single source of truth for populating long-term systems of record. If used for these purposes, Transactions PubSub should be supplemented with regular calls to [Transactions API]({{site.baseurl}}/docs/transactions-api-guide) to capture any "lost" orders.
- Only supports orders placed using our new mods paradigm for items. It does not currently support orders placed with our legacy modifiers paradigm.
- Only provides orders that have been completed and synced to our cloud-based system. It does not contain pending orders or completed orders that have not made it to our system (i.e., orders placed on a Point of Sale device operating in offline mode).
- Does not provide synthesization of order data for aggregated reporting purposes. The data provided is just raw, individual-order data.
- Required to be enabled for each customer. The data it pushes is limited to the orders that flow in _after_ that date. It does not have access to orders beyond that date.
- When adding a new Venue or Vendor to a Corporate, a new subscription will be required for their results to return.
- A single subscription cannot contain a combination of more than 200 Corporates, Venues, or Vendors.

# Getting Started

The first step is to ensure you have a [valid authentication token]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) that has not expired and that a subscription has been created through the PubSub API.

Once you are subscribed to a gRPC stream, you will receive individual order notifications as each is available in the [Transactions API]({{site.baseurl}}/docs/transactions-api-guide) `/orders` endpoint.

Take a look at the [API Reference]({{site.baseurl}}/reference/pubsub) for more details.

# Transactions PubSub Usage Restrictions

- A maximum of 5 streams to a subscription may be open at any given time
