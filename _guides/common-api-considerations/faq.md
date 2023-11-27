---
title: "FAQ"
parent: Common API Considerations
nav_order: 6
permalink: /docs/faq
layout: default
createdAt: "2022-10-17T13:57:20.038Z"
updatedAt: "2022-11-14T17:43:22.081Z"
---
### I have a Production issue, how should I contact support?
Directions for engaging our 24/7 support team can be found on the [{{site.product_name}} website](https://support.appetize.com/hc/en-us/articles/360045242434-Appetize-Support-Access).
### I am sending in first and last name through my Orders payload, but it is not showing on the KDS
V2 of the Orders API changed how guest name is being sent to the KDS. In V1 it is the First and Last name of the customer object, whereas V2 this lives in the payment block. 
### I am currently using the classic version of modifiers - will they work with the APIs?
Unfortunately we only support the newer, enterprise version of modifiers as the APIs. They are often referred to as "New Mods". Please contact you {{site.product_name}} representative if you are unsure of how your items are setup, if they are supported, or if you will need to migrate over to the new modifiers structure before using the APIs.
### Retrieving items from the API shows them all as inactive, but in Connect they are Active
If all items are actually active but are showing as Inactive it is likely due to your Vendor Role not being open. By default, the role should be created as open, so this should only occur if someone intentionally changed it.


![Screenshot 2022-11-07 at 4.54.19 PM.png]({{site.baseurl}}/assets/images/docs/90533ea-Screenshot_2022-11-07_at_4.54.19_PM.png)
