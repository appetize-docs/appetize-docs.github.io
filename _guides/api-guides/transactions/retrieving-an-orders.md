---
title: "Retrieving an Order(s)"
permalink: /docs/retrieving-an-orders
published: false
layout: default
createdAt: "2022-09-21T18:10:47.902Z"
updatedAt: "2023-08-23T19:06:11.982Z"
---
Deprecated in place of: [Order Retrieval API]({{site.baseurl}}/docs/order-retrieval-apis)



***

***

***



As always, first step is to ensure you have a [valid authentication token]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) that has not expired

You have the option to retrieve either a single order or a list of orders depending on your use case.

> 🚧 NOTE
> 
> - While this is ordering functionality and will be moving in the near future to the Orders API, it currently lives in the "Transactions" API, so please be sure to use the right authentication token when performing these operations.
> - Currently the List Orders endpoint is designed for EOD reconciliation for an entire corporation (once every 24 hours). For a single store the limit is once every 30 minutes, for the prior hour. For near-real-time needs, consider leveraging our Pub/Sub approach.
> - Historical data will not be available - any order placed prior to enabling your access to this API will not be available via the API. The data will still be available in the BackOffice, reports and all other currently supported channels.

## Retrieving a Single Order

Retrieving a single order is usually leveraged for two main reasons:

1. Financial or Loss Prevention reasons by a client
2. For experience purposes to display detailed order history

Take a look at the [API Reference]({{site.baseurl}}/reference/transactions#/GetOrder/getOrder) for more details.

> 📘 Only Completed Orders Are Reported
> 
> Currently we only report out fully completed orders. That means that any order that is still partially complete will not show up when trying to retrieve a single or multiple orders. Orders that would not show up:
> 
> - Order with status other than "Completed" (like "Pending")
> - Order with status "Completed" but tip status "Pending"
>   - Tip status also needs to be closed before the order will be reported, so if you are seeing orders not show up that allow for tips post-completion, this is likely the reason.

## Retrieving Multiple Orders

The intended use case for [this endpoint]({{site.baseurl}}/reference/transactions#/ListOrders/listOrders) is for EOD reconciliation, or for integration partners to retrieve a list of orders that were placed for specific locations they are interested in. 

Currently we do not support retrieving orders by customer ID, so this would not fulfill a use case of listing orders for an individual customer. 

There are two ways you can filter results by date / time - either when the transaction actually happened, or when the transaction was recorded to the cloud. This is important to note, particularly for orders that originated from the POS (Activate), as those orders could have been placed in offline mode and only synced to the backoffice at a later date/time.

> 📘 Date / Time Filters
> 
> **start_date** : Start date and time of when orders were placed  
> **end_date** : End date and time of when orders were placed  
> **start_sync_date** : Start date and time of when orders were recorded to the cloud  
> **end_sync_date** : End date and time of when orders were recorded to the cloud
> 
> Format used is ISO standard for all the date and time filters: `2021-05-24T00:01:00Z`

There are four retrieval statuses that TAPI supports: Complete, Incomplete, Dead Letter and Deleted.

> 📘 Order Status Filter
> 
> **retrieval_status** : Limit the list of orders returned to just the status you are interested in. NOTE this currently only supports a single status per request.

Finally, you also have standard **limit** and \*_page_ filters that allow you to control the results returned to best suit your implementation and / or average order size.

> 📘 Pagination Filters
> 
> **limit** :  Restrict the number of results returned in the payload  
> **page** : Indicate which page number you wish to retrieve. If no limit is set, there is only 1 page available. If, for example, you have 100 orders and set the limit to 5, page 20 would return orders 96 - 100.

> 🚧 How to ensure ALL orders are retrieved
> 
> Currently this endpoint ONLY returns completed/successful orders. If you need to see all orders that we're recorded including those that had issues, you also need to ensure you are retrieving all [quarantined orders]({{site.baseurl}}/docs/managing-quarantined-orders)

## Reporting API - Deprecated

The Reporting API has been deprecated in favor of these Ordering API endpoints that provide the same capabilities (with additional enhancements).

If you are an existing client that still uses the Reporting API, please consider moving over to the Ordering APIs ASAP, as access to that API will be turned off in the future. Please feel free to reach out to your {{site.product_name}} representative for more details.

> 📘 Key changes when moving from Reporting to Transactions API
> 
> - Transactions API only supports our New modifier structure, whereas Reporting API could support both
> - iOS devices are not supported and will not report in Transactions API
> - Only transactions placed AFTER signing up for API access will be available for retrieval through the API. All transaction data will still be available in Connect and Reports though.
> - API schemas are not a 1 to 1 replacement - fields and structures have been improved, so please reach out if you have specific fields you need but are unsure where (or if) they exist on the Transactions API
