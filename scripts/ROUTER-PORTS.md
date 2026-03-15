# Router port forwarding for ZODE

So other ZODEs on the internet can reach your node, forward these ports from your router to this PC.

## Ports

| Port | Protocol | Use        |
|------|----------|------------|
| 3690 | UDP      | QUIC (libp2p) |
| 3691 | TCP      | Relay      |
| 3692 | TCP      | Optional   |

## Steps (generic)

1. Open a browser and go to your router’s admin page (e.g. `192.168.1.1` or the “Default gateway” from `ipconfig`).
2. Log in (admin / sticker password).
3. Find **Port forwarding** / **Virtual server** / **NAT**.
4. Add rules:

   - **External port** 3690, **Internal port** 3690, **Protocol** UDP, **Internal IP** = your PC’s LAN IP (e.g. `192.168.20.51`).
   - **External port** 3691, **Internal port** 3691, **Protocol** TCP, **Internal IP** = same.
   - **External port** 3692, **Internal port** 3692, **Protocol** TCP, **Internal IP** = same (if you use 3692).

5. Save and reboot the router if needed.

Your PC’s LAN IP: run `ipconfig` and use the **IPv4 Address** of the adapter you use for the internet (e.g. Ethernet or Wi‑Fi).
