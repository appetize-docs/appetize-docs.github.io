---
title: "Authentication"
parent: Common API Considerations
nav_order: 4
permalink: /docs/authentication
layout: default
createdAt: "2022-10-11T14:53:50.981Z"
updatedAt: "2022-11-29T20:05:27.789Z"
---
Authentication tokens are required to ensure secure communication across all our APIs. 

As you were getting started, you should have been issued a private key specific to your implementation. If not, please see the [Enabling API Access]({{site.baseurl}}/docs/enabling-api-access) guide first.

Once you have your private key, this will be leveraged for all authentication calls you make through the {{site.product_name}} API family.

{: .important-title }
> Currently Supported APIs
>
> **Ordering** : https://api-gw.sandbox.ent.appetize-dev.com/auth/ordering
> 
> **Transactions** : https://api-gw.sandbox.ent.appetize-dev.com/auth/transactions
> 
> **PubSub** : https://api-gw.sandbox.ent.appetize-dev.com/auth/pubsub
> 
> **Catalog** : https://api-gw.sandbox.ent.appetize-dev.com/auth/items
> 
> **Accounts** : https://api-gw.sandbox.ent.appetize-dev.com/auth/accounts

### Authentication Token TTL
Time-to-Live (TTL) of the token varies depending on the API and environment you are using, so please speak with your integration support specialist to learn yours. Generally they are 15 minutes, ranging between 5 minutes and an hour in some cases. 

The intent behind this is to ensure a small enough window for security purposes, but a large enough window to allow an entire transaction to complete without repeated token re-issuing.

### Requesting an authentication token
Take a look at the [Transactions API Authentication call]({{site.baseurl}}/reference/transactions#/Auth/post_auth_transactions) as a sample. The private key you've been issued is specific to your corporation and venues you've requested to activate. A successful response will return an "auth_key" (or authentication token) which will be available for the TTL mentioned above. 


![Screenshot 2022-11-07 at 6.26.41 PM.png]({{site.baseurl}}/assets/images/docs/e2fb025-Screenshot_2022-11-07_at_6.26.41_PM.png)

### Using the Authentication token in subsequent requests
The authentication token is then sent as a standard BEARER Authorization header as is shown below:



![Screenshot 2022-11-07 at 6.29.09 PM.png]({{site.baseurl}}/assets/images/docs/320efb3-Screenshot_2022-11-07_at_6.29.09_PM.png)


{: .important-title }
> Helpful Notes
>
> * The Authentication Token is only valid for the API you have requested it for. That means any token for Orders will not work for Transactions, even though you are performing an "Order" function when retrieving it through Transactions API. 
> * If you are receiving a 401 response code when using the authentication token, check if it has expired, is being used on the wrong API or is just incorrect.
> * You are not limited to just a single API Key! If you need to separate access to venues based on integration partners (this is common for more complex multi-stadium scenarios), feel free to request separate keys to control access.
