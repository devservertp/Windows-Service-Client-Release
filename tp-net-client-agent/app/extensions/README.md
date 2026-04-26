# tp-net-client-agent-extension-trigger

Extension Wake-on-LAN cho `tp-net-client-agent`. Ký sinh vào agent — không chạy độc lập.

---

## Yêu cầu

- `tp-net-client-agent` đã được deploy và đang chạy
- Agent version hỗ trợ extension (run.bat dùng `java -cp` với scan `extensions/*.jar`)

---

## Build

```bat
build.bat
```

Output: `tp-net-client-agent-extension-trigger\tp-net-client-agent-extension-trigger.jar`

---

## Cài đặt

**1. Tạo thư mục `extensions` trong agent nếu chưa có:**

```
tp-net-agent\
└── extensions\          ← tạo thư mục này
```

**2. Copy jar vào:**

```
tp-net-agent\
└── extensions\
    └── tp-net-client-agent-extension-trigger.jar
```

**3. Restart agent** — extension được load tự động khi agent khởi động.

---

## Gỡ cài đặt

Xóa jar khỏi thư mục `extensions\` → restart agent.

---

## Sử dụng

Watcher gửi lệnh MQTT lên topic `winttsvc/broadcast/control` với payload:

```json
{
  "meta": { ... },
  "data": {
    "command_title": "power",
    "command": "power-on",
    "command_context": "AA:BB:CC:DD:EE:FF, tp-net-agent-616-F974FA17"
  },
  "secure": { ... }
}
```

`command_context` CSV: `<MAC>, <target_identity>`. Phần MAC bắt buộc, phần target identity hiện chỉ log để audit (chưa filter).

Trigger agent nhận lệnh → broadcast UDP magic packet đến `255.255.255.255:9` → máy có MAC `AA:BB:CC:DD:EE:FF` trong cùng subnet được wake up.

**MAC format chấp nhận:** `AA:BB:CC:DD:EE:FF`, `AA-BB-CC-DD-EE-FF`, `AABBCCDDEEFF`
