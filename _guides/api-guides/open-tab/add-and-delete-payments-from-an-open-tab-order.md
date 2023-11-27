---
title: "Add and Delete Payments from an Open Tab Order"
permalink: /docs/add-and-delete-payments-from-an-open-tab-order
published: false
layout: default
createdAt: "2023-08-30T18:14:20.326Z"
updatedAt: "2023-09-06T19:20:53.083Z"
---
**Background:**

This page will walk you through features and details about adding and removing payments in an open tab order.

**Assumptions:**

- This assumes you have already reviewed the create order guide and have an open order

**Features:**

The system provides 2 endpoints to add and delete Payments from an open tab order.

1. Add Payment(s) to an order
2. Delete Payment from an order

## Add Payments(s) to an order

> 📘 Features
> 
> - Payment + Tip is added together at the same time
> - Current Payment structure supports the OAPI format to speed up integration
> - Payment structure will be extended in the future to support additional formats
> - You can add Multiple credit card payments at the same time, ie order was paid by 2 credit cards

> 🚧 Callouts + Best Practices
> 
> - Adding payments does NOT require Calculate to be run first
> - We recommend you check the **needs_to_be_recalculated** flag to ensure totals are up to date before charging the credit card and adding payment + tip to the order
> - You can continue adding and removing items after payments have been added 
> - When should I add Payment Information?  Add payments and tip when the customer is finished ordering and is ready to close out their tab order.

> ❗️ Out of Scope
> 
> - The system does not process or run the Credit Card, the system only captures the card information for record keeping
> - The system does not handle Gift Cards unless it behaves like a credit card
> - The system does not handle Cash Payments
> - The system does not allow for editing/patching the Payment information to update Tips or Totals

## Delete Payment from an order

> 📘 Features
> 
> - Removes payment information one at a time
> - Payment + Tip are removed together

> 🚧 Callouts + Best Practices
> 
> - If you need to update the payment information, like tips or totals, remove the payment and re-add with the new information
