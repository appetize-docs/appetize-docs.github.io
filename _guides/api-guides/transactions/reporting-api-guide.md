---
title: "Reporting API - Legacy"
parent: Orders
grand_parent: API Guides
nav_order: 5
permalink: /docs/reporting-api-guide
excerpt: "Guide to navigating Reporting API"
layout: default
createdAt: "2023-08-22T16:55:39.081Z"
updatedAt: "2023-08-23T19:03:29.506Z"
---
# Reporting API - Legacy

The Reporting API has been shifted into support-mode-only changes in favor of our latest offerings, [Transactions API]({{site.baseurl}}/docs/transactions-api-guide) and [Transactions PubSub]({{site.baseurl}}/docs/transactions-pubsub-guide).

Current users of Reporting API should consider migrating from RAPI as soon as possible, as access will be turned off in the future. Please feel free to reach out to your {{site.product_name}} representative for more details.

> 📘 Key changes when moving from Reporting to Transactions API
> 
> - Transactions API only supports our New Modifier structure, whereas Reporting API could support both Old and New
> - Some Legacy order sources may not work with Transactions API - like Activate and Interact Classic, as well as our legacy mobile ordering solution, Mobile API.
> - Only transactions placed _after_ signing up for Transactions API will be available for retrieval through the API. All transaction data will still be available in Connect and Reports.
> - Reporting and Transactions API schemas are not a 1 to 1 replacement - fields and structures have been improved, so please reach out if you have specific fields you need but are unsure where (or if) they exist in Transactions API.
