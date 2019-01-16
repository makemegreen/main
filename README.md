# Make Me Green
Main repo for makemegreen


## Pour débuter

Initialiser le projet avec les différents repository (demander les accès avant) :

./manage.sh init

## Lancer l'application

docker-compose build
docker-compose up

La webapp est accessible à l'adresse suivante : [localhost:3000](http://localhost:3000)

## Installer les données de démo

./manage.sh sandbox

## Activer le moteur de recommendation (engine)

Modify RECO_ENGINE in env_file and set it to 1 for enable (0 for disable). 
