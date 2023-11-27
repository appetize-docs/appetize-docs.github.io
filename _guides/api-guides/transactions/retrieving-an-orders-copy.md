---
title: "Retrieving Orders using GRPC Streaming (PubSub)"
permalink: /docs/retrieving-an-orders-copy
published: false
layout: default
createdAt: "2023-06-21T14:14:58.208Z"
updatedAt: "2023-08-23T19:07:20.738Z"
---
Deprecated in place of: [Order Retrieval API]({{site.baseurl}}/docs/order-retrieval-apis)

***

***

***

As always, first step is to ensure you have a [valid authentication token]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) that has not expired

Once you are subscribed to a GRPC stream you will receive notifications as each order becomes completed and is available in the Transaction API /orders endpoint.

> 📘 NOTE
> 
> - This functionality requires that "Transactions" API" is active for the Venue(s).
> - PubSub "Subscriptions are managed through the  "PubSub API" and does require a separate authorization call when creating a new subscription
> - Historical data will not be available - any order placed prior to enabling your access to this API will not be available via the API. The data will still be available in the BackOffice, reports and all other currently supported channels.
> - The SMS Queue does not retain messages that have been marked as delivered. As with any streaming service there is always the possibility of a "lost message". We recommend that you leverage the Transaction API's ListOrder endpoint to check back every 24 hours to verify that you have all transactions.

## Creating a Subscription

Retrieving near real time order notification is usually leveraged for two main reasons:

1. Financial or Loss Prevention reasons by a client
2. For experience purposes to display detailed order history and real time inventory updating

Take a look at the [API Reference]({{site.baseurl}}/reference/pubsub#/Create%20subscription/post_pubsub_subscriber_subscriptions) for more details.

> 🚧 Only Completed Orders Are Reported
> 
> Currently we only report out fully completed orders. That means that any order that is still partially complete will not generate a notification.
