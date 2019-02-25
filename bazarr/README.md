# Bazarr

Bazarr is a companion application to Sonarr and Radarr. It can manage and download subtitles based on your requirements. You define your preferences by TV show or movie and Bazarr takes care of everything for you.

Read the [Official Documentation](https://hub.docker.com/r/linuxserver/bazarr/).

## Build Variables

Variables without default are required.

**`DIR_MOUNT`**
- This is the directory on the host where your files will be mounted.

**`DIR_MEDIA`**
- This is the directory on the host where your media files are stored.

## Environment Variables

Variables without default are required.

**`TZ`**
- **Default:** `America/New_York`
- Your local timezone. ([More Info](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))

# Contributors

* Aaron Fagan - [Github](https://github.com/aaronfagan), [Website](https://www.aaronfagan.ca/)