---
title: "CheckMgmt - YAML Files"
permalink: /page/checkmgmt-yaml-files
published: true
layout: default
createdAt: "2023-06-02T14:59:15.746Z"
updatedAt: "2023-09-11T14:22:08.143Z"
---
{: .important-title }
> Check Mgmt YAML
>
> The YAML is evolving and you will see extra fields and endpoints that we haven’t discussed, ignore them for now.
> * 7/17/2023: Milestone 5: Calculate on an Order
> * 7/17/2023: Milestone 4: Add and Delete Discount from an Order
> * 5/19/2023: Milestone 3: Add, Edit, Delete Item from an Order
> * 5/08/2023: Milestone 2: Create, Edit, Get, and List Order


{% tabs checkmanagement %}

{% tab checkmanagement M4+M5 %}
```yaml
openapi: 3.0.0
info:
  contact: {}
  description: >-
    The Orders API provides functionality to manage and handle orders in
    progress within the context of the CheckManagement project. It enables
    operations such as placing new orders, updating order details, retrieving
    order information, and performing order-related actions. For access and
    authentication, please refer to the CheckManagement documentation.
  title: Orders API V3
  version: 1.0.0
servers: []
paths:
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders':
    get:
      parameters:
        - description: The corporate ID
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The venue ID
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The vendor ID
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Example: 2022-02-22T14:38:25Z


            Query filter. From what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: start_date
          required: true
          schema:
            type: string
        - description: >-
            Example: 2022-03-22T14:38:25Z


            Query filter. Up to what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: end_date
          required: true
          schema:
            type: string
        - description: 'How many orders should each page list, max 500'
          in: query
          name: per_page
          required: false
          schema:
            default: '100'
            format: int64
            type: integer
        - description: What page of the entire list is going to be returned
          in: query
          name: page
          required: false
          schema:
            default: '1'
            format: int64
            type: integer
        - description: >-
            Query filter. Orders on what statuses are going to be retrieved.
            Allowed values are open, completed, cancelled, pending-checkout
          explode: true
          in: query
          name: status
          required: false
          schema:
            items:
              enum:
                - COMPLETED
                - CANCELLED
                - OPEN
              type: string
            type: array
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3ListOrdersResponse'
          description: The orders were successfully retrieved
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid venue id
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: >-
        Retrieves all orders the user has access to, within a specified date and
        time range.
      operationId: OrdersV3Service_ListOrders
      summary: List Orders
    post:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
      responses:
        '201':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3CreateOrderResponse'
          description: The order was successfully created
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: Creates a new order and returns a uuid to reference in future calls.
      operationId: OrdersV3Service_CreateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3Order'
              required:
                - order
        required: true
      summary: Create Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteDiscountResponse'
          description: >-
            The order was successfully cancelled out and now it is in completed
            state
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: Cancel process TBD
      operationId: OrdersV3Service_Cancel
      summary: Cancel an order
    get:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3GetOrderResponse'
          description: The order was retrieved
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: Retrieves an order by its UUID
      operationId: OrdersV3Service_GetOrder
      summary: Get Order
    patch:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - in: query
          name: field_mask
          required: false
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3UpdateOrderResponse'
          description: The order was successfully updated
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: >-
        Allows the modification of a specific set of properties of the order. 

        Properties that are accepted in this endpoint are being named as
        `order_metadata`.
      operationId: OrdersV3Service_UpdateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3OrderMetadata'
              required:
                - order_metadata
        required: true
      summary: Update Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/calculate':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3CalculateResponse'
          description: The order was calculated
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid parameter order uuid.
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: >-
        Run the calculation process for the order and return all the relevant
        information related to the order. Additionally, store the last
        calculation of the order so the user can query the order details without
        needing to run the calculate function again.

        A flag indicating whether the order needs to be recalculated will be set
        to false after running this process.

        An order needs to be calculated before proceeding to the submit to
        kitchen, add payment or checkout processes. Submitting to the kitchen
        and adding payments do not alter the state of the "needs to be
        recalculated" flag.
      operationId: OrdersV3Service_Calculate
      summary: Calculate an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/checkout':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteDiscountResponse'
          description: The order was successfully completed by checkout process
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      security:
        - ConnectApiKey: []
      tags:
        - All Check Management endpoints
        - Order level endpoints
      description: >-
        Checkout process TBD

        This endpoint requires a connect api key, it must be sent in a custom
        header called "Connect-API-Key"
      operationId: OrdersV3Service_Checkout
      summary: Checkout an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/discounts':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddDiscountsResponse'
          description: >-
            The all discounts ref-tags are added to the order and pending to be
            applied
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: 'codes not found [1,2,3]'
          description: >-
            The at least one of the code was not found in the system (you need
            to add it in connect before).
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order discounts endpoints
      description: >-
        Adds one or more discounts to a given order, the discounts included in
        this request comes in the format of ref-tags configured in connect. This
        endpoint accepts a list of discounts to be applied later during the
        calculation, which means this endpoint only validates if the given
        discount exists in the system (created in Connect) but not if the items
        or order meets the criteria to apply the discount.
      operationId: OrdersV3Service_AddDiscounts
      requestBody:
        content:
          application/json:
            schema:
              description: >-
                Represents the request of add discounts to be applied to order
                during calculate
              properties:
                ref_tags:
                  description: The array of ref tags used to identify the reductions
                  items:
                    type: string
                  type: array
              required:
                - ref_tags
              title: AddDiscountsRequest
              type: object
        required: true
      summary: Add Discounts to an order to be applied during the calculation
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/discounts/{code}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The code of the discount to be deleted
          in: path
          name: code
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteDiscountResponse'
          description: The discount was successfully deleted from the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: discount not found in the order
          description: The discount was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order discounts endpoints
      description: >-
        Deletes a manual discount from the existing order, the discount to be
        deleted can be either item level or order level.

        This endpoint will delete all discounts matching the given code
      operationId: OrdersV3Service_DeleteDiscount
      summary: Delete discounts from an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddItemsResponse'
          description: >-
            The items were successfully included to the order, if a single item
            in the request fails the whole request fail, and the order will
            remain untouch
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order items endpoints
      description: >-
        Adds an array of items to an existing order, if the order already has
        items this endpoint merges the new items into the existing ones and run
        the validation one more time. So no nested loops are allowed in the
        items.
      operationId: OrdersV3Service_AddItems
      requestBody:
        content:
          application/json:
            schema:
              description: Represents the request of add items to order endpoint
              properties:
                items:
                  description: Array of items to be included in the order
                  items:
                    $ref: '#/components/schemas/v3OrderItem'
                  type: array
              required:
                - items
              title: AddItemsRequest
              type: object
        required: true
      summary: Add Items to an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items/{item_uuid}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The UUID of the item to be deleted
          in: path
          name: item_uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteItemResponse'
          description: The item was successfully deleted from the order
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: item not found in the order
          description: The item was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order items endpoints
      description: >-
        Deletes an item from an existing order, if the item has modifiers all of
        them will be deleted (no matters how many it has)
      operationId: OrdersV3Service_DeleteItem
      summary: Delete Item from an order
    patch:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The UUID of the item to be deleted
          in: path
          name: item_uuid
          required: true
          schema:
            type: string
        - description: The list of the fields to be updated
          in: query
          name: field_mask
          required: false
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3UpdateItemResponse'
          description: The item was successfully updated in the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: item not found in the order
          description: The item was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order items endpoints
      description: >-
        Updates an item from an existing order, item parent cannot be changed,
        to do that, you need to delete the item and re-add it.
      operationId: OrdersV3Service_UpdateItem
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3ItemMetadata'
              description: The metadata to be updated in the order
              required:
                - item_metadata
        required: true
      summary: Update Item from an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/payments':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '201':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddPaymentsResponse'
          description: All paymentes were added succesfully
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid parameter order uuid.
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order payments endpoints
      description: >-
        This API endpoint allows adding payments to an existing order. It is
        used to associate one or more payments with a specific order.
      operationId: OrdersV3Service_AddPayments
      requestBody:
        content:
          application/json:
            schema:
              description: Represents the request for adding payments endpoint
              properties:
                payments:
                  description: Array of payments objects
                  items:
                    $ref: '#/components/schemas/v3Payment'
                  type: array
              required:
                - payments
              title: AddPaymentsRequest
              type: object
        required: true
      summary: AddPayments to an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/payments/{payment_uuid}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: >-
            Unique identifier of the payment in the order, after the deletion
            this uuid cannot be re-used due to internal restrictions because the
            deleted payments will be remain stored but hidden from the user
          in: path
          name: payment_uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeletePaymentResponse'
          description: The payment was successfully deleted from the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request is not valid.
          description: >-
            There is an error with the request please review the format of the
            query parameters or additional headers you are sending
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: payment not found in the order
          description: The payment was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order payments endpoints
      description: Deletes a single payment from an existing order
      operationId: OrdersV3Service_DeletePayment
      summary: Delete Payment from an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/submit':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3SubmitToKitchenResponse'
          description: All items in the order were successfully submitted to the kitchen
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid request parameters
          description: The request is invalid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '409':
          content:
            application/json:
              schema:
                example:
                  code: 409
                  message: calculate has not been run
          description: The order has not been calculated.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - All Check Management endpoints
        - Order kitchen endpoints
      description: |-
        Submits all items inside an order to the kitchen
        Items that were sent to the kitchen can no longer be updated or deleted
      operationId: OrdersV3Service_SubmitToKitchen
      summary: Submit order to the kitchen
components:
  schemas:
    v3AddDiscountsResponse:
      description: Represents the response to add disconts to an order
      title: AddDiscountsResponse
      type: object
    v3AddItemsResponse:
      description: Represents of add items to an order endpoint response
      title: AddItemsResponse
      type: object
    v3AddPaymentsResponse:
      description: Represents the response of adding payments endpoint
      title: AddPaymentsResponse
      type: object
    v3CalculateResponse:
      description: Calculate endpoint response
      properties:
        calculations:
          allOf:
            - $ref: '#/components/schemas/v3OrderCalculations'
          description: >-
            Calculation object with all relevant information from the calculate
            process
        items:
          description: >-
            Array of items included in the order. This array is included as part
            of the calculate order response because the calculate endpoint can
            modify the items in the order in different scenarios. For example,
            when applying automatic or manual discounts that combine items, or
            when implementing buy one and get one discounts.
          items:
            $ref: '#/components/schemas/v3OrderItem'
          type: array
      title: CalculateResponse
      type: object
    v3CancelResponse:
      description: Represents the response of cancel order operation
      title: CancelResponse
      type: object
    v3CheckoutResponse:
      description: >-
        Represents the response of checkout process, this includes information
        from Connect
      title: CheckoutResponse
      type: object
    v3CreateOrderResponse:
      description: Represents the response of create order endpoint
      properties:
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      title: CreateOrderResponse
      type: object
    v3DeleteDiscountResponse:
      description: Discount was successfully deleted
      title: DeleteDiscountResponse
      type: object
    v3DeleteItemResponse:
      description: Items were successfully deleted
      title: DeleteItemResponse
      type: object
    v3DeletePaymentResponse:
      description: Represents the response of deleting a payment
      title: DeletePaymentResponse
      type: object
    v3GetOrderResponse:
      description: 'Represents of get order endpoint, contains the order information'
      properties:
        order:
          allOf:
            - $ref: '#/components/schemas/v3Order'
          description: Represents a full order
          readOnly: true
      title: GetOrderResponse
      type: object
    v3Integrations:
      description: >-
        Object with all relevant fields required for integration with external
        systems
      properties:
        qsra_check_number:
          description: >-
            Contains a check number identifier for the order required by QSRA
            integration. The value of this field is computed based on vendor id
            and order uuid.
          format: uint64
          readOnly: true
          type: string
      title: Integrations
      type: object
    v3ItemAsModifier:
      description: Enables an item to behave as modifier
      properties:
        item_set_uuid:
          description: >-
            The item set id. The given item set will be used only if the item
            belongs to that item set, and that item set is configured in it's
            parent, otherwise, this value will be ignored.
          example: 61f8454e6622f7327e4b1366
          type: string
        parent_uuid:
          description: >-
            This field identifies the uuid of the item that the modifier applies
            to, this field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      required:
        - parent_uuid
        - item_set_uuid
      title: ItemAsModifier
      type: object
    v3ItemMetadata:
      properties:
        notes:
          description: Special instructions for the item
          type: string
        price_override:
          format: float
          type: number
        quantity:
          format: int32
          type: integer
      title: ItemMetadata
      type: object
    v3ListOrdersResponse:
      properties:
        orders:
          description: Returned orders
          items:
            $ref: '#/components/schemas/v3OrderInfo'
          type: array
        pagination:
          allOf:
            - $ref: '#/components/schemas/v3Pagination'
          description: Pagination object
      title: ListOrdersResponse
      type: object
    v3Order:
      description: >-
        This object represents an order in a restaurant or food service setting,
        which contains details like external_id, allow_override, seat_id,
        metadata and items that are part of the order, and each item has details
        like uuid, item_id, quantity and related modifiers details.
      properties:
        applied_discounts:
          allOf:
            - $ref: '#/components/schemas/v3OrderDiscounts'
          description: Discounts added to the order and are already applied
          readOnly: true
        charity_rounding_enabled:
          description: >-
            Optional flag indicating whether charity rounding is enabled for
            this order. If it is not provided, charity rounding defaults to
            false for the order. When it is provided and set to true, OrdersV3
            will calculate the cents needed to round up to the next whole dollar
            and the cents will be donated to charity. The charity rounding
            calculation will only run if the venue has configured in Connect. If
            the Connect setting is not enabled and the user tries to set this
            flag as true, the order creation or update will be rejected.
          type: boolean
        corporate_id:
          description: Corporate ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
        created_date:
          description: Date when the order was originally submitted
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            External identifer, used as discresion of the API user, the API does
            not verify the uniqueness of this field. Maximum length 64
            characters
          example: this is any string up 64 characters
          type: string
        integrations:
          allOf:
            - $ref: '#/components/schemas/v3Integrations'
          description: >-
            Object with all relevant fields required for integration with
            external systems
          readOnly: true
        items:
          description: Array of items included or to be included in the order
          items:
            $ref: '#/components/schemas/v3OrderItem'
          type: array
        metadata:
          description: >-
            Used as discresion of the API user, it stores string with maximum
            length of 1024 characters
          type: string
        needs_to_be_recalculated:
          description: >-
            Flag indicating if the order needs to be recalculated. This flag is
            used to indicate whether the order calculations are invalid and need
            to be recalculated. If the flag is set to true, it means that
            certain operations or modifications have occurred in the order that
            may have affected the calculations. In such cases, the order should
            be recalculated before proceeding with further actions or retrieving
            updated details.
          readOnly: true
          type: boolean
        order_totals:
          allOf:
            - $ref: '#/components/schemas/v3OrderTotals'
          description: >-
            Represents the cumulative amounts calculated for various functions
            within the calculate process. These totals include subtotals,
            discounts, taxes, and any other relevant calculations related to the
            items in the cart. The cart totals provide an overview of the
            financial aspects of the order. It's important to note that If the
            'needs_to_be_recalculated' flag is set to true, the cart totals may
            be invalid or outdated. In such cases, it is recommended to
            recalculate the order to ensure accurate and up-to-date cart totals
            before relying on them for further processing or displaying to the
            user.
          readOnly: true
        payment_information:
          allOf:
            - $ref: '#/components/schemas/v3PaymentInformation'
          description: >-
            Object with the payment information including an array with all
            payments
        pending_discounts:
          allOf:
            - $ref: '#/components/schemas/v3OrderDiscounts'
          description: >-
            Discounts added to the order, but are currently not applied (needs
            calculation or does not meet criteria)
          readOnly: true
        seat_id:
          description: >-
            Identifier of the seat where the customer is located, this is
            configured in Connect and it is part of API call to Checkout
          format: int64
          type: integer
        status:
          allOf:
            - $ref: '#/components/schemas/v3OrderStatus'
          description: Current status of the order
          readOnly: true
        updated_date:
          description: Date recording the last modification of the order
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints. This field is RFC 4122
            complaint in string representation
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
        vendor_id:
          description: Vendor ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
        venue_id:
          description: Venue ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
      required:
        - external_id
        - payment_information
      title: Order
      type: object
    v3OrderCalculations:
      description: >-
        This object is returned by the Calculate endpoint and is also included
        in the Get order details response. Depending on the calls made to
        endpoints that modify the order, this object may enter an invalid state,
        which is indicated by the needs to be recalculated flag.
      properties:
        applied_discount_codes:
          description: Discounts added to the order and are already applied
          items:
            type: string
          readOnly: true
          type: array
        order_totals:
          allOf:
            - $ref: '#/components/schemas/v3OrderTotals'
          description: >-
            Represents the cumulative amounts calculated for various functions
            within the calculate process. These totals include subtotals,
            discounts, taxes, and any other relevant calculations related to the
            items in the cart. The cart totals provide an overview of the
            financial aspects of the order. It's important to note that If the
            'needs_to_be_recalculated' flag is set to true, the cart totals may
            be invalid or outdated. In such cases, it is recommended to
            recalculate the order to ensure accurate and up-to-date cart totals
            before relying on them for further processing or displaying to the
            user.
          readOnly: true
        pending_discount_codes:
          description: >-
            Discounts added to the order, but are currently not applied (needs
            calculation or does not meet criteria)
          items:
            type: string
          readOnly: true
          type: array
      title: OrderCalculations
      type: object
    v3OrderDiscounts:
      description: Represents discounts by code or reftag in an order
      properties:
        reftags:
          description: Discounts added by reftag to the order
          items:
            type: string
          readOnly: true
          type: array
      title: Order Discounts
      type: object
    v3OrderInfo:
      properties:
        created_date:
          description: Date the order was created on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            Order identifier, not internal but from the client who originated
            the order.
          example: any-string-up-to-64-characters
          type: string
        status:
          allOf:
            - $ref: '#/components/schemas/v3OrderStatus'
          description: 'The status of the order, can be ''open'', ''pending-close'' or ''closed'''
          readOnly: true
        updated_date:
          description: Date the order was last updated on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      title: OrderInfo
      type: object
    v3OrderItem:
      description: Represents a unique item included or to be included in an order
      properties:
        item_as_modifier:
          allOf:
            - $ref: '#/components/schemas/v3ItemAsModifier'
          description: >-
            This object is used to indicate the current item is a modifier and
            it needs to be applied to given item
        item_id:
          description: >-
            The item identifier, provided by the Connect service, is used to
            reference the item in the menu endpoint. A single order may include
            multiple instances of the same item, each with its own distinct
            properties
          format: int64
          type: integer
        name:
          description: >-
            Name of the given item identified by item_id, this value can be set
            in Connect
          readOnly: true
          type: string
        notes:
          description: Special instructions for the item
          type: string
        price:
          description: >-
            The item's actual price, be it the original or the overriden price.
            Output only.
          format: float
          readOnly: true
          type: number
        price_override:
          description: >-
            The item override price, this will replace the real price if
            'allow_price_override' is true
          format: float
          type: number
        quantity:
          description: Desired amount of items in the order
          format: int32
          type: integer
        user_specified_price:
          description: 'True if the item''s price has been overriden, false otherwise.'
          readOnly: true
          type: boolean
        uuid:
          description: >-
            Identifies an instance of an item in the order, internally generated
            or accepted as part of the  endpoint request body and unique to each
            order. This field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      required:
        - item_id
        - quantity
      title: OrderItem
      type: object
    v3OrderMetadata:
      properties:
        charity_rounding_enabled:
          description: >-
            Optional flag indicating whether charity rounding is enabled for
            this order. If it is not provided, charity rounding defaults to
            false for the order. When it is provided and set to true, OrdersV3
            will calculate the cents needed to round up to the next whole dollar
            and the cents will be donated to charity. The charity rounding
            calculation will only run if the venue has configured in Connect. If
            the Connect setting is not enabled and the user tries to set this
            flag as true, the order creation or update will be rejected.
          type: boolean
        metadata:
          description: >-
            Used as discresion of the API user, it stores string with maximum
            length of 1024 characters
          type: string
        seat_id:
          description: >-
            Identifier of the seat where the customer is located, this is
            configured in Connect and it is part of API call to Checkout
          format: int64
          type: integer
      title: OrderMetadata
      type: object
    v3OrderStatus:
      enum:
        - COMPLETED
        - CANCELLED
        - OPEN
      type: string
    v3OrderTotals:
      description: >-
        Represents the cumulative amounts calculated for various functions
        within the calculate process. These totals include subtotals, discounts,
        taxes, and any other relevant calculations related to the items in the
        cart. The cart totals provide an overview of the financial aspects of
        the order.
      properties:
        charity_total:
          description: >-
            Total amount of money accumulated for charity purposes in the order.
            This value represents the sum of all the rounded cents that are
            designated for donation to a charity. It is calculated as part of
            the order's overall financial calculations and is provided as an
            output. This field is optional and will only be present if the
            `CharityRoundingEnable` flag was set to true during the order
            creation, including zero (0) as a valid value if the
            `CharityRoundingEnable` flag was set.
          format: float
          readOnly: true
          type: number
        discounts_total:
          description: >-
            Contains the accumulated discounts applied to items in the order.
            This value is always represented as a negative value to indicate the
            reduction in the total cost due to discounts. The discounts_total
            provides an overall view of the total discount amount applied to the
            order. It's important to note that the discounts_total represents
            the cumulative discounts at a given point in time. If the
            'needs_to_be_recalculated' flag is set to true, the discounts_total
            may not reflect the most recent calculations or modifications to the
            order. To ensure accurate and up-to-date discount information, it is
            recommended to recalculate the order before relying on the
            discounts_total for further processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        exclusive_tax:
          description: >-
            Contains the accumulated exclusive taxes for items and modifiers. To
            ensure accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        fees_total:
          description: >-
            Represents the cumulative fees associated with the order. These fees
            may include additional charges, such as delivery fees, service fees,
            or any other applicable fees. The fees_total provides an overview of
            the total fees incurred for the order. It's important to note that
            the fees_total represents the cumulative fees at a given point in
            time. If the 'needs_to_be_recalculated' flag is set to True, the
            fees_total may not reflect the most recent calculations or
            modifications to the order. To ensure accurate and up-to-date fee
            information, it is recommended to recalculate the order before
            relying on the fees_total for further processing or displaying to
            the user.
          format: float
          readOnly: true
          type: number
        inclusive_tax:
          description: >-
            Contains the accumulated inclusive taxes for items and modifiers. To
            ensure accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        original_total:
          description: >-
            Represents the original cost of items and modifiers without applied
            taxes, discounts, or any other price modifications. To ensure
            accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        subtotal:
          description: >-
            Represents the cost of items and modifiers, including inclusive
            taxes, reduced by any item-level reductions. This amount reflects
            the total cost before applying taxes, discounts, or any other price
            modifications. To ensure accurate and up-to-date fee information, it
            is recommended to recalculate the order before relying on the
            fees_total for further processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        total:
          description: >-
            The final amount for the order. It is calculated by taking the
            subtotal, reducing it by cart-level reductions, and then adding the
            exclusive taxes and fees. To ensure accurate and up-to-date fee
            information, it is recommended to recalculate the order before
            relying on the fees_total for further processing or displaying to
            the user.
          format: float
          readOnly: true
          type: number
      title: OrderTotals
      type: object
    v3Pagination:
      properties:
        page:
          format: int64
          type: integer
        per_page:
          format: int64
          type: integer
        total_pages:
          format: int64
          type: integer
        total_results:
          format: int64
          type: integer
      title: Pagination
      type: object
    v3Payment:
      description: Represents a payment in the system
      properties:
        external_id:
          description: User specified id up to 64 characters
          readOnly: true
          type: string
        payment_type:
          allOf:
            - $ref: '#/components/schemas/v3PaymentType'
          description: >-
            Payment type defines the type of the object to use as value, only
            one of the following objects can be set at the time.
        payment_value:
          allOf:
            - $ref: '#/components/schemas/v3PaymentValue'
          description: >-
            Payment value, it is a polimorphic object based on payment_type
            field, only one element of the fields can be used at the time.
        uuid:
          description: The UUID field of the payment generated by the API internally
          readOnly: true
          type: string
      required:
        - payment_type
        - payment_value
      title: Payment
      type: object
    v3PaymentInformation:
      description: Represents the information about payments
      properties:
        amount:
          description: Amount of the total of payments in the order
          format: float
          readOnly: true
          type: number
        payments:
          description: Array of payments objects
          items:
            $ref: '#/components/schemas/v3Payment'
          type: array
      required:
        - payments
      title: Payment Information
      type: object
    v3PaymentType:
      enum:
        - PAYMENT_V1
      type: string
    v3PaymentValue:
      properties:
        V1_payment:
          allOf:
            - $ref: '#/components/schemas/v3V1Payment'
          description: Legacy opai payment payload.
      title: PaymentValue
      type: object
    v3SubmitToKitchenResponse:
      description: Items were successfully sent to the kitchen
      title: SubmitToKitchenResponse
      type: object
    v3UpdateItemResponse:
      description: Item was successfully updated
      title: UpdateItemResponse
      type: object
    v3UpdateOrderResponse:
      description: Order was successfully updated
      title: UpdateOrderResponse
      type: object
    v3V1Credential:
      properties:
        card_encryption:
          type: string
        card_number:
          type: string
        card_pin:
          type: string
        email:
          type: string
        name:
          type: string
        phone:
          type: string
        room_number:
          type: string
      title: V1Credential
      type: object
    v3V1ExternalData:
      properties:
        auth_amount:
          type: string
        auth_code:
          type: string
        auth_currency:
          type: string
        auth_status_code:
          type: string
        balance:
          type: string
        capture_method:
          type: string
        card_art_cmid:
          type: string
        card_class:
          type: string
        card_status_code:
          type: string
        card_token:
          type: string
        card_type:
          type: string
        confirmation_code:
          format: int64
          type: string
        device_transaction_id:
          type: string
        entitlement_id:
          type: string
        entitlement_type:
          type: string
        expiration_date:
          type: string
        invoice_number:
          type: string
        issuer_name:
          type: string
        masked_acc:
          type: string
        payment_gateway:
          type: string
        payment_partner_data:
          $ref: '#/components/schemas/v3V1PaymentPartnerData'
        receipt_identifier:
          $ref: '#/components/schemas/v3V1ReceiptIdentifier'
        req_amount:
          type: string
        req_currency:
          type: string
        transaction_identifier:
          $ref: '#/components/schemas/v3V1TransactionIdentifier'
        transaction_type:
          type: string
        transaction_uid:
          type: string
      title: V1ExternalData
      type: object
    v3V1Payment:
      description: >-
        This object is the first version of the payment payload, the fields here
        may match any other API specs but it is a complete new implementation.
      properties:
        additional_data:
          type: string
        amount:
          format: float
          type: number
        amount_tendered:
          format: float
          type: number
        authorization_code:
          type: string
        card_encoded:
          type: boolean
        card_number:
          type: string
        card_status:
          type: string
        card_type:
          type: string
        cardholder_fullname:
          type: string
        cardholder_name:
          type: string
        change:
          format: float
          type: number
        code_map:
          format: int32
          type: integer
        custom_tender_id:
          type: string
        encryption_type:
          type: string
        exp_date:
          type: string
        external_data:
          $ref: '#/components/schemas/v3V1ExternalData'
        fee:
          format: float
          type: number
        gateway_response_data:
          type: string
        payment_identifier_for_display:
          type: string
        payment_index:
          format: int32
          type: integer
        payment_status:
          type: string
        payment_type:
          format: int32
          type: integer
        payment_uuid:
          type: string
        payment_valid:
          type: boolean
        ppi_loyalty_id:
          type: string
        ppi_pin:
          type: string
        refunded:
          type: boolean
        remaining_balance:
          format: float
          type: number
        subpayment_type:
          format: int32
          type: integer
        subtotal_amount:
          format: float
          type: number
        tender_name:
          type: string
        tip:
          format: float
          type: number
        token_value:
          type: string
      title: V1Payment
      type: object
    v3V1PaymentPartnerData:
      properties:
        credential:
          $ref: '#/components/schemas/v3V1Credential'
        payment_data:
          type: string
        provider:
          type: string
        transaction_uid:
          type: string
      title: V1PaymentPartnerData
      type: object
    v3V1ReceiptIdentifier:
      properties:
        authorization_code:
          type: string
      title: V1ReceiptIdentifier
      type: object
    v3V1TransactionIdentifier:
      properties:
        account_token:
          type: string
        authorization_code:
          type: string
        current_total_amount:
          format: float
          type: number
        expiration_date:
          type: string
        local_request_id:
          type: string
        merchant_reference_code:
          type: string
        original_transaction_type:
          $ref: '#/components/schemas/v3V1TransactionType'
        remote_request_id:
          type: string
      title: V1TransactionIdentifier
      type: object
    v3V1TransactionType:
      enum:
        - VOID
        - REFUND
        - AUTHORIZE
        - ADJUSTMENT
        - CAPTURE
      type: string
  securitySchemes:
    ConnectApiKey:
      description: API key provided by connect. Only used for checkout endpoint
      in: header
      name: Connect-API-Key
      type: apiKey
    bearer:
      description: 'Authentication token, prefixed by Bearer: Bearer <token>'
      in: header
      name: Authorization
      type: apiKey
security:
  - bearer: []
  - ConnectApiKey: []

```
{% endtab %}

