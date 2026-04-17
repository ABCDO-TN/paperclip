#!/bin/bash

# Vérifier si gcloud est déjà installé
if command -v gcloud &> /dev/null
then
    echo "✅ Google Cloud CLI est déjà installé sur ce système."
    gcloud --version
    exit 0
fi

echo "⚠️ Google Cloud CLI n'est pas trouvé. Début de l'installation..."

# Détecter le système d'exploitation
OS="$(uname -s)"
case "${OS}" in
    Linux*)     
        echo "Installation pour Linux..."
        curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
        tar -xf google-cloud-cli-linux-x86_64.tar.gz
        ./google-cloud-sdk/install.sh --quiet
        ;;
    Darwin*)    
        echo "Installation pour macOS..."
        curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz
        tar -xf google-cloud-cli-darwin-x86_64.tar.gz
        ./google-cloud-sdk/install.sh --quiet
        ;;
    *)          
        echo "❌ Système d'exploitation non supporté par ce script d'installation automatique."
        echo "Veuillez télécharger et installer Google Cloud SDK manuellement pour Windows depuis : https://cloud.google.com/sdk/docs/install"
        exit 1
        ;;
esac

echo "✅ Installation terminée. N'oubliez pas de redémarrer votre terminal ou d'exécuter la commande de source pour mettre à jour votre PATH."