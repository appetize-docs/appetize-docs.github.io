---
title: "LIVE: Fixes"
permalink: /docs/live-fixes
published: false
layout: default
createdAt: "2022-11-15T21:03:43.847Z"
updatedAt: "2022-11-17T15:29:24.500Z"
---
1. Totally different observation – I am looking at the new Enterprise Developer Center. It’s a good start. Is there any reason why Environment variable does not encompass the entire base URL? You allow for configuration in front of appetize.com, but what if you are looking at the sandbox and need something like https://api-gw.sandbox.ln.appetize-dev.com? I would assume since the portal is made for developers they could either put in api.ln.appetize.com or api-gw.sandbox.ln.appetize-dev.com for the environment variable. And then we would have an easy mechanism to demonstrate the interface as long as we had the correct API Key and the base URL.

2. TAPI Get Order endpoint sample needs to show sample with modifiers
