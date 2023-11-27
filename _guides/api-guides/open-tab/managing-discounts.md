---
title: "Managing Discounts"
permalink: /docs/managing-discounts
published: false
layout: default
createdAt: "2023-06-22T21:32:33.468Z"
updatedAt: "2023-09-01T15:11:48.153Z"
---
**Background:**

This page will walk you through features and details about maintaining your discounts in an open tab order.

**Assumptions:**

- This assumes you have already reviewed the create order guide and have an open order

**Features:**

The system provides 2 endpoints to add and delete manual discounts from an open tab order.

1. Add Discount(s) to an order  
2. Delete a discount from an order

## Add Discount(s) to an order

> 📘 Features
> 
> - You can add one to many discounts to an order
> - Please supply the discount in the ref-tag format as configured in Connect
> - This can be a mix of Order and Item level discounts
> - The endpoint will Validate the discount to ensure it exists in the system (Connect) before adding to the order
>   - Only discounts that are found will be added to the order
>   - For discounts that are NOT found, a 404 status and a list of discounts codes not found will be returned
>   - If ANY discount code was NOT found, NO Discounts will be added
>   - Please fix the discount and resend all discounts again
> - The endpoint does Not Apply or Process the discount(s), only validate and add to the order 
> - To APPLY the discount, please call the Calculate endpoint, which will apply and process the discounts and update totals

> 🚧 Callouts
> 
> - Only Discounts created in Connect are allowed
> - The Add Discount Endpoint does NOT apply the discounts nor update the order totals (that is handled by calculate endpoint)
> - When adding ITEM Level discounts, you do NOT have to worry about linking it to a specific item. When the Calculate Endpoint is called, the system will automatically apply eligible discounts and link item level discounts to the appropriate item(s).
> - Discounts cannot be included when an Order is being created, they can only be added After the Order is created

> 👍 Automatically Applied Discounts
> 
> - If you have setup any auto applied discounts in Connect, they will be automatically added and applied when the calculate endpoint is called
> - These discounts will NOT appear in the applied_discounts section, they will appear in the Order Totals section as a discount

> ❗️ Discounts Out of Scope
> 
> - PPI or External Discounts are out of scope
> - Time based discounts are out of Scope
>   - IE: Discount only applicable between 4:00 pm - 6:00 pm

## Delete a Discount from an order

> 📘 Features
> 
> - The endpoint will delete one discount from the order based on supplied ref_tag code
> - The discount can be at order level or at an item level and the system will properly remove

> 🚧 Callouts
> 
> - After deleting a discount, calculate will NOT be automatically called and the order totals may be out of date

## Calculate and Discounts

> 👍 Calculate and Discounts
> 
> - Each time Calculate is called, the system will attempt to re-apply ALL Discounts, even discounts that have been previously applied will be checked again to ensure they are still applicable
> - **needs_to_be_recalculated:** indicates if the calculate endpoint will need be called to update the totals and reflect any changes impacting total
>   - Depending on the business scenarios, you do not need to call calculate every time after adding discounts
>   - The flag is provided to let you know the state of the totals, if they are outdated
>   - More details about calculate is provided in the Calculate Guide

## Discount Payload Details

> 📘 Discount Payload Information
> 
> - There are 2 different sections in the orders payload that contains discounts
>   - **pending_discounts:** shows discounts that have not been applied yet, either calculate has not be executed or the criteria to apply the discount has not been met yet  (ie buy 3 get 1 free) 
>   - **applied_discounts:** shows discounts that have been successfully applied to the order

> 🚧 Discount Flow and Payload
> 
> **Discounts Before Calculate is Called:**
> 
> - When discounts are added, they will be placed in the "pending_discounts" section.  
> - The "needs_to_be_recalculated" flag will be set to **true**, indicating that order totals have NOT been updated via Calculate.
> 
> **Discounts After Calculate is Called:**
> 
> - Once Calculate is called, any discounts that are eligible will be applied to the order or item level. These discounts will also be moved to the "applied_discounts" section. 
> - The "needs_to_be_recalculated" flag will be set to **false**, indicating that order totals are current and up to date.
> - Any discounts that could NOT be applied (discount conditions were not met), will stay in the "pending_discounts" section

* Before Calculate is Called

```json
{
  "order": {
    "pending_discounts": {
      "reftags": [ "ref_tag01", "ref_tag02"]
    },
    "applied_discounts": {
      "reftags": []
    },
    "needs_to_be_recalculated": true,
    "corporate_id": 0,
    "created_date": "2022-02-22T14:38:25Z",
    "external_id": "this is any string up 64 characters",
  }

}  
```

* After Calculate is Called

```json
{
  "order": {
    "pending_discounts": {
      "reftags": ["ref_tag02" ]
    },
    "applied_discounts": {
      "reftags": ["ref_tag01"]
    },
    "needs_to_be_recalculated": false,
    "corporate_id": 0,
    "created_date": "2022-02-22T14:38:25Z",
    "external_id": "this is any string up 64 characters",
  }

}    
```
