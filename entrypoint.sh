#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
$ cat > /etc/xray/config.json <<EOF
{
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "e40d2888-03f6-4859-e84d-a743db763d52" // 填写你的 UUID
                    }
                ],
                "decryption": "none"
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
