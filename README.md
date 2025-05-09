# Scénario DevOps – Microservices + CI/CD
63731 - D112
---

Ce projet DevOps contient deux microservices conteneurisés avec Docker, et un pipeline CI/CD configuré avec GitLab.

---
## Microservices

### 1. Java Spring Boot
- Port : `8080`
- Fichier principal : `app.jar` (généré par Maven)
- Compilation : `mvn clean package`
- Variable d’environnement : `FLASK_URL`

### 2. Python Flask
- Port : `5000`
- Route principale : `/api/message` → `"Hello from Flask!"`
- Lancement : `python app.py`


---
## Conteneurisation (Partie 1)

Chaque service possède un **Dockerfile** :
- `Dockerfile` dans `service-java/`
- `Dockerfile` dans `service-python/`

### Lancement local :
```bash
docker compose up --build
```
## Intégration Continue – GitLab CI/CD (Partie 2)

Le fichier `.gitlab-ci.yml` contient la configuration du pipeline.

### Jobs définis :
| Étape   | Job           | Description                                       |
|---------|---------------|-------------------------------------------------- |
| build   | `build-java`  | Compile le service Spring Boot avec Maven         |
| test    | `test-python` | Installe les dépendances et lance les tests Flask |

> Le pipeline s’exécute automatiquement à chaque `git push`.

### Runner :
Un **runner local Docker sous WSL** est utilisé pour exécuter les jobs CI/CD sur une machine personnelle.


### Fonctionnement du pipeline

- **Déclenchement** : le pipeline démarre automatiquement à chaque `git push` sur la branche `main`.
- **Étapes** :
  1. **build** → compile le service Java (`build-java`)
  2. **test** → teste le service Flask (`test-python`)
- **Runner** : le pipeline utilise un runner local Docker configuré sous WSL2 (Windows), enregistré manuellement via `gitlab-runner register`.
- **Images Docker utilisées** :
  - `maven:3.9-eclipse-temurin-17` pour Java
  - `python:3.11-slim` pour Flask
- **Objectif** : vérifier que chaque microservice est compilable, testable, et prêt à être déployé.


## Infrastructure Cloud – Azure avec Terraform (Partie 3)

### Objectif

Déployer l'infrastructure nécessaire sur **Microsoft Azure** pour héberger les deux microservices conteneurisés (Java Spring Boot et Python Flask) à l'aide de **Terraform**.

---

### Ressources Azure créées automatiquement

La configuration Terraform déployée dans le dossier `terraform/` permet de créer les ressources suivantes sur Azure :

| Ressource                          | Description                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|
| `azurerm_resource_group`          | Groupe de ressources nommé `rg-microservices-app`                          |
| `azurerm_container_registry`      | Registre privé ACR `scenarioregistry63731` pour stocker les images Docker |
| `azurerm_user_assigned_identity`  | Identité managée pour les Web Apps Azure                                   |
| `azurerm_role_assignment`         | Attribution du rôle `AcrPull` à l'identité pour accéder à l’ACR            |
| `azurerm_service_plan`            | Plan App Service Linux (B1) utilisé par les Web Apps                       |
| `azurerm_linux_web_app` (x2)      | Deux Web Apps pour exécuter les conteneurs Docker des services             |

---

### Structure des fichiers Terraform

| Fichier              | Rôle                                                                 |
|----------------------|----------------------------------------------------------------------|
| `main.tf`            | Définition des ressources Azure                                      |
| `variables.tf`       | Variables personnalisables (noms, ports, images, credentials)        |
| `providers.tf`       | Configuration du provider Azure avec service principal               |
| `outputs.tf`         | Affiche les URLs finales des applications après déploiement          |

---

### Déploiement manuel avec Terraform

#### Pré-requis

- Terraform ≥ 1.3
- Azure CLI (`az login`)
- Images Docker préalablement **poussées** sur ACR (`docker push`)

#### Étapes

1. Initialiser le projet Terraform :

   ```bash
   cd terraform/
   terraform init

2. Importer les ressources déjà existantes si nécessaire :

   ```bash
   terraform import azurerm_resource_group.rg /subscriptions/xxx/resourceGroups/rg-microservices-app
    terraform import azurerm_container_registry.acr /subscriptions/xxx/resourceGroups/rg-microservices-app/providers/Microsoft.ContainerRegistry/registries/scenarioregistry63731
    terraform import azurerm_user_assigned_identity.identity /subscriptions/xxx/resourceGroups/rg-microservices-app/providers/Microsoft.ManagedIdentity/userAssignedIdentities/container-app-identity

3. Vérifier le plan :

   ```bash
   terraform plan

4. Appliquer le déploiement :

   ```bash
   terraform apply

Le script déploiera automatiquement les 2 services sur Azure App Service, en important leurs images depuis l’ACR.

## Vérification post-déploiement
Accès au service Flask :

  ```bash
   https://mon-app-python-63731.azurewebsites.net/api/message 
  ```
   

Doit afficher :
  ```bash
  Hello from Flask!
```
Accès au service Flask :

  ```bash
   https://mon-app-java-63731.azurewebsites.net/proxy
    
  ```
   

Doit afficher :
  ```bash
  Hello from Flask!
```

Sinon :
```bash
   Service Flask injoignable !
    
  ```



## Déploiement Continu – GitLab CI + Azure CLI (Partie 4)
### Objectif
Automatiser le déploiement des images Docker sur Azure App Service après compilation, à l’aide d’un runner GitLab configuré avec Docker-in-Docker et Azure CLI.

```
[runners.docker]
  image = "alpine:latest"
  privileged = true
  volumes = ["/cache"]...
  ```

privileged = true est indispensable pour lancer un docker:dind (Docker-in-Docker).

