#!/bin/bash

echo "Testing proxy server on VPS (139.84.235.83) with different examples..."
echo

# Example 1: Simple GET request to httpbin.org
echo "1. Testing GET request to httpbin.org/get:"
curl -X GET \
    -H "X-Target-URL: https://httpbin.org" \
    -H "Content-Type: application/json" \
    "http://139.84.235.83:3000/proxy/get"
echo -e "\n"

# Example 2: POST request with JSON data
echo "2. Testing POST request to httpbin.org/post:"
curl -X POST \
    -H "X-Target-URL: https://httpbin.org" \
    -H "Content-Type: application/json" \
    -d '{"message": "Hello from proxy!", "test": true}' \
    "http://139.84.235.83:3000/proxy/post"
echo -e "\n"

# Example 3: GET request with query parameters
echo "3. Testing GET request with query parameters:"
curl -X GET \
    -H "X-Target-URL: https://httpbin.org" \
    "http://139.84.235.83:3000/proxy/get?param1=value1&param2=value2"
echo -e "\n"

# Example 4: Request with custom headers
echo "4. Testing request with custom headers:"
curl -X GET \
    -H "X-Target-URL: https://httpbin.org" \
    -H "User-Agent: MyProxyClient/1.0" \
    -H "Authorization: Bearer test-token" \
    "http://139.84.235.83:3000/proxy/headers"
echo -e "\n"

# Example 5: Error case - missing X-Target-URL header
echo "5. Testing error case (missing X-Target-URL header):"
curl -X GET \
    -H "Content-Type: application/json" \
    "http://139.84.235.83:3000/proxy/get"
echo -e "\n"
