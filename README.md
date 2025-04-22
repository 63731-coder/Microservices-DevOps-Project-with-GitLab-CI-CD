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
