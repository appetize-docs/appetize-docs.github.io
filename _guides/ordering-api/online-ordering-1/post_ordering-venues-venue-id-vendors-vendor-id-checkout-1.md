---
title: "Cart Checkout v2"
permalink: /docs/post_ordering-venues-venue-id-vendors-vendor-id-checkout-1
excerpt: "This endpoint processes a signed cart, which has previously been\ngenerated via the /cart/calculate endpoint.  For external payments, we will\nprovide the payment parameters for you to pass in, so that we bypass our internal\npayment verification steps.\n<br>\nIt is also important to note that if an email confirmation is required, the field email must be non empty in the signed_cart and\nan extra field named \"send_email_receipt\", must be manually added and set to true at the root level of the payload's body."
layout: default
published: false
createdAt: "2023-01-20T21:20:22.353Z"
updatedAt: "2023-06-01T18:44:50.479Z"
---
