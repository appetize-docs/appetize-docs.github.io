---
title: "Postman PubSub Collection"
parent: Postman Collections
grand_parent: Common API Considerations
nav_order: 2
permalink: /docs/pubsub-postman-collection
layout: default
createdAt: "2022-11-29T20:13:21.013Z"
updatedAt: "2023-06-26T19:35:10.504Z"
---
Copy the JSON object below and follow the import instructions on the Postman Collections page to import this collection to your Postman workspace.

```json
{
  "info": {
    "_postman_id": "9368135e-364f-4d97-94f6-0583ef0f32b6",
    "name": "Example PUBSUB Collection",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
    "_exporter_id": "18011579",
    "_collection_link": "https://appetize.postman.co/workspace/My-Workspace-Enterprise-APIs~3c00463a-c30e-44fc-8eb3-40464b7ad6e3/collection/18011579-9368135e-364f-4d97-94f6-0583ef0f32b6?action=share&creator=18011579&source=collection_link"
  },
  "item": [
    {
      "name": "PubSub Auth",
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [
              "let response = pm.response.json();",
              'pm.environment.set("auth_key", response.auth_key);'
            ],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "x-api-key",
            "value": "{{api_key}}",
            "type": "text"
          }
        ],
        "url": {
          "raw": "{{base_url}}auth/pubsub",
          "host": [
            "{{base_url}}auth"
          ],
          "path": [
            "pubsub"
          ]
        },
        "response": []
      }
    },
    {
      "name": "Create a Subscription",
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [""],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "auth": {
          "type": "bearer",
          "bearer": [
            {
              "key": "token",
              "value": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2MSI6eyJ0eXBlIjoiaW50ZXJuYWwiLCJzZXJ2aWNlSWQiOiJhdXRoIiwiY2xhaW1zIjp7InVzZXJJZCI6IjAiLCJjb3Jwb3JhdGVJZHMiOlsiOSJdLCJ2ZW51ZUlkcyI6WyIxMTQiXSwidmVuZG9ySWRzIjpbIjkzNiJdfX0sImV4cCI6MTY3Mzk2NzQ4OSwiaWF0IjoxNjA5Mjc1MDE5LCJpc3MiOiJhdXRoIn0.g1l9HCOt7IXvGMY_KSHVVbck_jNY38_LC3q8T2UjkWY",
              "type": "string"
            }
          ]
        },
        "method": "POST",
        "header": [
          {
            "key": "X-api-key",
            "value": "{{api_key}}",
            "type": "text"
          },
          {
            "key": "Content-Type",
            "value": "application/json",
            "type": "text"
          },
          {
            "key": "Accept",
            "value": "application/com.appetize.subscriber.v1.0+json",
            "type": "text"
          },
          {
            "key": "Authorization",
            "value": "Bearer {{auth_token}}",
            "type": "text"
          },
          {
            "key": "disabled",
            "value": true,
            "type": "text"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n    \"topics\": [\n        \"orders\"\n    ],\n    \"corporate_id\": 2199,\n    \"venue_ids\": [\n            4673\n            \n    ],\n    \"vendor_ids\": [\n            75181,\n            75293,\n            85069\n    ]\n}"
        },
        "options": {
          "raw": {
            "language": "json"
          }
        },
        "url": {
          "raw": "{{base_url}}pubsub-subscriber/subscriptions",
          "host": [
            "{{base_url}}pubsub-subscriber"
          ],
          "path": [
            "subscriptions"
          ],
          "response": []
        }
      }
    }
  ]
}

```
