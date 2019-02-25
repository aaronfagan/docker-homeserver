# NextCloud

## Initial Setup

1. Navigate to the NextCloud login screen at `http://HOST:PORT/`.

2. Enter your desired administrator username and password. Configure database, select MariaDB/MySQL.

3. Set the username to `root` with the configured password, database name to `nextcloud`, and the host to `www-nextcloud-db`. Save the settings. If no error appears, move onto the next step.

4. SSH into the container by running `docker exec -it www-nextcloud bash`.

5. Install Nano by running `apt-get update && apt-get install nano`.

6. Add your domain name(s), including port, to the `trusted_domains` variable in `/var/www/html/config/config.php`.

7. If using a subfolder on reverse proxy, add `'overwritewebroot' => '/nextcloud'` at the end of `/var/www/html/config/config.php`.