---
title: "Fees"
permalink: /docs/fees
published: false
layout: default
createdAt: "2022-11-28T14:54:32.207Z"
updatedAt: "2022-11-28T14:54:43.471Z"
---
We do have support for custom fees in the API Spec - the block would look something like this:
"fees":[
            {
            "id": "51",
            "name": "3% NJ Healthy Terminal Act fee",
            "hash": "912376d1e0c97514689b02f02932240c",
            "fee_type": "PERCENT",
            "fee_basis": 0,
            "calculated_value": 0,
            "taxable": true,
            "taxes": [
                {
                    "id": 141,
                    "generated_id": 0,
                    "uid": "",
                    "active": true,
                    "value_type": "PERCENTAGE",
                    "price_threshold": 0,
                    "tax_name": "LGA All Tax",
                    "tax_rate": 8.875,
                    "tax_type": "EXCLUSIVE",
                    "tax_value": 0,
                    "is_geo_tax": false,
                    "tax_code": "",
                    "threshold_logic": ""
                }
        ],

To get the info you would need to make a call to the /venue/{venue_id}/vendor/{vendor_id}/fees endpoint, and pass it the following parameters
account_type : employee
account_id : any valid employee id form connect (number at the end of the url when you edit an employee)

This is the curl I used in Latest with the Admin account to pull back a list of custom fees.
'https:\\api-gw.latest.otg.appetize-dev.com\ordering/venues/114/vendors/804/fees?account_type=employee&account_id=5037459' \

I have not been able to pass an order with a fee yet, but that may be due to other issues in the saved payload I am working with. I wanted to pass along this info so you would know where we are at with this. Once I get a successful order passed I will let you know.
