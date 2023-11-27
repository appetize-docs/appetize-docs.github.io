---
title: "Sections & Seats"
permalink: /docs/sections-seats
published: false
layout: default
createdAt: "2022-10-20T18:06:58.797Z"
updatedAt: "2022-10-20T19:08:34.877Z"
---
seats data does not return in the /vendor call. The seat_id filter in the parameters schema can be ignored.

I
n the body of the cart you can add "seat_id": "", with a valid seat id as a string value as laid out in the checkout call schema
image.png

For the questions around seats
in the vendors listing api there is an option to pull the vendors list using SeatID. This is a query parameter that would be passed with the /Vendor request.
Can you help us understand what is the criteria for selecting the vendors based on the SeatID.
Is it based on the proximity of the vendor near the user's seat.
or is it based on the section of the user's seat?
Or do we get the list of all vendors sorted in order of the distance (nearest vendor at the top of the list)

Vendors are assigned the seats in the Serves tab of the vendor - It calls out the Level,Sections and Seat Numbers for that vendor.
You can pull back a list of levels using the /venues/{venue_id}/levels endpoint and a list of seats using the /vendor/{vendor_id/levels/{level_id}/seats
We do not have any geolocation around the seating, whis is what I am thinking you would want to leverage based on the questions above.

Currently there is no seat data associated in the vendor data that is returned - I suspect that there is a configuration that may need to be changed to show that data in the results. I will pose the question, but would like to understand the use case for sorting by seat_id before we make any additional configuration changes.

![image]({{site.baseurl}}/assets/images/docs/94a0930-image.png)
