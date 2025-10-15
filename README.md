A simple web game project with Docker and GitHub Actions CI/CD workflow "60 second game"

Web Game — CI/CD Pipeline (GitHub Actions + Docker)
Overview

This repository demonstrates a compact, production-minded CI/CD pipeline for a single-file static web game (index.html) using GitHub Actions and Docker. The pipeline builds the Docker image, runs automated health checks, and deploys the verified image to a local container (localhost) to present a full “build → test → deploy” workflow suitable for a DevOps portfolio.

Repository structure
fin60/
├── .github/
│   └── workflows/
│       └── cicd.yml
├── .dockerignore
├── Dockerfile
├── index.html
└── README.md

Prerequisites

Install these tools on the machine where you will run the commands or where the runner must be prepared:

Docker (Docker Engine / Docker Desktop)

Git (for cloning or working with the repository)

curl (used by the workflow for health checks; available on most Linux distros)

How to run locally (manual steps)

These commands build and run the same image used by the CI pipeline.

Build the image:

docker build -t web-game .


Run the container on port 80 (host):

docker run -d --name web-game -p 80:80 web-game


Verify in the browser:

http://localhost


Stop & remove (when you want to remove the running deployment):

docker stop web-game
docker rm web-game

CI/CD workflow (summary)

The workflow file is .github/workflows/cicd.yml. It performs:

Checkout repository.

Build Docker image (web-game).

Launch a temporary test container and wait briefly.

Run an HTTP health check (curl) expecting HTTP 200.

Remove the temporary test container.

Deploy the tested image to a new container bound to port 80 (localhost) — this represents the final deployment step in the pipeline.

This demonstrates the principle build once, test once, deploy the same image.

Common issues & troubleshooting

Docker daemon not running — Ensure Docker is started before building or running images.

Port conflict on 80 — If port 80 is in use, change host mapping (e.g., -p 8080:80) and update health checks accordingly.

Workflow YAML errors — YAML is indentation sensitive; validate the workflow file if GitHub Actions fails to parse it.

Health check fails locally but succeeds in pipeline — Compare host mapping and container network options (--network host vs -p); the pipeline uses the runner’s networking model.

Recommendations / next steps (optional)

Push built images to a container registry (Docker Hub or GHCR) for visibility and reuse.

Add an automated rollback step or versioned tagging before production deployment.

Add deployment to a persistent environment (cloud VM or PaaS) if you want an externally reachable demo.