{% tab checkmanagement M3 %}
```yaml
openapi: 3.0.0
info:
  contact: {}
  description: >-
    The Orders API provides functionality to manage and handle orders in
    progress within the context of the CheckManagement project. It enables
    operations such as placing new orders, updating order details, retrieving
    order information, and performing order-related actions. For access and
    authentication, please refer to the CheckManagement documentation.
  title: Orders API V3
  version: 1.0.0
servers: []
paths:
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders':
    get:
      parameters:
        - description: The corporate ID
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The venue ID
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The vendor ID
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Example: 2022-02-22T14:38:25Z


            Query filter. From what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: start_date
          required: true
          schema:
            type: string
        - description: >-
            Example: 2022-03-22T14:38:25Z


            Query filter. Up to what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: end_date
          required: true
          schema:
            type: string
        - description: 'How many orders should each page list, max 500'
          in: query
          name: per_page
          required: false
          schema:
            default: '100'
            format: int64
            type: integer
        - description: What page of the entire list is going to be returned
          in: query
          name: page
          required: false
          schema:
            default: '1'
            format: int64
            type: integer
        - description: >-
            Query filter. Orders on what statuses are going to be retrieved.
            Allowed values are open, completed, cancelled, pending-checkout
          explode: true
          in: query
          name: status
          required: false
          schema:
            items:
              enum:
                - COMPLETED
                - CANCELLED
                - OPEN
              type: string
            type: array
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3ListOrdersResponse'
          description: The orders were successfully retrieved
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid venue id
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Retrieves all orders the user has access to, within a specified date and
        time range.
      operationId: OrdersV3Service_ListOrders
      summary: List Orders
    post:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
      responses:
        '201':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3CreateOrderResponse'
          description: The order was successfully created
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Creates a new order and returns a uuid to reference in future calls.
      operationId: OrdersV3Service_CreateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3Order'
              required:
                - order
        required: true
      summary: Create Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}':
    get:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3GetOrderResponse'
          description: The order was retrieved
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Retrieves an order by its UUID
      operationId: OrdersV3Service_GetOrder
      summary: Get Order
    patch:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - in: query
          name: field_mask
          required: false
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3UpdateOrderResponse'
          description: The order was successfully updated
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Allows the modification of a specific set of properties of the order. 

        Properties that are accepted in this endpoint are being named as
        `order_metadata`.
      operationId: OrdersV3Service_UpdateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3OrderMetadata'
              required:
                - order_metadata
        required: true
      summary: Update Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/calculate':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3CalculateResponse'
          description: The order was calculated
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid parameter order uuid.
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Run the calculation process for the order and return all the relevant
        information related to the order. Additionally, store the last
        calculation of the order so the user can query the order details without
        needing to run the calculate function again.

        A flag indicating whether the order needs to be recalculated will be set
        to false after running this process.

        An order needs to be calculated before proceeding to the submit to
        kitchen, add payment or checkout processes. Submitting to the kitchen
        and adding payments do not alter the state of the "needs to be
        recalculated" flag.
      operationId: OrdersV3Service_Calculate
      summary: Calculate an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/discounts':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddDiscountsResponse'
          description: >-
            The all discounts ref-tags are added to the order and pending to be
            applied
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: 'codes not found [1,2,3]'
          description: >-
            The at least one of the code was not found in the system (you need
            to add it in connect before).
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Adds one or more discounts to a given order, the discounts included in
        this request comes in the format of ref-tags configured in connect. This
        endpoint accepts a list of discounts to be applied later during the
        calculation, which means this endpoint only validates if the given
        discount exists in the system (created in Connect) but not if the items
        or order meets the criteria to apply the discount.
      operationId: OrdersV3Service_AddDiscounts
      requestBody:
        content:
          application/json:
            schema:
              description: >-
                Represents the request of add discounts to be applied to order
                during calculate
              properties:
                ref_tags:
                  description: The array of ref tags used to identify the reductions
                  items:
                    type: string
                  type: array
              required:
                - ref_tags
              title: AddDiscountsRequest
              type: object
        required: true
      summary: Add Discounts to an order to be applied during the calculation
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/discounts/{code}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The code of the discount to be deleted
          in: path
          name: code
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteDiscountResponse'
          description: The discount was successfully deleted from the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: discount not found in the order
          description: The discount was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Deletes a manual discount from the existing order, the discount to be
        deleted can be either item level or order level.

        This endpoint will delete all discounts matching the given code
      operationId: OrdersV3Service_DeleteDiscount
      summary: Delete discounts from an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddItemsResponse'
          description: >-
            The items were successfully included to the order, if a single item
            in the request fails the whole request fail, and the order will
            remain untouch
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Adds an array of items to an existing order, if the order already has
        items this endpoint merges the new items into the existing ones and run
        the validation one more time. So no nested loops are allowed in the
        items.
      operationId: OrdersV3Service_AddItems
      requestBody:
        content:
          application/json:
            schema:
              description: Represents the request of add items to order endpoint
              properties:
                items:
                  description: Array of items to be included in the order
                  items:
                    $ref: '#/components/schemas/v3OrderItem'
                  type: array
              required:
                - items
              title: AddItemsRequest
              type: object
        required: true
      summary: Add Items to an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items/{item_uuid}':
    delete:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The UUID of the item to be deleted
          in: path
          name: item_uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteItemResponse'
          description: The item was successfully deleted from the order
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: item not found in the order
          description: The item was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Deletes an item from an existing order, if the item has modifiers all of
        them will be deleted (no matters how many it has)
      operationId: OrdersV3Service_DeleteItem
      summary: Delete Item from an order
    patch:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The UUID of the item to be deleted
          in: path
          name: item_uuid
          required: true
          schema:
            type: string
        - description: The list of the fields to be updated
          in: query
          name: field_mask
          required: false
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3UpdateItemResponse'
          description: The item was successfully updated in the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: The request body is not valid.
          description: The request body is not valid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: item not found in the order
          description: The item was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Updates an item from an existing order, item parent cannot be changed,
        to do that, you need to delete the item and re-add it.
      operationId: OrdersV3Service_UpdateItem
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3ItemMetadata'
              description: The metadata to be updated in the order
              required:
                - item_metadata
        required: true
      summary: Update Item from an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/submit':
    post:
      parameters:
        - description: Corporate ID that identifies where the order is placed
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID that identifies where the order is placed
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID that identifies where the order is placed
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3SubmitToKitchenResponse'
          description: All items in the order were successfully submitted to the kitchen
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid request parameters
          description: The request is invalid.
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order not found
          description: The order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: |-
        Submits all items inside an order to the kitchen
        Items that were sent to the kitchen can no longer be updated or deleted
      operationId: OrdersV3Service_SubmitToKitchen
      summary: Submit order to the kitchen
components:
  schemas:
    v3AddDiscountsResponse:
      type: object
    v3AddItemsResponse:
      description: Represents of add items to an order endpoint response
      title: AddItemsResponse
      type: object
    v3CalculateResponse:
      description: Calculate endpoint response
      properties:
        calculations:
          allOf:
            - $ref: '#/components/schemas/v3OrderCalculations'
          description: >-
            Calculation object with all relevant information from the calculate
            process
        items:
          description: >-
            Array of items included in the order. This array is included as part
            of the calculate order response because the calculate endpoint can
            modify the items in the order in different scenarios. For example,
            when applying automatic or manual discounts that combine items, or
            when implementing buy one and get one discounts.
          items:
            $ref: '#/components/schemas/v3OrderItem'
          type: array
      title: CalculateResponse
      type: object
    v3CreateOrderResponse:
      description: Represents the response of create order endpoint
      properties:
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      title: CreateOrderResponse
      type: object
    v3DeleteDiscountResponse:
      description: Discount was successfully deleted
      title: DeleteDiscountResponse
      type: object
    v3DeleteItemResponse:
      description: Items were successfully deleted
      title: DeleteItemResponse
      type: object
    v3GetOrderResponse:
      description: 'Represents of get order endpoint, contains the order information'
      properties:
        order:
          allOf:
            - $ref: '#/components/schemas/v3Order'
          description: Represents a full order
          readOnly: true
      title: GetOrderResponse
      type: object
    v3ItemAsModifier:
      description: Enables an item to behave as modifier
      properties:
        item_set_uuid:
          description: >-
            The item set id. The given item set will be used only if the item
            belongs to that item set, and that item set is configured in it's
            parent, otherwise, this value will be ignored.
          example: 61f8454e6622f7327e4b1366
          type: string
        parent_uuid:
          description: >-
            This field identifies the uuid of the item that the modifier applies
            to, this field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      required:
        - parent_uuid
        - item_set_uuid
      title: ItemAsModifier
      type: object
    v3ItemMetadata:
      properties:
        notes:
          description: Special instructions for the item
          type: string
        price_override:
          format: float
          type: number
        quantity:
          format: int32
          type: integer
      type: object
    v3ListOrdersResponse:
      properties:
        orders:
          description: Returned orders
          items:
            $ref: '#/components/schemas/v3OrderInfo'
          type: array
        pagination:
          allOf:
            - $ref: '#/components/schemas/v3Pagination'
          description: Pagination object
      type: object
    v3Order:
      description: >-
        This object represents an order in a restaurant or food service setting,
        which contains details like external_id, allow_override, seat_id,
        metadata and items that are part of the order, and each item has details
        like uuid, item_id, quantity and related modifiers details.
      properties:
        applied_discounts:
          allOf:
            - $ref: '#/components/schemas/v3OrderDiscounts'
          description: Discounts added to the order and are already applied
          readOnly: true
        charity_rounding_enable:
          description: >-
            Optional flag indicating whether charity rounding is enabled for
            this order. If it is not provided, charity rounding defaults to
            false for the order. When it is provided and set to true, OrdersV3
            will calculate the cents needed to round up to the next whole dollar
            and the cents will be donated to charity. The charity rounding
            calculation will only run if the venue has configured in Connect. If
            the Connect setting is not enabled and the user tries to set this
            flag as true, the order creation or update will be rejected.
          type: boolean
        corporate_id:
          description: Corporate ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
        created_date:
          description: Date when the order was originally submitted
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            External identifer, used as discresion of the API user, the API does
            not verify the uniqueness of this field. Maximum length 64
            characters
          example: this is any string up 64 characters
          type: string
        items:
          description: Array of items included or to be included in the order
          items:
            $ref: '#/components/schemas/v3OrderItem'
          type: array
        metadata:
          description: >-
            Used as discresion of the API user, it stores string with maximum
            length of 1024 characters
          type: string
        pending_discounts:
          allOf:
            - $ref: '#/components/schemas/v3OrderDiscounts'
          description: >-
            Discounts added to the order, but are currently not applied (needs
            calculation or does not meet criteria)
          readOnly: true
        seat_id:
          description: >-
            Identifier of the seat where the customer is located, this is
            configured in Connect and it is part of API call to Checkout
          format: int64
          type: integer
        status:
          allOf:
            - $ref: '#/components/schemas/v3OrderStatus'
          description: Current status of the order
          readOnly: true
        updated_date:
          description: Date recording the last modification of the order
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints. This field is RFC 4122
            complaint in string representation
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
        vendor_id:
          description: Vendor ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
        venue_id:
          description: Venue ID that identifies where the order is placed
          format: int64
          readOnly: true
          type: integer
      required:
        - external_id
      title: Order
      type: object
    v3OrderCalculations:
      description: >-
        This object is returned by the Calculate endpoint and is also included
        in the Get order details response. Depending on the calls made to
        endpoints that modify the order, this object may enter an invalid state,
        which is indicated by the needs to be recalculated flag.
      example:
        calculations:
          applied_discount_codes:
            - string
          needs_to_be_recalculated: false
          order_totals:
            charity_total: 0
            discounts_total: 0
            exclusive_tax: 0
            fees_total: 0
            inclusive_tax: 0
            original_total: 0
            subtotal: 0
            total: 0
          pending_discount_codes:
            - string
        items:
          item_as_modifier:
            item_set_uuid: 61f8454e6622f7327e4b1366
            parent_uuid: 736b99f8-9113-11ed-a1eb-0242ac120002
          item_id: 0
          notes: string
          price: 0
          price_override: 0
          quantity: 0
          user_specified_price: true
          uuid: 736b99f8-9113-11ed-a1eb-0242ac120002
      properties:
        applied_discount_codes:
          description: Discounts added to the order and are already applied
          items:
            type: string
          readOnly: true
          type: array
        needs_to_be_recalculated:
          description: >-
            Flag indicating if the order needs to be recalculated. This flag is
            used to indicate whether the order calculations are invalid and need
            to be recalculated. If the flag is set to true, it means that
            certain operations or modifications have occurred in the order that
            may have affected the calculations. In such cases, the order should
            be recalculated before proceeding with further actions or retrieving
            updated details.
          readOnly: true
          type: boolean
        order_totals:
          allOf:
            - $ref: '#/components/schemas/v3OrderTotals'
          description: >-
            Represents the cumulative amounts calculated for various functions
            within the calculate process. These totals include subtotals,
            discounts, taxes, and any other relevant calculations related to the
            items in the cart. The cart totals provide an overview of the
            financial aspects of the order. It's important to note that If the
            'needs_to_be_recalculated' flag is set to true, the cart totals may
            be invalid or outdated. In such cases, it is recommended to
            recalculate the order to ensure accurate and up-to-date cart totals
            before relying on them for further processing or displaying to the
            user.
          readOnly: true
        pending_discount_codes:
          description: >-
            Discounts added to the order, but are currently not applied (needs
            calculation or does not meet criteria)
          items:
            type: string
          readOnly: true
          type: array
      title: OrderCalculations
      type: object
    v3OrderDiscounts:
      description: Represents discounts by code or reftag in an order
      properties:
        reftags:
          description: Discounts added by reftag to the order
          items:
            type: string
          readOnly: true
          type: array
      title: OrderDiscounts
      type: object
    v3OrderInfo:
      properties:
        created_date:
          description: Date the order was created on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            Order identifier, not internal but from the client who originated
            the order.
          example: any-string-up-to-64-characters
          type: string
        status:
          allOf:
            - $ref: '#/components/schemas/v3OrderStatus'
          description: 'The status of the order, can be ''open'', ''pending-close'' or ''closed'''
          readOnly: true
        updated_date:
          description: Date the order was last updated on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      type: object
    v3OrderItem:
      description: Represents a unique item included or to be included in an order
      properties:
        item_as_modifier:
          allOf:
            - $ref: '#/components/schemas/v3ItemAsModifier'
          description: >-
            This object is used to indicate the current item is a modifier and
            it needs to be applied to given item
        item_id:
          description: >-
            The item identifier, provided by the Connect service, is used to
            reference the item in the menu endpoint. A single order may include
            multiple instances of the same item, each with its own distinct
            properties
          format: int64
          type: integer
        notes:
          description: Special instructions for the item
          type: string
        price:
          description: >-
            The item's actual price, be it the original or the overriden price.
            Output only.
          format: float
          readOnly: true
          type: number
        price_override:
          description: >-
            The item override price, this will replace the real price if
            'allow_price_override' is true
          format: float
          type: number
        quantity:
          description: Desired amount of items in the order
          format: int32
          type: integer
        user_specified_price:
          description: 'True if the item''s price has been overriden, false otherwise.'
          readOnly: true
          type: boolean
        uuid:
          description: >-
            Identifies an instance of an item in the order, internally generated
            or accepted as part of the  endpoint request body and unique to each
            order. This field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      required:
        - item_id
        - quantity
      title: OrderItem
      type: object
    v3OrderMetadata:
      properties:
        charity_rounding_enable:
          description: >-
            Optional flag indicating whether charity rounding is enabled for
            this order. If it is not provided, charity rounding defaults to
            false for the order. When it is provided and set to true, OrdersV3
            will calculate the cents needed to round up to the next whole dollar
            and the cents will be donated to charity. The charity rounding
            calculation will only run if the venue has configured in Connect. If
            the Connect setting is not enabled and the user tries to set this
            flag as true, the order creation or update will be rejected.
          type: boolean
        metadata:
          description: >-
            Used as discresion of the API user, it stores string with maximum
            length of 1024 characters
          type: string
        seat_id:
          description: >-
            Identifier of the seat where the customer is located, this is
            configured in Connect and it is part of API call to Checkout
          format: int64
          type: integer
      type: object
    v3OrderStatus:
      enum:
        - COMPLETED
        - CANCELLED
        - OPEN
      type: string
    v3OrderTotals:
      description: >-
        Represents the cumulative amounts calculated for various functions
        within the calculate process. These totals include subtotals, discounts,
        taxes, and any other relevant calculations related to the items in the
        cart. The cart totals provide an overview of the financial aspects of
        the order.
      properties:
        charity_total:
          description: >-
            Total amount of money accumulated for charity purposes in the order.
            This value represents the sum of all the rounded cents that are
            designated for donation to a charity. It is calculated as part of
            the order's overall financial calculations and is provided as an
            output. This field is optional and will only be present if the
            `CharityRoundingEnable` flag was set to true during the order
            creation, including zero (0) as a valid value if the
            `CharityRoundingEnable` flag was set.
          format: float
          readOnly: true
          type: number
        discounts_total:
          description: >-
            Contains the accumulated discounts applied to items in the order.
            This value is always represented as a negative value to indicate the
            reduction in the total cost due to discounts. The discounts_total
            provides an overall view of the total discount amount applied to the
            order. It's important to note that the discounts_total represents
            the cumulative discounts at a given point in time. If the
            'needs_to_be_recalculated' flag is set to true, the discounts_total
            may not reflect the most recent calculations or modifications to the
            order. To ensure accurate and up-to-date discount information, it is
            recommended to recalculate the order before relying on the
            discounts_total for further processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        exclusive_tax:
          description: >-
            Contains the accumulated exclusive taxes for items and modifiers. To
            ensure accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        fees_total:
          description: >-
            Represents the cumulative fees associated with the order. These fees
            may include additional charges, such as delivery fees, service fees,
            or any other applicable fees. The fees_total provides an overview of
            the total fees incurred for the order. It's important to note that
            the fees_total represents the cumulative fees at a given point in
            time. If the 'needs_to_be_recalculated' flag is set to True, the
            fees_total may not reflect the most recent calculations or
            modifications to the order. To ensure accurate and up-to-date fee
            information, it is recommended to recalculate the order before
            relying on the fees_total for further processing or displaying to
            the user.
          format: float
          readOnly: true
          type: number
        inclusive_tax:
          description: >-
            Contains the accumulated inclusive taxes for items and modifiers. To
            ensure accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        original_total:
          description: >-
            Represents the original cost of items and modifiers without applied
            taxes, discounts, or any other price modifications. To ensure
            accurate and up-to-date fee information, it is recommended to
            recalculate the order before relying on the fees_total for further
            processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        subtotal:
          description: >-
            Represents the cost of items and modifiers, including inclusive
            taxes, reduced by any item-level reductions. This amount reflects
            the total cost before applying taxes, discounts, or any other price
            modifications. To ensure accurate and up-to-date fee information, it
            is recommended to recalculate the order before relying on the
            fees_total for further processing or displaying to the user.
          format: float
          readOnly: true
          type: number
        total:
          description: >-
            The final amount for the order. It is calculated by taking the
            subtotal, reducing it by cart-level reductions, and then adding the
            exclusive taxes and fees. To ensure accurate and up-to-date fee
            information, it is recommended to recalculate the order before
            relying on the fees_total for further processing or displaying to
            the user.
          format: float
          readOnly: true
          type: number
      title: OrderTotals
      type: object
    v3Pagination:
      properties:
        page:
          format: int64
          type: integer
        per_page:
          format: int64
          type: integer
        total_pages:
          format: int64
          type: integer
        total_results:
          format: int64
          type: integer
      type: object
    v3SubmitToKitchenResponse:
      description: Items were successfully sent to the kitchen
      title: SubmitToKitchenResponse
      type: object
    v3UpdateItemResponse:
      description: Item was successfully updated
      title: UpdateItemResponse
      type: object
    v3UpdateOrderResponse:
      description: Order was successfully updated
      title: UpdateOrderResponse
      type: object
  securitySchemes:
    bearer:
      description: 'Authentication token, prefixed by Bearer: Bearer <token>'
      in: header
      name: Authorization
      type: apiKey
security:
  - bearer: []
```
{% endtab %}

