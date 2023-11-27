---
title: "Order Retrieval APIs"
parent: Orders
grand_parent: API Guides
nav_order: 2
permalink: /docs/order-retrieval-apis
excerpt: "Summary of APIs that can be utilized to retrieve Orders from {{site.product_name}}"
layout: default
createdAt: "2023-08-18T20:52:12.539Z"
updatedAt: "2023-08-25T20:03:53.940Z"
---
{{site.product_name}} provides three different avenues for retrieving Orders from our system, each suited for different scenarios:

1. [Transactions API]({{site.baseurl}}/docs/transactions-api-guide)
2. [Transactions PubSub]({{site.baseurl}}/docs/transactions-pubsub-guide)
3. [Reporting API]({{site.baseurl}}/docs/reporting-api-guide)

To best choose which product suits your needs, let's dive into how they work and what they provide.

# Transactions API

[Transactions API]({{site.baseurl}}/docs/transactions-api-guide) is a pull-based API that enables retrieval of individual orders and order batches filtered by properties like `local_order_uuid`, `start_date`, `end_date`, and `retrieval_status`.

> 👍 Optimal Uses
> 
> - Retrieving a snapshot of completed orders in a given time range
> - Pulling large quantities of completed orders infrequently
> - Populating a data warehouse for long-term, aggregate reporting purposes

> 🚧 Non-Optimal Uses
> 
> - Real-time reporting or war room dashboards

# Transactions PubSub

[Transactions PubSub]({{site.baseurl}}/docs/transactions-pubsub-guide) is a stream-based API that enables the retrieval of individual orders as they are entering our system.

> 👍 Optimal Uses
> 
> - Real-time reporting
> - War Room dashboards
> - Event Day financial, loss prevention, and inventory insight

> 🚧 Non-Optimal Uses
> 
> - Historical order data retrieval

# Reporting API

[Reporting API]({{site.baseurl}}/docs/reporting-api-guide) is our legacy pull-based API that enables retrieval of individual orders and order batches.

> 👍 Optimal Uses
> 
> - Event information
> - High level sales statistics
> - Legacy Item information
> - Reporting on orders using legacy items
> - Venue and vendor information

> 🚧 Non-Optimal Uses
> 
> - Real-time reporting or war room dashboards
> - Near real time reporting
> - Reporting on non legacy items
