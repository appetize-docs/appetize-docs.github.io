---
title: "Preparing For The Unexpected"
parent: Common API Considerations
nav_order: 3
permalink: /docs/observability
layout: default
createdAt: "2022-09-21T16:45:03.857Z"
updatedAt: "2022-11-14T21:05:46.426Z"
---
To ensure your implementation is a success, we want to support you with observability tools and best practices for those service interruptions that inevitably happen with technology.
## Planning for Downtime
Absolutely no-one wants down time for their APIs, but given the nature of technology and dependancies on 3rd party providers, there is always a probability for it to happen. We continue to strive for the highest availability and uptime standards, but in the worst case scenario we'd like to help you be prepared.

### How to Prepare
* For static content that is crucial to your implementation (lets say menu item data if you're a Menu Board integrator), we recommend a local copy (cache/db/other) on your side to ensure you never lose that information if you are unable to reach our APIs
* For transactional content, think about [error handling]({{site.baseurl}}/docs/error-handling) as well as messaging to your consumers in the case a transaction is rejected or unable to complete due to no response.

## Proactive Monitoring Tools
We are excited to be actively working on enhanced monitoring tools and API availability tools to the public! While this is expected to be available soon, we do still offer high-level status of our APIs. 
<!--
If you have a Single Tenant Environment then please reach out for your custom status url:
* Classic Clients: https://status.appetize.com/ns/mtc
* Enterprise Clients: https://status.appetize.com/ns/ent
-->
While we are constantly monitoring our own stack for any type of issues from slowdowns to outages, we also recommend you implement your own as they relate to your business/operations. The most common recommended monitoring we suggest:
* API response times / success rates - deviations from average for extended periods of time. While we monitor this as well, there could be network outages outside of our infrastructure that we aren't able to alert you of.
* Order volume - while this also could be an indicator of a possible API issue, it more often than not helps identify if there are operational or other impacts to your store.
