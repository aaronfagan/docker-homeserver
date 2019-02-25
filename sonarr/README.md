# Sonarr

Sonarr (formerly NZBdrone) is a PVR for usenet and bittorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

Read the [Official Documentation](https://hub.docker.com/r/linuxserver/sonarr/).

## Build Variables

Variables without default are required.

**`DIR_MOUNT`**
- This is the directory on the host where your files will be mounted.

**`DIR_TRANSMISSION`**
- This is the directory on the host where your Transmission files are mounted.

**`DIR_MEDIA`**
- This is the directory on the host where your media files are stored.

## Environment Variables

Variables without default are required.

**`TZ`**
- **Default:** `America/New_York`
- Your local timezone. ([More Info](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))

# Contributors

* Aaron Fagan - [Github](https://github.com/aaronfagan), [Website](https://www.aaronfagan.ca/)