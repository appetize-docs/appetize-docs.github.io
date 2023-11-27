---
title: "Setup a Catalog For Your Store"
parent: Getting Started
nav_order: 3
permalink: /docs/setup-a-catalog-for-your-store
layout: default
createdAt: "2022-10-17T18:16:32.018Z"
updatedAt: "2022-11-14T17:44:54.584Z"
---
## Adding Items
We have [comprehensive documentation](https://support.appetize.com/hc/en-us/articles/360049588594-Enterprise-Items-) to help walk you through creating items for your location. 

When leveraging our Orders API, the main thing to consider when creating new items is to ensure they are assigned to the Venue & Vendor that you plan to order with, otherwise your orders will be rejected due to "missing" items.
![Screenshot 2022-11-09 at 11.51.42 AM.png]({{site.baseurl}}/assets/images/docs/99db47a-Screenshot_2022-11-09_at_11.51.42_AM.png)


![Screenshot 2022-11-09 at 11.52.14 AM.png]({{site.baseurl}}/assets/images/docs/43b35d4-Screenshot_2022-11-09_at_11.52.14_AM.png)

Lastly, make sure your items are Active - if they are not, they will not be available for processing a transaction
![Screenshot 2022-11-09 at 11.50.49 AM.png]({{site.baseurl}}/assets/images/docs/207fe6d-Screenshot_2022-11-09_at_11.50.49_AM.png)


## Adding Item Sets & Modifiers
Modifiers will need to be setup with the "New Mods" format - please see [this article](https://support.appetize.com/hc/en-us/articles/360048561674-Enterprise-Item-Sets) that explains Item Sets in full detail.

{: .important-title }
> Limitations
>
> * Only Enterprise Item Sets / Modifiers are supported by our APIs, and the Classic style of modifiers are not. Please sync with your {{site.product_name}} representative to ensure your items setup will work with the APIs.
> * We recommend setting up items sets/modifiers/items at the corporate level (rather than venue level), and overriding values when needed. Reason why: we're underway improving our Backoffice Item and Modifier management, which will only support a "corporate" level (but still retain vendor level overrides). We will still support all current venue capabilities, but through a simplified and more capable approach that leverages a "corporate" level item instead.

## Adding Item Sets & Modifiers

## Other Catalog Settings
### Setting up Taxes on Items
Please review [this article](https://support.appetize.com/hc/en-us/articles/360049331354-Enterprise-Tax-Rates-and-Tax-Groups) that explains Taxes in full detail.

### Enabling Discounts
See [this article](https://support.appetize.com/hc/en-us/articles/360035943833-Enterprise-Discounts-Overview) that explains Discounts in full detail.

{: .important-title }
> Discounts Supported
>
> While our Backoffice allows for a wide range of discount and promotion configurations, only a subset of them are currently supported within our APIs. Please reach out to your {{site.product_name}} contact for more details to ensure the discount (and configuration thereof) is available.
