# On change le nom de l'hôte 
hostname set-hostname "desktop"

# On modifie les informations de la carte ! 
nmcli c modify enp0s3 ipv4.dns "8.8.8.8"
nmcli c modify enp0s3 ipv4.gateway "127.16.0.1"
nmcli c modify enp0s3 ipv4.addresses "127.16.0.30/34"

# On arrête la carte réseau 
nmcli c down enp0s3

# On relance la carte réseau pour qu'elle prenne les 
# nouvelles informations (modifications)
nmcli c up enp0s3


# On créee l'utilisateur tonton 
useradd tonton 

# On change le mot de passe de l'utilisateur tonton 
passwd tonton 

# On change d'utilisateur 
su tonton 

# On change de repertoire, on va vers le ~ de l'utilisateur courant 
cd 

# On liste le contenu du dossier courant en details 
ls -la 

# On se reconnecte en tant qu'utilisateur ROOT
su root 

# On crée le groupe étudiants 
groupadd etudiants 

# On crée le groupe professeurs 
groupadd professeurs 

# On crée un dossier professeurs dans home 
mkdir -p /home/professeurs

# On crée un dossier etudiants dans home 
mkdir -p /home/etudiants 

## On test si les dossiers ont bien été créés  
ls -la /home/

# On crée le dossier de l'utilisateur kutangila 
mkdir -p /home/professeurs/kutangila

# On crée le dossier de l'utilisateur kasereka 
mkdir -p /home/etudiants/kasereka

# On vérifie si le dossier kasereka a été créé 
ls -la /home/etudiants 

# On vérifie si le dossier kutangila a été créé 
ls -la /home/professeurs

# On crée l'utilisateur kutangila dans son repertoire 
useradd -d /home/professeurs/kutangila -g professeurs kutangila

# On envoie les configurations du PC au nouveau user 
cp -r /etc/skel/. /home/professeurs/kutangila

# On crée l'utilisateur kutangila dans son repertoire 
useradd -d /home/etudiants/kasereka -g etudiants kasereka

# On envoie les configurations du PC au nouveau user 
cp -r /etc/skel/. /home/etudiants/kasereka

# On change le mot de passe du user kutangila 
passwd kutangila 

# On change le mot de passe du user kasereka 
passwd kasereka


# On se connecte avec le tout premier compte d'utilisateur 
su jarvis # jarvis est un exemple, vous, vous mettez le vôtre 

# On se place dans le repertoire courant de ce user 
cd 

# On créé le fichier cours.cvs dans le dossier etudiants 
touch cours.cvs

# [ facultatif ] On écrit un truc dans le fichier 
vi cours.cvs
# on appui sur i pour activer le mode insertion 
# Escape ou Echape 
# puis on tape :x 

# On se reconnecte en tant qu'utilisateur ROOT 
su root 

# On crée un lien symbolique 
ln -s /home/jarvis/cours.cvs /home/etudiants/

# On attribute le dossier professeurs au groupe professeurs 
chgrp professeurs /home/professeurs

# On attribute le dossier etudiants au groupe etudiants 
chgrp etudiants /home/etudiants

# On change le proprietaire du dossier kutangila 
chown kutangila /home/professeurs/kutangila

# On change le proprietaire du dossier kasereka 
chown kasereka /home/etudiants/kasereka

# Afficher les droits sur les dossiers etudiants 
ls -la /home/
ls -la /home/etudiants

# Afficher les droits sur les dossiers professeurs 
ls -la /home/ 
ls -la /home/professeurs




