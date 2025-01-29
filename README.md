# BCC Music Orders
## Notes
To manually renew the Letsencrypt certificates, run the following on the docker host machine
```
docker run -it --rm --name certbot -v "./data/certbot/conf:/etc/letsencrypt" -v "./data/certbot/www:/var/www/certbot" certbot/certbot renew
```
