# the Proxy and MCU communication protocol
## communication using LS9AD format
[LS9AD](images／a.png)

```
 RemoteId           - 0
 Type               - GET:1, SET:2
 MessageBoxId       -
 Status             - 0, 1, 2, 3
 CRC               - not used
 Data Length     - length in bytes of payload, 0 if no payload, sending:LSB, receiving:MSB
 Data              - always a NULL terminated string, e.g. Integer 1 should be ASCII "0x31"
```

## 目前涉及的主要协议（v0.1）
### 升级相关
```
Message-Box 222 (Cast OTA Update)
Message-Box 223 (Firmware Upgrade INTERNET)
Message-Box 66 (Firmware Upgrade Progress)
```

### 播放音乐相关
```
Message-Box 49 (Current Time)
Message-Box 64 (Volume Control)
Message-Box 42 (Get UI)
Message-Box 50 (Current Source)
```

### 网络配置相关
```
Message-Box 124 (Network Connection Status)
Message-Box 143 (Network Configuration Status)
Message-Box 91 (Device MACID)
Message-Box 208 (NV Read/Write)
```

### 开关机
```
Message-Box 114 (Re-boot Request)
Message-Box 68 (Host-Image-Present)
```
## 扩展字段
```
enum class MCUTYPE {
    VOLUME = 0x101,               
    AMPLIFIER_VOLUME,
    BRIGHTNESS,
    SWITCH_POWER,
    SWITCH_FACTORY_RESET,
    SWITCH_WAC,
    LCD_STATUS,
	   FONT_INFO = 0x201
};
```

## 歌曲专辑信息
```
{
" Artist":[
{
“Type” :1, //1代表英文（只有Type Charater字段） 0代表非英文
"Character ":"0x73 0x8B",
"Height":0x10,
"Width":0x10,
"Bytes": 0x10,
"Fonts":"0x00 0x10 …."
},
……….
……….
]	

" Album ":[
{
“Type” :1, 
"Character ":"0x73 0x8B",
"Height":0x10,
"Width":0x10,
"Bytes": 0x10,
"Fonts":"ox00 0x10 …."
},
………
………
]

" TrackName ":[
{
“Type” :1, 
"Character ":"0x73 0x8B",
"Height":0x10,
"Width":0x10,
"Bytes": 0x10,
"Fonts":"ox00 0x10 …."
},
……
……
]
}

" Title":[
{
“Type” :1, //1代表英文（只有Type Charater字段） 0代表非英文
"Character ":"0x73 0x8B",
"Height":0x10,
"Width":0x10,
"Bytes": 0x10,
"Fonts":"0x00 0x10 …."
},
……….
……….
]

" Description":[
{
“Type” :1, //1代表英文（只有Type Charater字段） 0代表非英文
"Character ":"0x73 0x8B",
"Height":0x10,
"Width":0x10,
"Bytes": 0x10,
"Fonts":"0x00 0x10 …."
},
……….
……….
]
```

