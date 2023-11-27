---
title: "Managing Quarantined Orders"
parent: Orders
grand_parent: API Guides
nav_order: 6
permalink: /docs/managing-quarantined-orders
layout: default
createdAt: "2022-10-11T13:59:06.572Z"
updatedAt: "2022-11-14T18:51:38.816Z"
---
As always, first step is to ensure you have a [valid authentication token]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) that has not expired. 

{: .warning-title }
> NOTE
>
> While this is ordering functionality and will be moving in the near future to the Orders API, it currently lives in the "Transactions" API, so please be sure to use the right authentication token when performing these operations.


## Listing Quarantined Orders
Not all orders always go through perfectly every time. While many orders would be denied while initially being placed and no further action is needed, there are also scenarios where the order will be in a partially completed state. These orders aren't able to be recovered dynamically by the system, which is why they are placed into a quarantined queue so they can be manually resolved.

[This endpoint]({{site.baseurl}}/reference/transactions#/ListQuarantineOrders/listQuarantineOrders) is primarily designed to be a tool for manually handling extraneous error scenarios, but can also be leveraged for EOD reporting if you are looking for more advanced monitoring/tracking of your system.

Date and time filters follow the standard pattern in ISO format ```2021-05-24T00:01:00Z```

{: .important-title }
> Date / Time Filters
>
> **start_date** : Start date and time of when orders were placed
> 
> **end_date** : End date and time of when orders were placed

## Listing Quarantined Orders
You also have the ability to filter by either Dead Letter or Deleted orders. Leave this filter out if you want to retrieve all quarantined orders.


{: .important-title }
> Status Filter
>
> **status** : Limit the list of orders returned to just the status you are interested in. NOTE this currently only supports a single status per request.

## Listing Quarantined Orders
Currently we only support "page" for pagination on quarantined orders. Limit has been fixed to 50 orders per page. Once you retrieve the first page, you will have a **total_pages** field in the response that indicates how many pages in total you have. The **total_results** field will also indicate how many total orders are in the whole queue (this is not specific to the page you retrieved).

{: .important-title }
> Pagination Filter
>
> **page** : Indicate which page number you wish to retrieve, where each page holds 50 records.

## Listing Quarantined Orders
NOTE: The response body also contains an "errors" block that will provide more detail as to why the order was unable to complete successfully. Leverage this, along with the [error code mappings]({{site.baseurl}}/docs/error-handling) to help triage root cause.
## Reprocessing a Quarantined Order
Currently, we don't support the ability to modify an order that is stuck in Quarantine. We do however offer the ability to [retry / reprocess an order that quarantined]({{site.baseurl}}/reference/transactions#/Reprocess/post_orders__local_order_uuid__reprocess). 

Given the manner in which orders are placed online-only through the API today, these orders that are stuck in quarantine will have been placed through one of our other products. This endpoint is likely not something you'll code a recurring task around (albeit an option), but rather a tool to help you resolve those unusual and extraneous error scenarios.
## Dead Lettering a Quarantined Order
In some cases you will not be able to manually resolve a quarantined order, or intentionally want to just dead letter the order as unrecoverable. This is only necessary in rare scenarios and meant for worst-case recovery situations only. Take a look at the [API spec]({{site.baseurl}}/reference/transactions#/MarkDeadLetterQuarantineOrder/markDeadLetterQuarantineOrder) for more details on how to use this endpoint.