{% tab checkmanagement M2 %}
```yaml
openapi: 3.0.0
info:
  contact: {}
  description: >-
    The Appetize Transactions API provides access to get and list order
    information. For access, please contact Appetize. You will receive a JWT
    that defines the venues to which you have access. Use the ListOrders
    endpoint to get a list of all orders to which you have access, within a date
    and time range that you specify. Use the GetOrder endpoint to get order
    details for a specific order, using the UUID you got from the ListOrders
    endpoint.
  title: Appetize Order API
  version: 3.0.0
servers: []
paths:
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders':
    get:
      parameters:
        - description: The corporate ID
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The venue ID
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The vendor ID
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Example: 2022-02-22T14:38:25Z


            Query filter. From what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: start_date
          required: true
          schema:
            type: string
        - description: >-
            Example: 2022-03-22T14:38:25Z


            Query filter. Up to what date of creation should the orders be
            listed, on RFC 3339 format
          in: query
          name: end_date
          required: true
          schema:
            type: string
        - description: 'How many orders should each page list, max 500'
          in: query
          name: per_page
          required: false
          schema:
            default: '100'
            format: int64
            type: integer
        - description: What page of the entire list is going to be returned
          in: query
          name: page
          required: false
          schema:
            default: '1'
            format: int64
            type: integer
      responses:
        '202':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3ListOrdersResponse'
          description: The orders were successfully retrieved
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: invalid venue id
          description: The request is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: >-
        Retrieves all orders the user has access to, within a specified date and
        time range.
      operationId: OrdersV3Service_ListOrders
      summary: List Orders
    post:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
      responses:
        '201':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3CreateOrderResponse'
          description: The order was successfully created
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Creates a new order and returns a uuid to reference in future calls.
      operationId: OrdersV3Service_CreateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3Order'
              required:
                - order
        required: true
      summary: Create Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}':
    get:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3GetOrderResponse'
          description: The order was retrieved
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Retrieves an order by its UUID
      operationId: OrdersV3Service_GetOrder
      summary: Get Order
    patch:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - in: query
          name: field_mask
          required: false
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema: {}
          description: No Content
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: |-
        Allows the modification of a specific set of properties of the order. 
        Properties that
      operationId: OrdersV3Service_UpdateOrder
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/v3OrderMetadata'
              required:
                - order_metadata
        required: true
      summary: Update Order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items':
    post:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3AddItemsResponse'
          description: The items were successfully included to the order
        '400':
          content:
            application/json:
              schema:
                example:
                  code: 400
                  message: venue_id not present in the request body
          description: The request body is invalid
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: venue 1 is not owned by the corporateID 1
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: order was not found
          description: Order was not found.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Adds an array of items to an existing order
      operationId: OrdersV3Service_AddItems
      requestBody:
        content:
          application/json:
            schema:
              description: Represents the request of add items to order endpoint
              properties:
                items:
                  description: Array of items to be included in the order
                  items:
                    $ref: '#/components/schemas/v3OrderItem'
                  type: array
              required:
                - items
              title: AddItemsRequest
              type: object
        required: true
      summary: Add Items to an order
  '/v3/corporate/{corporate_id}/venue/{venue_id}/vendor/{vendor_id}/orders/{uuid}/items/{item_uuid}':
    delete:
      parameters:
        - description: Corporate ID to place the order
          in: path
          name: corporate_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Venue ID to place the order
          in: path
          name: venue_id
          required: true
          schema:
            format: int64
            type: integer
        - description: Vendor ID to place the order
          in: path
          name: vendor_id
          required: true
          schema:
            format: int64
            type: integer
        - description: The UUID field that was retrieved when creating the order
          in: path
          name: uuid
          required: true
          schema:
            type: string
        - description: The UUID of the item to be deleted
          in: path
          name: item_uuid
          required: true
          schema:
            type: string
      responses:
        '204':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/v3DeleteItemResponse'
          description: The items were successfully deleted from the order
        '401':
          content:
            application/json:
              schema:
                example:
                  code: 401
                  message: The request is unauthorized.
          description: The request is unauthorized.
        '403':
          content:
            application/json:
              schema:
                example:
                  code: 403
                  message: you do not have access to this resource
          description: The resource is forbidden.
        '404':
          content:
            application/json:
              schema:
                example:
                  code: 404
                  message: item not found in the order
          description: The item was not found in the order.
        '500':
          content:
            application/json:
              schema:
                example:
                  code: 500
                  message: internal server error
          description: There was an error processing the request.
      tags:
        - Check Management
      description: Deletes an item from an existing order
      operationId: OrdersV3Service_DeleteItem
      summary: Delete Item from an order
components:
  schemas:
    v3AddItemsResponse:
      description: Represents of add items to an order endpoint response
      title: AddItemsResponse
      type: object
    v3CreateOrderResponse:
      description: Represents the response of create order endpoint
      properties:
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      title: CreateOrderResponse
      type: object
    v3DeleteItemResponse:
      description: Items were successfully deleted
      title: DeleteItemResponse
      type: object
    v3GetOrderResponse:
      description: 'Represents of get order endpoint, contains the order information'
      properties:
        order:
          allOf:
            - $ref: '#/components/schemas/v3Order'
          description: Represents a full order
          readOnly: true
      title: GetOrderResponse
      type: object
    v3ItemAsModifier:
      description: Enables an item to behave as modifier
      properties:
        item_set_uuid:
          description: >-
            The item set id. The given item set will be used only if the item
            belongs to that item set, and that item set is configured in it's
            parent, otherwise, this value will be ignored.
          example: 61f8454e6622f7327e4b1366
          type: string
        parent_uuid:
          description: >-
            This field identifies the uuid of the item that the modifier applies
            to, this field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      required:
        - parent_uuid
        - item_set_uuid
      title: ItemAsModifier
      type: object
    v3ListOrdersResponse:
      properties:
        orders:
          description: Returned orders
          items:
            $ref: '#/components/schemas/v3OrderInfo'
          type: array
        pagination:
          allOf:
            - $ref: '#/components/schemas/v3Pagination'
          description: Pagination object
      type: object
    v3Order:
      description: >-
        This object represents an order in a restaurant or food service setting,
        which contains details like external_id, allow_override, seat_id,
        metadata and items that are part of the order, and each item has details
        like uuid, item_id, quantity and related modifiers details.
      properties:
        corporate_id:
          description: Used to identify the order's corporate
          readOnly: true
          type: string
        created_date:
          description: Date when the order was originally submitted
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            External identifer, used as discresion of the API user, the API does
            not verify the uniqueness of this field. Maximum length 64
            characters
          example: this is any string up 64 characters
          type: string
        items:
          description: Array of items included or to be included in the order
          items:
            $ref: '#/components/schemas/v3OrderItem'
          type: array
        metadata:
          description: >-
            Used as discresion of the API user, it stores string with maximum
            length of 1024 characters
          type: string
        seat_id:
          description: >-
            Identifier of the seat where the customer is located, this is
            configured in Connect and it is part of API call to Checkout
          format: int64
          type: integer
        status:
          description: Current status of the order
          example: completed
          readOnly: true
          type: string
        updated_date:
          description: Date recording the last modification of the order
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints. This field is RFC 4122
            complaint in string representation
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
        vendor_id:
          description: Used to identify the order's vendor
          readOnly: true
          type: string
        venue_id:
          description: Used to identify the order's venue
          readOnly: true
          type: string
      required:
        - external_id
      title: Order
      type: object
    v3OrderInfo:
      properties:
        created_date:
          description: Date the order was created on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        external_id:
          description: >-
            Order identifier, not internal but from the client who originated
            the order.
          example: any-string-up-to-64-characters
          type: string
        order_status:
          description: 'The status of the order, can be ''open'', ''pending-close'' or ''closed'''
          example: open
          readOnly: true
          type: string
        updated_date:
          description: Date the order was last updated on RFC3339 format
          example: '2022-02-22T14:38:25Z'
          readOnly: true
          type: string
        uuid:
          description: >-
            Order unique identifier, created internally in the order system and
            used to identify the order in all endpoints
          example: 0cf361e1-4b44-483d-a159-54dabdf7e814
          readOnly: true
          type: string
      type: object
    v3OrderItem:
      description: Represents a unique item included or to be included in an order
      properties:
        item_as_modifier:
          allOf:
            - $ref: '#/components/schemas/v3ItemAsModifier'
          description: >-
            This object is used to indicate the current item is a modifier and
            it needs to be applied to given item
        item_id:
          description: >-
            The item identifier, provided by the Connect service, is used to
            reference the item in the menu endpoint. A single order may include
            multiple instances of the same item, each with its own distinct
            properties
          format: int64
          type: integer
        price:
          description: >-
            The item price, this will replace the real price if
            'allow_price_override' is true
          format: float
          type: number
        quantity:
          description: Desired amount of items in the order
          format: int32
          type: integer
        uuid:
          description: >-
            Identifies an instance of an item in the order, internally generated
            or accepted as part of the  endpoint request body and unique to each
            order. This field is RFC 4122 complaint in string representation
          example: 736b99f8-9113-11ed-a1eb-0242ac120002
          type: string
      title: OrderItem
      type: object
    v3OrderMetadata:
      properties:
        metadata:
          type: string
        seat_id:
          format: int64
          type: integer
      type: object
    v3OrderStatus:
      properties:
        status:
          $ref: '#/components/schemas/v3OrderStatusStatus'
      type: object
    v3OrderStatusStatus:
      enum:
        - COMPLETED
        - CANCELLED
        - PENDING_CHECKOUT
        - OPEN
      type: string
    v3Pagination:
      properties:
        limit:
          format: int64
          type: integer
        page:
          format: int64
          type: integer
        total_pages:
          format: int64
          type: integer
        total_results:
          format: int64
          type: integer
      type: object
    v3UpdateOrderResponse:
      type: object
  securitySchemes:
    bearer:
      description: 'Authentication token, prefixed by Bearer: Bearer <token>'
      in: header
      name: Authorization
      type: apiKey
security:
  - bearer: []


```
{% endtab %}

{% endtabs %}
