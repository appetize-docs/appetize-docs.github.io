---
title: "Orders V3 Sequence Diagrams"
permalink: /docs/orders-v3-sequence-diagrams
excerpt: "Sequence Diagrams for Orders V3 - Open Tab Orders"
published: false
layout: default
createdAt: "2023-06-02T13:45:42.672Z"
updatedAt: "2023-08-07T22:06:43.746Z"
---
Endpoints have been abbreviated for easier reading and presentation.

## Create, Get, and Edit an Open Order

> 📘 M2 - Order Endpoints
> 
> POST /orders  
> GET /orders  
> GET /orders/{uuid}  
> PATCH /orders/{uuid}

![]({{site.baseurl}}/assets/images/docs/f1d53c9-M2_Sequence_Diagram_Draft.png)

## Get, Add, Edit, and Delete an Item from an Open Order

> 📘 M3 - Item Endpoints
> 
> POST /orders/{uuid}/items  
> PATCH /orders/{uuid}/items/{item_uuid}  
> DELETE /orders/{uuid}/items/{item_uuid}

![]({{site.baseurl}}/assets/images/docs/b2ed1b7-M3_Sequence_Flow.png)

> 📘 M4 - Discount Endpoints
> 
> POST /orders/{uuid}/discounts  
> DELETE /orders/{uuid}/discounts/{discount_reason_code}

![M4_Sequence]({{site.baseurl}}/assets/images/docs/4f5de60-M4_Sequence.png)


> 📘 M5 - Calculate Endpoints
> 
> POST /orders/{uuid}/calculate

![Sequence_Calculate]({{site.baseurl}}/assets/images/docs/844f859-Sequence_Calculate.png)
