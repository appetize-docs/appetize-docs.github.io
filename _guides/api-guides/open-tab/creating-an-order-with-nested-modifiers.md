---
title: "Creating an Order with Nested Modifiers"
permalink: /docs/creating-an-order-with-nested-modifiers
published: false
layout: default
createdAt: "2023-05-05T13:32:46.273Z"
updatedAt: "2023-06-27T13:47:50.995Z"
---
**Background:**

This page will walk you through creating an Open Tab Order with nested modifiers.

Nested Modifiers are a lot easier to handle in Orders V3.

**Assumptions:**

- You have nested modifiers already defined in Connect
- You have pulled the item and item set details via the Menu endpoint

> 📘 Example Item
> 
> - In this example, we've created an Item that has a nested modifier that is extremely deep
> - We've included an Item Map screenshot to help visualize the scenario
>   - The Orange box represents the Parent Item
>   - The Blue boxes represent the Item Sets
>   - The Green boxes represent the Selected Modifier  (what modifiers the customer wants for their item)

![]({{site.baseurl}}/assets/images/docs/bd93078-small-Example_Nested_Modifiers.png)

> 📘 Walkthrough
> 
> - In this example, the customer has selected 1 modifier under each item set and these modifiers happens to have children 
> - You do not need to know about the the root map nodes or map nodes of the item 
> - You just need to understand the parent and child relationship of each modifier
> - **A modifier can be both a parent and child:**
>   - Item_uuid2 is modifier and child of parent_item_uuid
>   - Item_uuid2 is also the parent of item_uuid3
> - From here, you just need to add the relationship information to the order

> 📘 Nested Modifier Payload - Part 1
> 
> - The Open Tab Order shows items and their modifiers in a flat structure vs tree structure
> - A Parent and Child relationship
> - Creating the payload for this relationship is extremely easy!
> - **Let's walk through the example from the payload perspective:**
> - **A modifier can be both a parent and child:**
>   - Item_uuid2 is modifier and child of parent_item_uuid

* Parent - Child

```json
        {
            "uuid": "{{parent_item_uuid}}",
            "item_id": {{parent_item_id}},
            "quantity": 2
        },
        {
            "uuid": "{{item_uuid2}}",
            "item_id": {{item_id2}},
            "quantity": 2,
            "item_as_modifier": {
                "parent_uuid": "{{parent_item_uuid}}",
                "item_set_uuid": "{{item_set_uuid1}}"
            }
        },
```

* Parent

```json 
        {
            "uuid": "{{parent_item_uuid}}",
            "item_id": {{parent_item_id}},
            "quantity": 2
        },
```

* Child

```json
        {
            "uuid": "{{item_uuid2}}",
            "item_id": {{item_id2}},
            "quantity": 2,
            "item_as_modifier": {
                "parent_uuid": "{{parent_item_uuid}}",
                "item_set_uuid": "{{item_set_uuid1}}"
            }
        },
```

> 📘 Nested Modifier Payload - Part 2
> 
> - Now that you've seen how item_uuid2 is a modifier and child of parent_item_uuid, we can now look at how Item_uuid2 is also the parent of item_uuid3
> - **A modifier can be both a parent and child:**
>   - Item_uuid2 is also the parent of item_uuid3

* Part 2

```json
        {
            "uuid": "{{item_uuid2}}",
            "item_id": {{item_id2}},
            "quantity": 2,
            "item_as_modifier": {
                "parent_uuid": "{{parent_item_uuid}}",
                "item_set_uuid": "{{item_set_uuid1}}"
            }
        },
        {
            "uuid": "{{item_uuid3}}",
            "item_id": {{item_id3}},
            "quantity": 3,
            "item_as_modifier": {
                "parent_uuid": "{{item_uuid2}}",
                "item_set_uuid": "{{item_set_uuid2}}"
            }
        },
```

* Parent

```json
        {
            "uuid": "{{item_uuid2}}",
            "item_id": {{item_id2}},
            "quantity": 2,
            "item_as_modifier": {
                "parent_uuid": "{{parent_item_uuid}}",
                "item_set_uuid": "{{item_set_uuid1}}"
            }
        },
```

* Child

```json
        {
            "uuid": "{{item_uuid3}}",
            "item_id": {{item_id3}},
            "quantity": 3,
            "item_as_modifier": {
                "parent_uuid": "{{item_uuid2}}",
                "item_set_uuid": "{{item_set_uuid2}}"
            }
        },
```

**Full Payload**

* Example

```json
{
    "external_id": "1",
    "seat_id": 0,
    "metadata": "Nested Modifiers",
    "items": [
        {
            "uuid": "{{parent_item_uuid}}",
            "item_id": {{parent_item_id}},
            "quantity": 2
        },
        {
            "uuid": "{{item_uuid2}}",
            "item_id": {{item_id2}},
            "quantity": 2,
            "item_as_modifier": {
                "parent_uuid": "{{parent_item_uuid}}",
                "item_set_uuid": "{{item_set_uuid1}}"
            }
        },
        {
            "uuid": "{{item_uuid3}}",
            "item_id": {{item_id3}},
            "quantity": 3,
            "item_as_modifier": {
                "parent_uuid": "{{item_uuid2}}",
                "item_set_uuid": "{{item_set_uuid2}}"
            }
        },
        {
            "uuid": "{{item_uuid4}}",
            "item_id": {{item_id4}},
            "quantity": 3,
            "item_as_modifier": {
                "parent_uuid": "{{item_uuid3}}",
                "item_set_uuid": "{{item_set_uuid3}}"
            }
        },
        {
            "uuid": "{{item_uuid5}}",
            "item_id": {{item_id5}},
            "quantity": 3,
            "item_as_modifier": {
                "parent_uuid": "{{item_uuid4}}",
                "item_set_uuid": "{{item_set_uuid4}}"
            }
        }
    ]
}
```
