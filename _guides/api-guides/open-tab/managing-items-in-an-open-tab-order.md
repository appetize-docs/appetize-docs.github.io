---
title: "Managing Items in an Open Tab Order"
permalink: /docs/managing-items-in-an-open-tab-order
published: false
layout: default
createdAt: "2023-05-25T18:44:24.902Z"
updatedAt: "2023-06-05T14:17:24.707Z"
---
**Background:**

This page will walk you through features and details about maintaining your items in an open tab order.

**Assumptions:**

This assumes you have already reviewed the create order guide and have an open order.

**Features:**

The system provides 3 endpoints to add, edit and delete items from an open tab order.

1. Add Item(s) to an order  
2. Update an Item in an order
3. Delete an item from an order

## Add Item(s) to an order

> 📘 Features
> 
> - You can add one to many items to an order
> - This can be a mix of Parent and Child Items (modifiers)
> - You do not have to provide all the details of each item, just the information to build the item relationships
>   - Optional fields:
>     - Price (only applies if you have price override permissions)
>     - Notes

> 🚧 Callouts
> 
> - When adding multiple items, if ANY add items fail, the whole request will fail and no items will be added
> - You will need to correct the issue and then re-submit everything in the request
> - [Add an Item -  API Reference Link]({{site.baseurl}}/reference/ordersv3#/All%20Check%20Management%20endpoints/OrdersV3Service_AddItems)

## Update an Item in an order

> 📘 Features
> 
> - You can only update 1 item at a time when using this endpoint
> - On a the root parent item, you can edit notes, price, and qty
> - On a modifier, you can edit price and qty, notes do not exist on child items

> 🚧 Callouts
> 
> - The Patch endpoint cannot be used to move a Child item to another Parent
> - If you need to adjust the relationship, delete the Child Item and Re-Add the Child Item with the correct relationship, pointing to the New Parent
> - Callout: you can only update items that have NOT been submitted to the kitchen
> - Once an item has been submitted to the kitchen, they cannot be modified or deleted
> - The system will check and prevent you from editing any item that has been submitted to kitchen
> - [Update an Item - API Reference]({{site.baseurl}}/reference/ordersv3#/All%20Check%20Management%20endpoints/OrdersV3Service_UpdateItem)

## Delete an Item from an order

> 📘 Features
> 
> - You can only delete 1 item at a time when using this endpoint
> - If you delete a Parent, ALL the attached children will be deleted
> - You can even delete in a middle of the tree and all the children below that point will be deleted

> 🚧 Callouts
> 
> - You can only delete items that have NOT been submitted to kitchen, the system will check this
> - When items are deleted, they are soft deleted and saved for troubleshooting purposes
> - Deleted items are no longer retrievable through the API
> - Once an item is deleted, you cannot re-use that UUID within the same order again
> - [Delete an Item - API Reference]({{site.baseurl}}/reference/ordersv3#/All%20Check%20Management%20endpoints/OrdersV3Service_DeleteItem)
