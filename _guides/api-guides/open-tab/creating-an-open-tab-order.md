---
title: "Creating an Open Tab Order"
permalink: /docs/creating-an-open-tab-order
published: false
layout: default
createdAt: "2023-05-04T15:20:27.242Z"
updatedAt: "2023-05-05T17:11:07.441Z"
---
**Background:**

This is a happy path flow for creating an open tab order with 1 drink item with a modifier.

A customer selects the drink **Heineken** and adds a **shot of Aviation Gin**.

Link to the Create Order API Reference [Link]({{site.baseurl}}/reference/ordersv3#/All%20Check%20Management%20endpoints/OrdersV3Service_CreateOrder)

**Assumptions:**

This assumes you have already pulled the item information from the Menu Endpoint in OAPI or through Items API.

> 🚧 FYI
> 
> This is NOT the complete payload with all the elements (like discounts).
> 
> Showing only the essential elements to keep it simple and easier to digest.

> 📘 Information Needed to Create the Open Tab Order
> 
> - item_id of the parent item
> - item_id of the modifiers (child item)
> - item_set_uuid of the item set that the modifier belongs to
> - Information can be found in Connect or via OAPI Menu Endpoint
> - uuid are optional, the system will automatically create if not provided. If you want to provide UUID, please follow RFC 4122 standard

We are including a screenshot of the Item Map to help visualize relationships.

![]({{site.baseurl}}/assets/images/docs/199c0ae-small-Heineken.png)

**Open Tab Order Request Payload**

* Request Payload

```json
{
  "external_id": "Client_External_Order_ID",
  "seat_id": 0,
  "metadata": "string: 1024 Character limit",
  "items": [
    {
      "item_id": 1655817,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT", 
      "quantity": 1
    }, 
   {
      "item_id": 1655810,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120003-CHILD", 
      "quantity": 1,
        "item_as_modifier": {
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT",
        "item_set_uuid": "644c03569f554be17888a9c1"    
      }
    }
  ]
}
```

* Order Level

```json

{
  "external_id": "Client_External_Order_ID",
  "metadata": "string: 1024 Character limit",
  "seat_id": 0
}
```

* Item Level

```json

{

  "items": [
    {
      "item_id": 1655817,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT", 
      "quantity": 1
    }, 
   {
      "item_id": 1655810,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120003-CHILD", 
      "quantity": 1,
        "item_as_modifier": {
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT",
        "item_set_uuid": "644c03569f554be17888a9c1"    
      }
    }
  ]
}
```



## Payload Break Down: High Level

**Order: High Level Information**

* Order High Level

```json
{
  "external_id": "Client_External_Order_ID",
  "metadata": "string: 1024 Character limit",
  "seat_id": 0
}
```



> 📘 Order Details
> 
> **external_id:**
> 
> - Optional Field
> - Client provided value, used as an external reference to an order in the client system
> - Must follow UUID standards RFC 4122
> - Note:
>   - This example is using a made up value for easier reading purposes
>   - This it NOT a compliant UUID
>   - Must follow UUID standards RFC 4122
> 
> **metadata**
> 
> - Optional Field
> - Client provided value that can be anything you want, represents order metadata not payment metadata
> - Restriction: 1024 character limit
> - Captures anything you want to add
> 
> **seat_id:**
> 
> - From Connect (via OAPI Menu Endpoint)

***



## Payload Break Down: Item Level

**Order: Item Level Information**

A customer uses mobile app and selects the drink **Heineken** and adds a **shot of Aviation Gin**.

* Item Example

```json
{
  "items": [
    {
      "item_id": 1655817,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT", 
      "quantity": 1
    }, 
   {
      "item_id": 1655810,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120003-CHILD", 
      "quantity": 1,
        "item_as_modifier": {
        "item_set_uuid": "644c03569f554be17888a9c1",    
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT"
      }
    }
  ]
}

```



**Parent Item Information**

* Parent: Heineken

```json
 {
      "item_id": 1655817,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT", 
      "quantity": 1
  }
```



> 📘 Parent Item
> 
> **Heineken**
> 
> - This is a parent item, as it does NOT have the item_as_modifier block
> 
> **item_id:** 1655817
> 
> - From Connect (via OAPI Menu Endpoint)
> 
> **uuid:**  _736b99f8-9113-11ed-a1eb-0242ac120002-PARENT_
> 
> - This is an optional field, you can provide or we will automatically build for you
> - Must be a unique id for the whole order 
>   - **Note: **
>   - _This example is using a made up value for easier reading purposes_
>   - _This it NOT a compliant UUID_
>   - _Must follow UUID standards RFC 4122_

***



**Modifier (Child Item) Information**

* Modifier

```json
{
      "item_id": 1655810,
      "uuid": "736b99f8-9113-11ed-a1eb-0242ac120003-CHILD", 
      "quantity": 1,
        "item_as_modifier": {
        "parent_uuid": "736b99f8-9113-11ed-a1eb-0242ac120002-PARENT",
        "item_set_uuid": "644c03569f554be17888a9c1"    
      }
 }
```



> 📘 Modifier (Child Item)
> 
> **Shot of Aviation Gin**
> 
> - This is a modifier (a child item), because it has the item_as_modifier block
> 
> **item_id: ** 1655810
> 
> - From Connect (via OAPI Menu Endpoint)
> 
> **uuid:**  736b99f8-9113-11ed-a1eb-0242ac120003-CHILD
> 
> - This is an optional field, you can provide or we will automatically build for you
> - Must be a unique id for the whole order 
>   - **Note:**
>     - _This example is using a made up value for easier reading purposes_
>     - _This it NOT a compliant UUID_
>     - _Must follow UUID standards RFC 4122_
> 
> **item_as_modifier:**
> 
> - This block identifies Shot of Gin as a modifier and links it to the Parent Item
> 
> **parent_uuid:**_736b99f8-9113-11ed-a1eb-0242ac120002-PARENT_
> 
> - The parent uuid that Shot of Gin is Modifying
> - In this example, the parent is Heineken
> 
> **item_set_uuid:** _644c03569f554be17888a9c1_
> 
> - This is the Template ID of the Item Set from Connect (via Menu Endpoint)
> - In this example: the Item Set is: _Beer Add a Shot_

> 👍 Order Successfully Created
> 
> After the order is successfully created, an Order UUID will be returned

> 🚧 Additional Notes
> 
> - **IF I did not provide UUIDs for the different items, how do I get that information?**
>   - You will need to call the Get Order by UUID endpoint to see those details
> 
> - **Why would I define my own UUID for the different items?**
>   - You would want to define your own item UUID in order to provide the modifier relationship information in the **initial ** create order call. This is an efficient approach and way to consolidate steps.
>   - If you did not provide the UUID for the items, you would not have been able to define the modifier relationships in the initial create order call.  
>     - The follow would be: 
>       - Create Order with Parent Item (no UUID)
>       - Call Get Order to see the Order Payload with the system generated UUID
>       - Add / Edit Order to create the child items and relationship to the parent using the UUID
