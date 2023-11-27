---
title: Postman Collections
parent: Common API Considerations
nav_order: 5
has_children: true
permalink: /docs/postman-collections
layout: default
createdAt: "2022-10-12T17:26:28.884Z"
updatedAt: "2022-11-14T17:45:48.043Z"
---
## Example API requests with Postman™
{{site.product_name}} provides a Postman™ API client collection of API requests to help you get started working with our endpoints without needing to write any code.

### What is Postman?
Postman is an industry-standard tool for designing, building and testing API's and can be leveraged to make ad hoc calls to existing API's

### Where can I get the {{site.product_name}} Postman Collections?
The postman collection for Transaction API (TAPI) can be found [here]({{site.baseurl}}/docs/postman-transaction-api-collection).

### How do I import the collection in Postman?
Copy the code in the code block for the API collection that you are working with to your clipboard.
Open Postman and select "Import" from within the workspace that you will be using the collection.


![Screen Shot 2022-11-04 at 2.34.48 PM.png]({{site.baseurl}}/assets/images/docs/129fbaf-Screen_Shot_2022-11-04_at_2.34.48_PM.png)


Select Raw Text from the tool bar along the top of the import modal

![Screen Shot 2022-11-04 at 2.30.45 PM.png]({{site.baseurl}}/assets/images/docs/f21d036-Screen_Shot_2022-11-04_at_2.30.45_PM.png)

Paste the data that you copied into box and select Continue



![Screen Shot 2022-11-04 at 2.36.16 PM.png]({{site.baseurl}}/assets/images/docs/185a72b-Screen_Shot_2022-11-04_at_2.36.16_PM.png)

Select Import to continue with importing the collection.
![Screen Shot 2022-11-04 at 2.37.40 PM.png]({{site.baseurl}}/assets/images/docs/5f12b4c-Screen_Shot_2022-11-04_at_2.37.40_PM.png)

Once complete, you should see the collection in your workspace.
![Screen Shot 2022-11-04 at 2.39.28 PM.png]({{site.baseurl}}/assets/images/docs/e5d5430-Screen_Shot_2022-11-04_at_2.39.28_PM.png)

Once the import is complete you will need to edit the url for each of the calls to insert the base url that pertains to your specific project, and to add in your specific API key that is assigned to you for your project. 

{: .important-title }
> Postman Help
>
> For more information on using the Postman API Client, see [the Postman documentation](https://learning.postman.com/).


### How do I make an API call with Postman?
After doing the initial collection setup above, open the desired API call on the left sidebar.
Verify that variables such as parameters, authentication, headers and JSON bodies are correct.
To submit your API call and see the results, click send.
