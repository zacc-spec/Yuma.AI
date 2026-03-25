# Tilt Configuration for Yuma.AI Development
# Run: tilt up

# Set default namespace
namespace = 'yuma-ai'
load('ext://restart_process', 'docker_build_with_restart')

# Backend Service
docker_build(
    ref='docker-backend',
    context='./backend',
    dockerfile='./backend/Dockerfile',
    target='backend',
    only=[
        './backend/main.py',
        './backend/requirements.txt',
        './backend/.env.example',
    ],
    entrypoint=['python', 'main.py'],
    build_args={
        'PYTHONUNBUFFERED': '1'
    }
)

k8s_yaml('packages/kubernetes/03-backend-deployment.yaml')
k8s_yaml('packages/kubernetes/04-backend-service.yaml')

k8s_resource(
    'yuma-backend',
    port_forwards='5000:5000',
    labels=['backend'],
)

# Frontend Service
docker_build(
    ref='docker-frontend',
    context='./frontend',
    dockerfile='./frontend/Dockerfile',
    target='frontend',
    only=[
        './frontend/src',
        './frontend/public',
        './frontend/index.html',
        './frontend/package.json',
        './frontend/vite.config.js',
    ]
)

k8s_yaml('packages/kubernetes/05-frontend-deployment.yaml')
k8s_yaml('packages/kubernetes/06-frontend-service.yaml')

k8s_resource(
    'yuma-frontend',
    port_forwards='3000:3000',
    labels=['frontend'],
)

# Namespace
k8s_yaml('packages/kubernetes/01-namespace.yaml')

# ConfigMap
k8s_yaml('packages/kubernetes/02-configmap.yaml')

# Summary
print("╔════════════════════════════════════════╗")
print("║     YUMA.AI TILT CONFIGURATION         ║")
print("╚════════════════════════════════════════╝")
print("")
print("Backend:  http://localhost:5000")
print("Frontend: http://localhost:3000")
print("")
print("Run: tilt up")
print("Stop: tilt down")
print("View logs: tilt logs yuma-backend")
