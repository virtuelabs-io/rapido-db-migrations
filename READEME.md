export DATABASE=products
export DB_USER=postgres
export DB_PASSWORD=admin
export HOST=localhost
export PORT=5432

docker run --rm -d --name rapido-pg \
     -e POSTGRES_PASSWORD=admin \
     -p 5432:5432 \
     postgres:10.7
