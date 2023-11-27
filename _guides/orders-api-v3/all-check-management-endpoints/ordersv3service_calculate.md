---
title: "Calculate an order"
permalink: /docs/ordersv3service_calculate
excerpt: "Run the calculation process for the order and return all the relevant information related to the order. Additionally, store the last calculation of the order so the user can query the order details without needing to run the calculate function again.\nA flag indicating whether the order needs to be recalculated will be set to false after running this process.\nAn order needs to be calculated before proceeding to the submit to kitchen, add payment or checkout processes. Submitting to the kitchen and adding payments do not alter the state of the \"needs to be recalculated\" flag."
published: false
layout: default
createdAt: "2023-06-01T15:42:03.704Z"
updatedAt: "2023-09-01T15:43:54.236Z"
---
