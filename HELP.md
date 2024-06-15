## Issues with SSL certificates.

Remove the ./data/certbot/ directory and restart both the certbot and nginx container. This will force the container to generate new certificates.