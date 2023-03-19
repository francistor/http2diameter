#!/bin/bash

../http2diameter &

# Wait for server to start
sleep 3

# Send request that will be replied echoing all attributes
response=$(curl -s http://localhost:8081/routeDiameterRequest -X POST -d '
{
    "Message": {
        "IsRequest": true,
        "IsProxyable": false,
        "IsError": false,
        "IsRetransmission": false,
        "CommandCode": 272,
        "ApplicationId": 16777238,
        "avps":[
            {"Origin-Host": "cc.client"},
            {"Origin-Realm": "minsait"},
            {"Destination-Realm": "minsait"},
            {"Session-Id": "sessionId-1"},
            {"Auth-Application-Id": 16777238},
            {"CC-Request-Type": 1},
            {"CC-Request-Number": 1},
            {"Subscription-Id": [
                    {"Subscription-Id-Type": 1},
                    {"Subscription-Id-Data": "913374871"}
                ]
            }
        ]
    },
    "TimeoutSpec": "2s"
}
')

pkill http2diameter

sleep 1
echo "-------------------------------------------------"
echo "RESPONSE"
echo "-------------------------------------------------"
echo $response
echo "-------------------------------------------------"