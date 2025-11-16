# VLESS Windows Starter 

Simple one-click VLESS proxy starter for Windows using sing-box. 

\+ VLESS link parsing explained simply

## Features

- Extremely simple: one-button proxy enable/disable. 
- Minimal configuration
- Most compatible version (1.9.7) of most modern proxy engine (sing-box), downloaded automatically on first run
- AK47-like - simple and reliable

## What it does

- Starts `sing-box.exe` on `127.0.0.1:1084`
- Enables system-wide proxy on `127.0.0.1:1084`
- Keeps the proxy active while the `cmd` window is open. As long as you see the window, the proxy is active.
- On key press, disables proxy and terminates `sing-box.exe`

## Requirements

- Windows 10 or newer
- Internet connection

## Required folder structure

```
internet-enabler/
├── prepare-and-start.bat
└── config.json (your version based on config-filled-fake.json)
```

## How to use

I. Download this repository or just files separately: `config-filled-fake.json` and `prepare-and-start.bat`

II. Rename `config-filled-fake.json` to `config.json`

---
III. Fill `config.json` with your server details:

Get your VLESS key. 
Usually you have VLESS subscription link starting with `https://`. Open it in browser.
There you will have your VLESS key starting with (`vless://...`):

```example
vless://e6179c4d-e162-42ea-a71c-7jc96114f238@maskyshow.online:443?security=reality&type=tcp&headerType=&flow=xtls-rprx-vision&path=&host=&sni=whitelist.com&fp=random&pbk=Vdbpg8ljhhgzgx4g4uNJklXzlrMCd9L1igJSWrRUvLp&sid=8k222b3475800923
```

Paramenters for config are inside of key. You need to move them accordingly to config. 
Use the table:
     
| in link   | value                                       | in config              | value                                       |
| --------- | ------------------------------------------- | ---------------------- | ------------------------------------------- |
| uuid      | e6179c4d-e162-42ea-a71c-7jc96114f238        | uuid                   | e6179c4d-e162-42ea-a71c-7jc96114f238        |
| server    | maskyshow.online                            | server                 | maskyshow.online                            |
| port      | 443                                         | server_port            | 443                                         |
| flow      | xtls-rprx-vision                            | flow                   | xtls-rprx-vision                            |
| sni       | whitelist.com                               | server_name            | whitelist.com                               |
| pbk       | Vdbpg8ljhhgzgx4g4uNJklXzlrMCd9L1igJSWrRUvLp | public_key             | Vdbpg8ljhhgzgx4g4uNJklXzlrMCd9L1igJSWrRUvLp |
| sid       | 8k222b3475800923                            | short_id               | 8k222b3475800923                            |
| fp        | random                                      | fingerprint            | random                                      |

---

Or using Nekoray:
1. Download: https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-windows64.zip
2. Import your VLESS subscription/key into Nekoray
3. Export ready VLESS config from it: `Share` > `Export sing-box config (Ctrl+E)`
   You will get config.json too, but not so manually. 

---

IV. When config.json is in place and filled, run `prepare-and-start.bat`, Admin rights should be unneeded. 

You must see non-red lines of log:
```
INFO[0000] inbound/mixed[mixed-in]: tcp server started at 127.0.0.1:1084
INFO[0000] sing-box started (0.11s)
<running lines>
```

V. To stop proxy, **press any button in console window** and **then** close the window. Otherwise you will lose Internet connection till you fix it (see below). 

If you have already lost Internet connection: 
- A-way. Run the .bat again. Press any key. Close the window. 
- B-way. Go to system settings, find `proxy` (system proxy), disable it. 

## How to check if proxy works

1. Open https://whoer.net in browser
2. Check if your IP/country location changed

---

Page Views:

![Views](https://komarev.com/ghpvc/?username=hopsayer&repo=vless-win-starter-simple&color=green&style=flat-square)
