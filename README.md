# Elastic stack (ELK) on Docker

Ce repo contient la stack Docker pour avoir une stack ELK (Elasticseach, Logstash, Kibana).

C'est un fork de [deviantony/docker-elk][docker-elk]. La branche `master` est toujours
présente sur le repo afin de conserver les données originale si quelque chose vient à planter. Cela permettra aussi
de faire plus facilement une mise à jour si besoin.

## ELK ?

Pour rappel, une stack ELK permet de receptionner les logs envoyés, les traiter et les ressortir via une UI. Les logs 
sont traités par Logstash qui se charge de les parser correctement, puis il les stock dans Elasticsearch et il est
possible de les consulter via Kibana. 

Les logs sont envoyés à Logstash via Filebeat qui est installé directement sur la machine produisant les logs.

## Modifications

Nous avons modifié certaines choses pour correspondre à nos besoins. La principale modification réside dans 
[logstash/pipeline/logstash.conf](./logstash/pipeline/logstash.conf) qui contient la configuration et surtout les
règles concernant le parsing des logs.

## Installation

Pour lancer la stack, il suffit de faire `make install` et le système va se charger de pull, build et lancer les images
Docker.

## Reverse proxy

Dans le fichier [docker-compose.yml](./docker-compose.yml) il y a plusieurs variable d'environnement concernant des
domaines et des adresses emails pour Let's Encrypt. Cela permet au [reverse proxy][reverse-proxy] de fonctionner
correctement.

Nous recommandons l'urilisation du reverse proxy développé par [evertramos][reverse-proxy] qui permet d'avoir une
surcouche SSL avec des certificats générés et renouvelés automatiquement. L'utilisation est très simple et rapide.

Il faut cependant bien penser à mettre le même network entre le reverse proxy et la stack ELK. Pour info le network 
actuel est `elk`.

## Sécurité

Le mot de passe d'Elasticsearch est présent dans le fichier `.env` et il vous sera demandé lors de votre installation.
Le nom d'utilisateur doit rester `elastic` afin de ne pas poser de soucis de connexion entre les différents services.

Afin de rajouter une surcouche de sécurité, il est important de paramétrer le firewall du serveur pour n'autoriser que
certaines adresses IP.

Cela à plusieurs enjeux :
1. Sécuriser l'accès à Kibana et éviter les intrusions extérieures à la société
1. Sécuriser la réception des données par Logstash

La sécurité de Logstash est la plus importante. Si Logstash n'est pas sécurisé, n'importe qui va pouvoir nous pousser
des logs sur l'URL de collecte de Logstash. Il va ainsi pouvoir nous flooder de logs et faire grossir considérablement
notre espace disque.

[docker-elk]: https://github.com/deviantony/docker-elk
[reverse-proxy]: https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion
