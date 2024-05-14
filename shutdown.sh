#!/bin/bash

# Fonction pour afficher le menu
display_menu() {
    echo "Que souhaitez-vous faire ?"
    echo "1. Eteindre la machine"
    echo "2. Mettre en veille la machine"
    echo "3. Quitter"
}

# Fonction pour éteindre la machine après un délai
shutdown_machine() {
    echo "Entrez le délai avant l'extinction (en secondes, minutes ou heures, ex: 10s, 5m, 1h) :"
    read delay

    # Vérifier si le délai est un nombre valide
    if [[ $delay =~ ^[0-9]+[smh]$ ]]; then
        echo "La machine sera éteinte dans $delay"
        sleep $delay
        sudo shutdown -h now
    else
        echo "Délai invalide !"
    fi
}

# Fonction pour mettre en veille la machine après un délai
suspend_machine() {
    echo "Entrez le délai avant la mise en veille (en secondes, minutes ou heures, ex: 10s, 5m, 1h) :"
    read delay

    # Vérifier si le délai est un nombre valide
    if [[ $delay =~ ^[0-9]+[smh]$ ]]; then
        echo "La machine sera mise en veille dans $delay"
        sleep $delay
        sudo systemctl suspend
    else
        echo "Délai invalide !"
    fi
}

# Boucle principale du script
while true; do
    display_menu
    read choice

    case $choice in
        1)
            shutdown_machine
            ;;
        2)
            suspend_machine
            ;;
        3)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix invalide !"
            ;;
    esac
done

