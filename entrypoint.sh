#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
$ cat > /etc/xray/config.json <<EOF
{
    "inbounds": [
        {
            "listen": "0.0.0.0",
            "port": ${PORT},
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "e40d2888-03f6-4859-e84d-a743db763d52",
                        "alterId": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

#run xray

xray -c /etc/xray/config.json
