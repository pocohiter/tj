#!/bin/sh

#Config xray

rm -rf /etc/xray/config.json
$ cat > /etc/xray/config.json <<EOF
{
    "inbounds": [
        {
            "port": 10800,
            "listen": "127.0.0.1",
            "protocol": "socks",
            "settings": {
                "udp": true
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "vless",
            "settings": {
                "vnext": [
                    {
                        "address": "kings-us-02.herokuapp.com", // 换成你的域名或服务器 IP（发起请求时无需解析域名了）
                        "port": 443,
                        "users": [
                            {
                                "id": "e40d2888-03f6-4859-e84d-a743db763d52", // 填写你的 UUID
                                "encryption": "none",
                                "level": 0
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "viettel.akamaized.net" // 换成你的域名
                }
            }
        }
    ]
}
EOF

#run xray

docker run -d -p 443:443 --name xray --restart=always -v /etc/xray:/etc/xray teddysun/xray

xray -c /etc/xray/config.json
