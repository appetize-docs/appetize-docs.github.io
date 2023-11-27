---
title: "Refund an Order"
parent: Orders
grand_parent: API Guides
nav_order: 7
permalink: /docs/refund-an-order
layout: default
createdAt: "2023-02-13T14:30:41.159Z"
updatedAt: "2023-03-07T22:06:12.640Z"
---
<h2>Background</h2>
OAPI now has endpoints to create a full refund on an order and view the refund details.

<h2>What Orders are Eligible for Refund via OAPI?</h2>
OAPI will run through the below requirements when initiating a full refund. You don't need to memorize the below details, they are provided for clarity and handled by the API.

<h3>Refund Requirements</h3>


{: .important-title }
> Payment Criteria
>
> - Paid in full by a single credit card
> - Paid via one of the below supported Payment Gateways
> - Elavon - Simplify, Converge, Fusebox, and PAX
> - Freedom Pay



{: .important-title }
> Order Criteria
>
> - ALL items in the order are eligible for refund (item property in Connect)
> - Order cannot be already refunded or partially refunded
> - Order must be in a completed status, cannot be in a pending status or any other status
> - Order was created by AX, Interact Web, or by OAPI


{: .warning-title }
> What is Out of Scope for Refunds via OAPI?
>
> - Orders paid in cash
> - Orders paid with multiple credit cards
> - Orders paid in a mix of cash and credit card(s)
> - Orders created by Suites

  
<h2>What will happen when a full refund occurs?</h2>

 * A new order will be created with negative values
 * The original order will not be touched or modified
 * 100% of the amount will be returned to the original credit card
 * No more / no less than the original amount
 * Tips will be refunded


<h2>Business Input for Creating a Refund</h2>

As part of creating a refund order, you can provide input data that will be captured and used on the reporting side. This information represents why an order was refunded.  Business documentation on setting up Reason Codes in Connect: [Link](https://support.appetize.com/hc/en-us/articles/360048561694-Enterprise-Reasons)



{: .important-title }
> Why was the Order Refunded?
>
> Input Data: reason name and reason code
>   - Please work with your business team to determine what reason name and codes to utilize
>   - A possible option would be to have dedicated reason names and codes for OAPI related refunds
>   - These values are required, but are not validated against any existing list

<h2> Additional Notes</h2>

{: .important-title }
> Who Refunded the Order?
>
> Today we are capturing the terminal account id for the vendor of where the order was created.
> 
> Note: This also matches what OAPI is doing when orders are created by Interact Web.


## Refund Endpoints

There are 2 endpoints related to refunds. One for getting refund eligibility + details about an order and another for creating the refund order. You do NOT have to manually run and check each order's eligibility before creating the refund order.  The POST refunds endpoint will check the order's eligibility before creating a refund.
 * [GET /ordering/order/{order_id}]({{site.baseurl}}/reference/orders#/Order%20Refunds/get_ordering_order__order_id_)
 * [POST /ordering/order/{order_id}/refunds]({{site.baseurl}}/reference/orders#/Order%20Refunds/post_ordering_order__order_id__refunds)
  

{: .important-title }
> GET /ordering/order/{order_id}
>
> This endpoint can be used to return refund details about an order, see the refund object in the payload. There are 3 types of orders that can be returned by the endpoint:
> 
> 1. An Order that has NOT been refunded  
> The new refund object in the payload contains a refundable order level flag (true or false). This indicates if the order is eligible for full refund via OAPI. If the order is eligible, it will be set to true.  If the order does not meet the criteria or has already been refunded, it will be set to false.
> 
> 2. An Order that has been refunded
> On an Order has been refunded, the refundable order flag will be set to false and the refund object will contain the total amount refunded and remaining amount that has not be refunded yet.  At this time, with a full refund, the remaining amount will always be $0.00. The remaining amount field is provided to handle future scenarios with partial refunds. The refund object will also contain an array of corresponding refund orders. At this time, for full refunds, it will be a single refund order.
> 
> 3. The Refund Order
> The Refund Order is order created by the POST refunds endpoint. The refund object will contain the original_order_id, refundable order flag as false, and information about why the order was refunded and by who.
> 
> Orders already refunded by Connect or AX can appear in this endpoint


{: .important-title }
> POST /ordering/order/{order_id}/refunds
>
> Use this endpoint to refund an order. 
> 
> Supply the following information: the order_id you wish to refund, the reason name, and reason code
>   - Order_ID can be found in TAPI or with OAPI Get orders endpoint mentioned above
>   - Reason name and reason code is defined and provided by your business team as mentioned earlier
