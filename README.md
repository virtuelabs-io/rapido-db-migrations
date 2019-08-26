# Rapido build db migrations

## Initialize migrations

```sh
docker run --rm --name db-migrations \
    -e DB_USER=$USERNAME \
    -e DB_PASSWORD=$PASSWORD \
    -e HOST=$HOST \
    -e POST=$PORT \
    -e ROOT_DB=$DATABASE \
    $REGISTRY/rapido-db-migrations init
```

## Run migrations

```sh
docker run --rm --name db-migrations \
    -e DB_USER=$USERNAME \
    -e DB_PASSWORD=$PASSWORD \
    -e HOST=$HOST \
    -e POST=$PORT \
    -e ROOT_DB=$DATABASE \
    $REGISTRY/rapido-db-migrations migrate
```
