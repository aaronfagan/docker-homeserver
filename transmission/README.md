# Transmission + OpenVPN

This container contains OpenVPN and Transmission with a configuration where Transmission is running only when OpenVPN has an active tunnel. It bundles configuration files for many popular VPN providers to make the setup easier.

Read the [Official Documentation](https://hub.docker.com/r/haugene/transmission-openvpn).

## Build Variables

Variables without default are required.

**`DIR_MOUNT`**
- This is the directory on the host where your files will be mounted.

**`DIR_MEDIA`**
- This is the directory on the host where your media files are stored.

## Environment Variables

Variables without default are required.

**`OPENVPN_PROVIDER`**
- Your OpenVPN provider.

**`OPENVPN_USERNAME`**
- Your OpenVPN username.

**`OPENVPN_PASSWORD`**
- Your OpenVPN password.

**`OPENVPN_CONFIG`**
- Your desired OpenVPN endpoints. ([More Info](https://github.com/haugene/docker-transmission-openvpn#network-configuration-options))

**`OPENVPN_OPTS`**
- **Default:** `--inactive 3600 --ping 10 --ping-exit 60`
- Options passed to OpenVPN on startup. ([More Info](https://github.com/haugene/docker-transmission-openvpn#network-configuration-options))

**`LOCAL_NETWORK`**
- **Default:** `192.168.1.0/24`
- Your local network IP range. ([More Info](https://github.com/haugene/docker-transmission-openvpn#access-the-webui))

**`TZ`**
- **Default:** `America/New_York`
- Your local timezone. ([More Info](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))


# Contributors

* Aaron Fagan - [Github](https://github.com/aaronfagan), [Website](https://www.aaronfagan.ca/)