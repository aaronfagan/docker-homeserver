# Jackett

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.

Read the [Official Documentation](https://hub.docker.com/r/linuxserver/jackett/).

## Build Variables

Variables without default are required.

**`DIR_MOUNT`**
- This is the directory on the host where your files will be mounted.

## Environment Variables

Variables without default are required.

**`TZ`**
- **Default:** `America/New_York`
- Your local timezone. ([More Info](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))

# Contributors

* Aaron Fagan - [Github](https://github.com/aaronfagan), [Website](https://www.aaronfagan.ca/)