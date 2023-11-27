---
title: "Postman Transaction API Collection"
parent: Postman Collections
grand_parent: Common API Considerations
nav_order: 1
permalink: /docs/postman-transaction-api-collection
layout: default
createdAt: "2022-11-04T18:11:07.002Z"
updatedAt: "2022-11-04T18:59:41.713Z"
---
Copy the JSON object below and follow the import instructions on the Postman Collections page to import this collection to your Postman workspace.

```json
{
	"info": {
		"_postman_id": "5525cd18-7ab3-4d19-be39-9bf81f1de2d4",
		"name": "Transactions API Dev Center",
		"schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
		"_exporter_id": "18011579"
	},
	"item": [
		{
			"name": "Auth Transactions",
			"event": [
				{
					"listen": "test",
					"script": {
						"exec": [
							"let response = pm.response.json();",
							"pm.environment.set(\"auth_key\", response.auth_key);"
						],
						"type": "text/javascript"
					}
				}
			],
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"content-length": true,
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "noauth"
				},
				"method": "POST",
				"header": [
					{
						"key": "X-API-Key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"body": {
					"mode": "urlencoded",
					"urlencoded": []
				},
				"url": {
					"raw": "{{base_url}}auth/transactions",
					"host": [
						"{{base_url}}auth"
					],
					"path": [
						"transactions"
					]
				}
			},
			"response": []
		},
		{
			"name": "List Orders",
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "GET",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders?page=1&start_date=2022-09-23T00:00:00Z&end_date=2022-09-30T00:00:00Z",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders"
					],
					"query": [
						{
							"key": "page",
							"value": "1"
						},
						{
							"key": "retrieval_status",
							"value": "incomplete",
							"disabled": true
						},
						{
							"key": "status",
							"value": "DEADLETTER",
							"disabled": true
						},
						{
							"key": "status",
							"value": "DELETED",
							"disabled": true
						},
						{
							"key": "start_date",
							"value": "2022-09-23T00:00:00Z"
						},
						{
							"key": "end_date",
							"value": "2022-09-30T00:00:00Z"
						},
						{
							"key": "limit",
							"value": "50",
							"disabled": true
						}
					]
				}
			},
			"response": []
		},
		{
			"name": "List Orders Current Date",
			"event": [
				{
					"listen": "prerequest",
					"script": {
						"exec": [
							"var moment = require('moment');",
							"pm.environment.set('currentdate', moment().format((\"YYYY-MM-DD\")));",
							""
						],
						"type": "text/javascript"
					}
				}
			],
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "GET",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders?page=1&start_date={{currentdate}}T00:00:00Z&end_date={{currentdate}}T23:59:59Z",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders"
					],
					"query": [
						{
							"key": "page",
							"value": "1"
						},
						{
							"key": "retrieval_status",
							"value": "incomplete",
							"disabled": true
						},
						{
							"key": "start_date",
							"value": "{{currentdate}}T00:00:00Z"
						},
						{
							"key": "end_date",
							"value": "{{currentdate}}T23:59:59Z"
						}
					]
				}
			},
			"response": []
		},
		{
			"name": "List Orders 7 Days",
			"event": [
				{
					"listen": "prerequest",
					"script": {
						"exec": [
							"var moment = require('moment');",
							"var startdate = moment().subtract(6, 'days');",
							"var enddate = moment();",
							"pm.environment.set('startdate', startdate.format((\"YYYY-MM-DD\")));",
							"pm.environment.set('enddate', enddate.format((\"YYYY-MM-DD\")));"
						],
						"type": "text/javascript"
					}
				}
			],
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "GET",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders?page=1&start_date={{startdate}}T00:00:00Z&end_date={{enddate}}T23:59:59Z",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders"
					],
					"query": [
						{
							"key": "page",
							"value": "1"
						},
						{
							"key": "retrieval_status",
							"value": "incomplete",
							"disabled": true
						},
						{
							"key": "start_date",
							"value": "{{startdate}}T00:00:00Z"
						},
						{
							"key": "end_date",
							"value": "{{enddate}}T23:59:59Z"
						}
					]
				}
			},
			"response": []
		},
		{
			"name": "List Quarentined Orders",
			"event": [
				{
					"listen": "prerequest",
					"script": {
						"exec": [
							"var moment = require('moment');",
							"pm.environment.set('currentdate', moment().format((\"YYYY-MM-DD\")));"
						],
						"type": "text/javascript"
					}
				}
			],
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "GET",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/quarantine-orders?start_date=2022-08-05T00:00:00Z&end_date=2022-08-12T00:00:00Z",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"quarantine-orders"
					],
					"query": [
						{
							"key": "page",
							"value": "1",
							"disabled": true
						},
						{
							"key": "start_date",
							"value": "2022-08-05T00:00:00Z"
						},
						{
							"key": "end_date",
							"value": "2022-08-12T00:00:00Z"
						}
					]
				}
			},
			"response": []
		},
		{
			"name": "Get Order",
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "GET",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders/5fb78830-ca9e-4cda-be78-c586376b87c8",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders",
						"5fb78830-ca9e-4cda-be78-c586376b87c8"
					]
				}
			},
			"response": []
		},
		{
			"name": "Mark Dead Letter Order",
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "POST",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders/dd339872-5bd3-4560-816c-c68c21ffdb59/mark-dead-letter",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders",
						"dd339872-5bd3-4560-816c-c68c21ffdb59",
						"mark-dead-letter"
					]
				}
			},
			"response": []
		},
		{
			"name": "Reprocess Order",
			"protocolProfileBehavior": {
				"disabledSystemHeaders": {
					"user-agent": true,
					"accept": true,
					"accept-encoding": true,
					"connection": true
				}
			},
			"request": {
				"auth": {
					"type": "bearer",
					"bearer": [
						{
							"key": "token",
							"value": "{{auth_key}}",
							"type": "string"
						}
					]
				},
				"method": "POST",
				"header": [
					{
						"key": "x-api-key",
						"value": "{{api_key}}",
						"type": "text"
					}
				],
				"url": {
					"raw": "{{base_url}}transactions_api/orders/b59523a1-1e09-4f36-b05a-0e80795256d3/reprocess",
					"host": [
						"{{base_url}}transactions_api"
					],
					"path": [
						"orders",
						"b59523a1-1e09-4f36-b05a-0e80795256d3",
						"reprocess"
					]
				}
			},
			"response": []
		}
	]
}
```
