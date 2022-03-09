#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
    "inbounds": 
    [
        {
            "port": 443,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password":"e40d2888-03f6-4859-e84d-a743db763d52"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": 
    [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

#run xray

xray -c /etc/xray/config.json
