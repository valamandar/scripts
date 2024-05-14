#!/bin/bash

# Chemin du dossier à parcourir
dossier="/home/valamandar/Projects/"

# Tableau des noms de dossiers à supprimer
declare -a dossiers_a_supprimer=(
    ".env"
    ".venv"
    "node_modules"
    "venv"
    "env"
)

# Parcours récursif des dossiers et suppression
supprimer_dossiers() {
    while IFS= read -r -d '' dossier; do
        nom_dossier="${dossier##*/}"
        if [[ " ${dossiers_a_supprimer[@]} " =~ " ${nom_dossier} " ]]; then
            echo "Suppression du dossier $dossier"
            rm -rf "$dossier"
        fi
    done < <(find "$1" -type d -print0)
}

# Appel initial de la fonction pour supprimer les dossiers spécifiés
supprimer_dossiers "$dossier"