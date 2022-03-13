#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
$ cat > /etc/xray/config.json <<EOF
{
        "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "block"
            }
        ]
    },
    "inbounds": [
        {
            "listen": "0.0.0.0",
            "port": 80,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "e40d2888-03f6-4859-e84d-a743db763d52"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "proxy"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}
EOF

#run xray

xray -c /etc/xray/config.json
