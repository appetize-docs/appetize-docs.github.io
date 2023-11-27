---
title: "TAPI - Notes From Brian to Clients"
permalink: /docs/tapi-brian-notes
published: false
layout: default
createdAt: "2022-11-17T18:50:46.795Z"
updatedAt: "2022-11-17T18:51:05.430Z"
---
Here are some other helpful design considerations
You need to pass the returned JWT Token form the /auth call with all subsequent transactions as a Bearer Token in the header.
The auth JWT Tokens have a TTL of 15 minutes - you will need to plan on updating and passing the new bearer token when you are designing your integration to use TAPI.
You need to send the API Key with all requests as an x-api-key in the header on all calls.

A couple of things to note here are that the date / time stamps are in UDT and are passed as parameters. There is a restriction on the timeframe to no more than 7 days between the start and end dates.
At the bottom of the List Orders response is a block of statistics telling you how many pages of data and what the records count is. Currently you will get back no more than 50 records per page. You can pass the page as a parameter as well (see above) to iterate through 
the data set.
The default returned orders will be in a status of Complete - We do have 4 status types - Complete, Incomplete, Deleted and Dead Letter. Deleted and Dead Letter are very rare and usually require intervention to change an order to that status. Incomplete is a status type 
that is usually triggered by potential data retrieval issues as the order passes form the main data source to the TAPI  data source.
Our best practice is to search for both completed (the default returned data) with an additional parameter of retrevial_status=incomplete to sweep any orders that may be in that status.

Currently, when the data is being transported, we do retry up to 7 times before marking the order with a retrieval_status=incomplete, so it is an outlier, but something to be aware of when you are designing your integration to use TAPI.
If an order is in Quarantine it will have a retrieval status of incomplete. To see this order you can add a parameter of &retrieval_status=incomplete and you will see that order show up in the results.

Below is a cURL to retrieve quarantined orders  - It will generate a list of orders that are in an incomplete retrieval status.
curl --location --request GET 'https://api-gw.appetize.services.com/transactions_api/quarantine-orders?start_date=2022-10-07T00:00:00Z&end_date=2022-10-13T23:59:59Z' \
--header 'x-api-key: [Add Key here]' \
--header 'Authorization: Bearer [Add Token Here]'

The corresponding payload will look like this:
{
    "quarantine_orders": [
        {
            "local_order_uuid": "185f65de-bb6c-4c7d-b649-dc3786afc078",
            "corporate_id": 216,
            "order_id": " 123456789",
            "vendor_id": 1284,
            "venue_id": 123,
            "date": "2022-10-21T15:09:03Z",
            "errors": [
                {
                    "message": "Error on get reporting categories",
                    "fields": [
                        "cart_item.item.name",
                        "cart_item.item.sku",
                        "cart_item.item.display_name",
                        "cart_item.item.external_id",
                        "cart_item.kitchen_id",
                        "cart_item.reporting_categories.id",
                        "cart_item.reporting_categories.name",
                        "cart_item.reporting_categories.level"
                    ]
                }
            ]
        }
    ],
    "pagination": {
        "limit": 50,
        "page": 1,
        "total_pages": 1,
        "total_results": 1
    }
}

The data returned in the above example gives us actionable data to correct the issue. In this case we can go into the impacted items in connect, add a reporting category to them then we can reprocess the order to change that retrieval status from incomplete to to complete.

To reprocess this order you can run the /reprocess endpoint 

Quarantine orders should be an outlier at this point - as of the time I am writing this, the example above about missing reporting categories has been resolved with the release of TPI 2.2.0 to the environment that Centegra is testing inn. If you have any additional questions or any issues with getting set up to retrieve data please feel free to reach out to me directly and I will get you the answers you need.

1 final nore is that we are aware of.an issue that can delay orders from being visible in TAPI for up to 30 minutes or so - The team is working on a resolution to this.
