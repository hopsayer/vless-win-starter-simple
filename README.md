# VLESS Windows Starter + VLESS link parsing explained simply

Simple one-click VLESS proxy starter for Windows using sing-box.

## Features

- One-button proxy enable/disable
- Minimal configuration
- Most compatible version (1.9.7) of most modern proxy engine (sing-box), downloaded automatically on first run
- AK47-like - simple and reliable

## Requirements

- Windows 10 or newer
- Internet connection for first run (obviously)

## Needed folder structure

```
vless-win-starter-simple/
├── prepare-and-start.bat
└── config.json (filled-in config-template.json)
```

## What to do

I. Download this repository or just files separately: config-template.json and prepare-and-start.bat

II. Rename `config-template.json` to `config.json`

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



The other way is to use Nekoray:
1. Download: https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-windows64.zip
2. Import your VLESS subscription/key into Nekoray
3. Export ready VLESS config from it: `Share` > `Export sing-box config (Ctrl+E)`
   You will get config.json too, but not so manually. 



IV. When config.json is in place and filled, run `prepare-and-start.bat`, preferably as Admin

![GitHub views](https://komarev.com/ghpvc/?username=hopsayer&repo=vless-win-starter-simple&color=green&style=flat-square)
