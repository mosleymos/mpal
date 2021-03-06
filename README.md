[![Build status](https://circleci.com/gh/sgmap/mpal.svg?style=shield&circle-token=50a0754f6e164ff97a3f479374102a568b750847)](https://circleci.com/gh/sgmap/mpal/tree/dev)

# mpal

Nom temporaire du produit : Mon Projet Amélioration du Logement

# Fiche Produit

Vous reculez devant un projet d'amélioration de votre logement pourtant nécessaire
à votre santé et votre confort, car la complexité des démarches vous effraie: vous ne savez pas à qui vous adresser, vous êtes noyé sous des informations contradictoires, vous ne savez pas évaluer le coût restant de votre poche, vous ne savez pas combien de temps cela prendra.

1. MPAL: on vous accompagne, du début de votre besoin au paiement de la subvention
2. MPAL: vous êtes accompagné de bout en bout par les intervenants compétents
3. MPAL rassemble autour de votre projet toutes les compétences pour le faire aboutir

Grâce à MPAL, votre projet prend vie en quelques minutes:
- chez vous, 24/7 par Internet
- par téléphone auprès de notre réseau d'opérateurs

A partir de ce moment, vous êtes accompagnés:

1. vous êtes orienté vers un interlocuteur compétent et proche de vous - dans votre département
2. vous êtes conseillés dans votre projet selon votre situation et vos besoins
3. vous recevez une évaluation personnalisée des aides auxquelles vous pouvez prétendre
4. vous ne fournissez que les justificatifs strictement nécessaires: pas de paperasse inutile
5. sans garantie de percevoir une subvention, vous pouvez démarrer vos travaux dès le dépôt du dossier confirmé
6. vous êtes informé en permanence de l'avancement de votre projet et des délais prévisibles
7. vous êtes accompagné jusqu'au bout de votre projet et au versement des subventions

MPAL est la plateforme pour l'amélioration du logement qui réunit tous les acteurs et toutes les compétences,
au service de votre projet.

# Installation (avec Docker)

```shell
cp config/database.yml{.sample,}
cp .env{.sample,}
docker-compose run mpal db:setup
docker-compose run mpal db:setup RAILS_ENV=test`
docker-compose up

docker-compose run mpal rake intervenants:charger
```

# Installation (sans passer par Docker)

Pré-requis : ce projet nécessite un serveur PostgreSQL et un serveur Redis lancés localement.

## Configurer l'environnement

```shell
# Création des fichiers de configuration
cp .env.sample .env
cp config/database.yml.sample config/database.yml
# Création de l'utilisateur de la base de données
# (mot de passe : `mpal`)
createuser --superuser --createdb mpal
# Création de la base de données
rake db:setup
rake db:seed
```

## Lancer le projet

```shell
foreman start
```

# Notes

Kanban Zenhub sur ce projet

# UX / UI

https://projects.invisionapp.com/share/DK96M9YUB#/screens

# Wiki

https://github.com/sgmap/mpal/wiki

# Api utilisées (Voir dossier `app/services`)

## Api particulier
- https://particulier.api.gouv.fr/tech/#introduction
- https://particulier.api.gouv.fr/docs/

Exemple de requête :

curl "https://particulier-test.api.gouv.fr/api/impots/svair?numeroFiscal=12&referenceAvis=15" \
  -H "X-API-KEY: test-token" \
  -H "accept: application/json" \
  -H "X-User: demo"

## Api ban

- https://adresse.data.gouv.fr/api/
