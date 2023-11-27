---
title: "Cart Calculate v2"
permalink: /docs/post_ordering-venues-venue-id-vendors-vendor-id-cart-calculate-1
excerpt: "This endpoint takes a `CartRequest`, performs calculations and validations on it, and returns a signed version that can be submitted to the `Checkout` endpoint.\nIt is important to note that there are some options that may apply depending on your environment, corporate, venue or vendor configuration:\n\n- Calculate Fees: enable or disable fees calculation that comes from connect.\n- Calculate Reductions: enable or disable reductions calculation that comes from connect.\n- Calculate Taxes: enable or disable taxes calculation that comes from connect.\n- Calculate Modifier Items: enable or disable modifiers items calculation that comes from connect.\n- Calculate Payment Partner Integrations *also know as PPI Discounts*:  enable or disable PPI Discounts calculation that is used by AX/IX to integrate Stored Values (SV) and Loaded Values (LV) payments easily.\n- Validate Prices: validate each item if the price is correct and if it belongs to the venue/vendor station\n- Validate Cart Totals: validate if calculated subtotal is what is expected, you can not use this along with (Fees, Reductions, Taxes, Modifiers or PPI Discounts)\n\n> Additional note: When passing in a cart, use `tip_status_closed=false` to force the tip status to be left open on cart checkout, allowing for a tip to be added in a subsequent tip adjustment endpoint."
layout: default
published: false
createdAt: "2023-01-20T21:20:22.353Z"
updatedAt: "2023-06-01T18:44:50.159Z"
---
