# VLESS Windows Starter

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

1. Download this repository or just files separately: config-template.json and prepare-and-start.bat
2. Rename `config-template.json` to `config.json`
3. Fill `client.json` with your server/subscription details:
```
     Get your VLESS key (`vless://...`)
     Replace `vless://` for `https://`
     Copy-paste to your browser address bar and hit `Enter`
     Wait till VLESS server details load and appear in browser window
     Fill your `config.json` with them accordingly:

       `server` - your server address
       `server_port` - your server port
       `uuid` - your UUID
       `public_key` - Reality public key
       `short_id` - Reality short ID
       `server_name` - SNI (e.g., www.microsoft.com)
```

4. Run `prepare-and-start.bat`
