#!/bin/bash

# Liste des images Docker à installer
images=(
    "nginx:latest"
    "mysql:latest"
    "redis:latest"
    "rabbitmq:latest"
    "wordpress:latest"
    "php:latest"
    "mariadb:latest"
    "phpmyadmin:latest"
    "traefik:latest"
    "mysql:latest"
    "node:latest"
    "busybox:latest"
    "elasticsearch:latest"
    "mongo-express:latest"
    "matomo:latest"
    "odoo:latest"
)

# Parcourir la liste des images et les installer une par une
for image in "${images[@]}"
do
    # Extraire le nom de l'image et la version
    image_name="${image%:*}"
    image_version="${image#*:}"

    # Vérifier si l'image existe déjà localement
    if docker image inspect "$image" >/dev/null 2>&1; then
        echo "L'image $image existe déjà. Ignorer l'installation."
    else
        # Télécharger l'image depuis le registre Docker
        echo "Téléchargement de l'image $image..."
        docker pull "$image"

        # Vérifier si le téléchargement a réussi
        if [ $? -eq 0 ]; then
        echo "L'image $image a été installée avec succès."
        else
        echo "Échec de l'installation de l'image $image."
        fi
    fi
done