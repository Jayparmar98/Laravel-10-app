PROJECT consistent

==============================================================
Directory structure
==============================================================

├── app1/
│   ├── Dockerfile
│   └── (Laravel project files)
│
├── app2/
│   ├── Dockerfile
│   └── (Laravel project files)
│
├── mysql/
│   ├── Dockerfile
│   └── init.sql
│
├── redis/
│   ├── Dockerfile
│   └── redis.conf
│
├── k8s/
│   ├── app1-deployment.yaml
│   ├── app2-deployment.yaml
│   ├── mysql-deployment.yaml
│   ├── redis-deployment.yaml
│   └── configmaps/
│       └── mysql-init-configmap.yaml
│
└── Jenkinsfile

==============================================================
Explanation
==============================================================

📦 app1/ and app2/
These directories hold your two separate Laravel 10 applications.
Dockerfile: Defines how to build the Docker image for each Laravel app. Typically includes PHP, Composer, Nginx, Node (for asset compilation), and Laravel-specific build steps like composer install, php artisan migrate, etc.
(Laravel project files): The actual Laravel application codebase including routes, controllers, models, artisan, etc.
Each app is independently containerized and deployed to a unique namespace or under its own deployment in Kubernetes.

🐬 mysql/
A custom MySQL image directory with initialization logic.
Dockerfile: Builds a MySQL image possibly pre-configured with custom settings, users, and permissions.
init.sql: A bootstrap SQL file to create initial databases, users, or tables needed for app1 and app2.
Useful for maintaining consistent development or testing environments with preloaded schema.

🌀 redis/
A custom Redis image with a tailored configuration.
Dockerfile: Used to build a Redis container image with custom redis.conf.
redis.conf: Custom configuration such as persistence settings, password protection, or performance tuning.
Shared Redis for both applications, allowing things like centralized cache, queue, and session handling.

☸️ k8s/
Contains all Kubernetes manifests needed for deployment.
app1-deployment.yaml: Kubernetes Deployment + Service + Ingress (optional) for app1.
app2-deployment.yaml: Same structure for app2.
mysql-deployment.yaml: Defines the deployment, PVC (PersistentVolumeClaim), and service for the MySQL pod.
redis-deployment.yaml: Deploys the Redis service and container to Kubernetes.
configmaps/: Stores configuration files and environment-specific variables.
mysql-init-configmap.yaml: Mounts the init.sql into the MySQL pod at runtime using a ConfigMap, enabling DB initialization without baking SQL into the image.

⚙️ Jenkinsfile
Defines your Jenkins CI/CD pipeline.
Builds Docker images for app1, app2, and custom services.
Pushes images to a registry (local or remote).
Applies Kubernetes manifests using kubectl.
May include rollback, health checks, Laravel-specific commands like php artisan migrate, horizon, and queue:restart.
Automates environment-specific steps for development or production.

🔄 Example Workflow
Jenkins watches for commits on your Git repo.
Jenkinsfile triggers:
Docker builds for app1/app2/mysql/redis.
Kubernetes deployments using YAML manifests.
init.sql runs on first MySQL pod startup to initialize databases.
Laravel apps connect to shared MySQL and Redis.



