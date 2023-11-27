---
title: "TODO - List Of Things To Document"
permalink: /docs/todo-list-of-things-to-document
published: false
layout: default
createdAt: "2022-10-10T19:01:07.821Z"
updatedAt: "2023-01-08T20:56:03.199Z"
---
Deprecation Guide - chart like PHP showing how long each version is supported for and until

Need to include list of "SandboxOnboardingActions" issue into this document, like V1 not supporting open priced items.

Placing an Order:
- Items need to be assigned to vendor
- Terminal Account needs to  use terminal roles and permission set - TR has the payments support
- Vendor created needs to have default mobile ordering set
- Ensure roles and items are active
- Discount - when creating, check time, as it might show as "pending" instead of "Active" if not set in the past
- Still need to figure out how to enable CC payment - not working, maybe the payment payload?
- Fees - figure out how to retrieve, why employee is tied to it
- Order with fees - can apply multiple, pre or post tax explained, sample of how you can send in a fee to trigger it instead of auto apply only (auto and manual)
- Explain the admin API key needing the ability to override prices (request from {{site.product_name}} Admin) if you want to send in an open price item, and share example of how to do this.
- Break down reporting categories vs POS categories, and when we should be using them.


Masterclass in documentation and diagrams for implementation guides - sample yellowdog:
https://help.yellowdogsoftware.com/appetize/
Make it part of the certification?

RAPI - direct link if anyone needs it: https://connect.appetizeapp.com/developer_dashboard/reporting-api/index

- Suggested number of records per page for TAPI retrieving orders.
- Figure out all TAPi supported statuses, add more content there
- Move ALL Swagger YAMLs here, internal and external : https://jarvis.appetizeinc.com/docs/
- Authentication -  Consider mentioning upper limit of venues per token (need to find this)
- Add detail about retrieving  vendors, if you don't specify venue you can get everything
- Add "Seat/Section" setup details - [URGENT] Spurs: How to share user's seat details with vendor offering In-Seat Delivery. Note that currently cannot retrieve list of vendors by seat
- Add modifiers note about only supporting new mods
- Add setup information for modifiers
- NB need to have a page on how to engage us to integrate, mention support and Brian's time needed, need all requirements etc
- Note about V1 vs V2 name going down to KDS
- What are different gateways we support taking payments through, any at all? Is it all through Elavon's checkout.js library? what about FP?
- Payments made on OAPI or CM will allow the same or more than the total amount on the order (to support tips)

### TIP Status:
- With tip status clsoed set to true, "completed" tip status in Connect, sends to TAPI
- With tip status not sent, does not send to TAPi and Pending Tip in Connect
- With Tip status to false, also does not send to TAPI and pending tip in connect

{: .warning-title }
> Remaining fixes needed on documentation for Orders
>
> * Retrieving an Order(s)
> - Get actual recommended time between calls
> - Need to add a note about timezone orders are recorded in

Also from Spurs (and others) - add note about how to control items coming through the APIs:
- Active/Inactive at the Item level (affects everyone)
- Active/Inactive on the list of Vendors to mark inactive just for that vendor
- Remove it from the Vendor explicitly - basically same as inactive/active but what impacts to refunds etc?
- Sold Out - this is currently at the Item level (confirm), and what happens if you change it at corporate vs Venue?

Old TSC function where you place mobile order and auto-print through AX. Is this still available? How does this tie to DSPs and an Order HUB?

NB items are REQUIRED to have a reporting category to go through, otherwise they will be quarantined. This requirement is being lifted, so likely just need to document which version this happens before.

### Quarantine Orders
**TODO** I think we exclude this section, or just reference the list orders endpoint instead. Questions we need answered and documented here:
* Can you retrieve all quarantine orders from List Orders instead? Is it just pulling by "Incomplete" or is there some separate table?
* Marking and order as dead letter makes no sense if you can retrieve an order that is "quarantined" with a "dead letter" status.
* what is deleted status compared to dead letter?
* why are there only dead letter and deleted status to filter on - aren't those technically no longer quarantined orders and should not be retrieved through this endpoint (and rather just all orders endpoint?)?
* What are all the scenarios where order can land in quarantine (likely not via API)
