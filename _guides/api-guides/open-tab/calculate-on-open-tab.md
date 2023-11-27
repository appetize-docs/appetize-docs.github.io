---
title: "Calculate on an Open Tab Order"
permalink: /docs/calculate-on-open-tab
published: false
layout: default
createdAt: "2023-06-27T14:18:43.680Z"
updatedAt: "2023-09-01T15:07:35.837Z"
---
**Background:**

This page will walk you through features and details about calling calculate on an open tab order.

**Assumptions:**

This assumes you have already reviewed the create order guide and have an open order

## Behavior

> 👍 Calculations Behavior
> 
> - Calculate looks at manual discounts, automatic discounts, items, price overrides, qty, charity flag to build up-to-date order totals and items 
> - Calculate includes BOTH submitted and unsubmitted items 
> - Calculate returns a payload containing a calculations block and an updated items block
> - An updated items block is returned because certain discounts like BOGO, would will add a new item entry to the order and thus adjust the structure of the items section

> 🚧 How do I know if the orders needs to be calculated or re-calculated?
> 
> - The **needs_to_be_recalculated** is a system set and provided flag that indicates if the calculate endpoint will need be called to update the totals and reflect any changes impacting order calculations
> - This is a read only flag and is provided to help inform the current state of the order totals
> - Any action that could impact an order's totals and potentially alter the item structure will cause the system to set the flag to **true**
>   - Adding / Removing Items 
>   - Adding / Removing Discounts
>   - Changing Item Prices, Item QTY,  Charity Flag

## When to Call?

> 📘 Required Situations
> 
> 1. Call Calculate Before Submitting an order to the kitchen
> 2. Call Calculate Before Checking Out
> 
> The system has checks for the above scenarios and will prevent you from submitting or checking out without having up-to-date totals. If these situations happen, the system will return an error code and message reminding you to call the calculate endpoint.

> 🚧 Conditional or Optional Situations
> 
> 1. Call Calculate if you need totals information for calculating tips
>    1. If you are not maintaining your own cart / not managing prices on the client side
> 2. Call Calculate if you need to Force Close or Cancel an order
> 3. Call Calculate IF you need totals information and "needs_to_be_recalculated" is true

> ❗️ Don't Call Calculate after every action
> 
> - Calculate is a heavy call (time and processing) and should only be called when up-to-date totals are required
> - Calling calculate after every action (like adding or removing items) will create unnecessary load on the system and impact response times

## Payload - Sections

> 📘 Calculations Payload Quick Reference
> 
> - For the full description on all the fields, please see the Calculate API Reference Page
> - **applied_discount_codes**:  contains the list of discount codes that have Not been applied either because calculate has not been called yet or the discount count criteria has not been fulfilled
> - **pending_discounts_codes**: contains the list of discount codes that Have been applied to the order and is reflected in the order totals
> - **order_totals**: section that contains the cumulative amounts calculated for various functions in the calculate process. These totals include subtotals, discounts, taxes, and any other relevant calculations related to the items in the cart.
> - **items**: section contains all the items in the order and may have been updated due to calculations. Example: Items may have been added or combined due to automatic or manual discounts. After calculations is run, you can get the same items information in the Get Orders endpoint.

## Payload Response

```yaml Full
{
  "calculations": {
    "applied_discount_codes": [
      "string"
    ],
    "order_totals": {
      "charity_total": 0,
      "discounts_total": 0,
      "exclusive_tax": 0,
      "fees_total": 0,
      "inclusive_tax": 0,
      "original_total": 0,
      "subtotal": 0,
      "total": 0
    },
    "pending_discount_codes": [
      "string"
    ]
  },
  "items": [
    {
      "item_as_modifier": {
        "item_set_uuid": "61f8454e6622f7327e4b1366",
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002"
      },
      "item_id": 0,
      "name": "string",
      "notes": "string",
      "price": 0,
      "price_override": 0,
      "quantity": 0,
      "user_specified_price": true,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002"
    }
  ]
}
```

* Section: Totals

```json
{
  "calculations": {
    "applied_discount_codes": [
      "string"
    ],
    "order_totals": {
      "charity_total": 0,
      "discounts_total": 0,
      "exclusive_tax": 0,
      "fees_total": 0,
      "inclusive_tax": 0,
      "original_total": 0,
      "subtotal": 0,
      "total": 0
    },
    "pending_discount_codes": [
      "string"
    ]
  },

}
```

* Section: Items

```json
{

  "items": [
    {
      "item_as_modifier": {
        "item_set_uuid": "61f8454e6622f7327e4b1366",
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002"
      },
      "item_id": 0,
      "name": "string",
      "notes": "string",
      "price": 0,
      "price_override": 0,
      "quantity": 0,
      "user_specified_price": true,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002"
    }
  ]
}
```


{% swagger https://api-gw.dev2.appetize-dev.com/orders/docs %}