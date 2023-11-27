---
title: "Checkout and Cancel an Open Order"
permalink: /docs/checkout-and-cancel-an-open-order
published: false
layout: default
createdAt: "2023-08-30T21:29:51.801Z"
updatedAt: "2023-09-13T13:32:36.974Z"
---
**Background:**

This page will walk you through features and details about maintaining your discounts in an open tab order.

**Assumptions:**

- This assumes you have already reviewed the create order guide and have an open order

**Features:**

The system provides 2 endpoints to Checkout and Cancel an open tab order.

1. Checkout an order  
2. Cancel an order

## Checkout an Order

> 📘 Features and Usage
> 
> - The Checkout Endpoint will send to Connect to complete and finalize the Open Tab Order
> - Once the order is checked out, you cannot edit, update, or cancel the order.
> - For the Open Tab Order to be checked out, the below requirements must be met.
> 
> **Checkout Requirements: ** 
> 
> 1. The **needs_to_be_recalculated** flag needs to be false, you may need to call the calculate endpoint
> 2. The order must have at least 1 payment attached to the order
> 3. The total payment amount(s) are greater than the order total
> 
> - IF the above requirements are not met, the endpoint will return **error code 422**
> 
> **Checkout Special Instructions** 
> 
> 1. When checking out, please provide the "X-Api-Key" in the header
> 2. X-Api-Key same one as auth
> 3. This is needed because we are currently sending orders to Connect for completion and storage.

> 🚧 Callouts
> 
> **Checkout Order Validations:**
> 
> 1. Cart must contain items, checkout cannot be done on an empty cart
> 2. The total of all payment amounts must be equal or larger than the Order total
>    1. If it is less, that means you may not have charged the customer the correct amount or may not have captured and sent in the correct payment total to Orders V3
>    2. Please check the order totals and payment totals, if needed, remove and re-add the payment with the correct charge totals
> 
> - IF the above requirements are not met, the endpoint will return **error code 422**
> 
> **Additional Notes: **
> 
> - Checkout does NOT check if items have been submitted to kitchen
> - Order may have unsubmitted items due to business different business scenarios, ie merchandise item, that won't need to be submitted to kitchen
> 
> **How long until I see completed orders in Connect?**
> 
> - Completed Open Tab orders will appear in Connect and TAPI in the same amount of time as OAPI orders and is dependent on system load at the time of order completion
> 
> **How do I find the corresponding Connect Order ID for my Open Tab Order?**
> 
> - Open Tab Orders will be assigned a Connect Order ID upon successful checkout 
> - The Connect Order ID is not returned as part of the Checkout Response, this is done for speed / efficiency and reduce the complexity of checkout
> - If you want the corresponding Connect ID, call the Get Order endpoint. The field is called: **connect_id**
> 
> **How long does the Open Tab Order exist in Orders V3?** 
> 
> - Completed and Canceled Orders will be kept in in Orders V3 storage for only 30 days
> - Completed orders are permanently stored in Connect
> - The Orders V3 system is not for reporting, only managing and placing open tab orders
> - To get order details for reporting needs, please review this guide: [Order Retrieval APIs]({{site.baseurl}}/docs/order-retrieval-apis)

> 👍 Completed Orders
> 
> - Orders that have been checked out are placed in a "completed" state
> - These completed orders are now available for viewing in Connect and reporting via PUB SUB and TAPI

> ❗️ Out of Scope
> 
> - There is no Automatic Force Close process for open orders
> - It is the responsibility of the Client using these endpoints to have a process to review and handle open orders that have stayed open for X days.  Either Checkout these Orders or Cancel them.
> - The recommendation is as follows: 
>   1. If the order does Not have any submitted items, cancel the order
>   2. If the order has Submitted items and no payment, add a custom credit card and checkout the order
>   3. This is done to enable you to track these orders in reporting as a loss via the to a custom credit card

## Cancel an Order

> 📘 Features and Usage
> 
> - The Cancel Endpoint will put the order into a cancelled / closed state and will NOT appear in reporting
> - For the Open Tab Order to be canceled, the below requirements must be met.
> - Orders that have been canceled cannot be re-opened or edit or updated.
> 
> **Cancel Requirements:**
> 
> 1. Order cannot contain any submitted to kitchen items
> 2. If you need to close out orders with submitted kitchen items, use your force close process.
> 
> - IF the above requirements are not met, the endpoint will return **error code 422**

> 🚧 Callouts and Best Practices
> 
> - Completed and Canceled Orders will be kept in in Orders V3 storage for only 30 days
> - Reminder: Canceled orders will NOT appear in Connect or reporting

> ❗️ Out of Scope
> 
> - There is no Automatic Force Close process for open orders
> - It is the responsibility of the Client using these endpoints to have a process to review and handle open orders that have stayed open for X days.  Either Checkout these Orders or Cancel them.
