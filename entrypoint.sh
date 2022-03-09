#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
cat << EOF > /etc/xray/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "e40d2888-03f6-4859-e84d-a743db763d52", // 填写你的 UUID
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 80
                    },
                    {
                        "path": "/", // 必须换成自定义的 PATH
                        "dest": 1234,
                        "xver": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
            }
        },
        {
            "port": 1234,
            "listen": "127.0.0.1",
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "e40d2888-03f6-4859-e84d-a743db763d52", // 填写你的 UUID
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true, // 提醒：若你用 Nginx/Caddy 等反代 WS，需要删掉这行
                    "path": "/" // 必须换成自定义的 PATH，需要和上面的一致
                }
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
