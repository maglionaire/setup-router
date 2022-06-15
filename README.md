# Setup Connext router
## Minimum Requirements
  - 8GB RAM
  - 30GB Storage
  - Redis

## Quick router setup script
```
wget -q -O setup_router.sh https://raw.githubusercontent.com/maglionaire/setup-router/main/setup-router.sh && chmod +x setup_router.sh && sudo /bin/bash setup_router.sh
```

## Check result after run script
- Monitor router logs
  ```
  docker logs --follow --tail 100 router
  ```
- Check your public key
  ```
  curl localhost:8000/config
  ```