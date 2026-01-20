# DevOps Demo Project

A simple Flask app with full DevOps infrastructure around it.

## What's in here

- Flask API with health check endpoint
- Dockerfile
- GitHub Actions CI/CD pipeline
- Terraform for AWS EC2
- Kubernetes deployment
- Prometheus + Grafana monitoring
- Some bash scripts for automation

## Quick start

Run the app locally:
```
cd app
pip install -r requirements.txt
python app.py
```

Run with Docker:
```
docker build -t devops-demo .
docker run -p 5000:5000 devops-demo
```

Check it works:
```
curl http://localhost:5000
curl http://localhost:5000/health
```

## Kubernetes

```
kubectl apply -f k8s/
kubectl get pods
```

## Monitoring

```
cd monitoring
docker-compose up -d
```

Then open:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (admin/admin)

## Terraform

```
cd terraform
terraform init
terraform plan -var="key_name=your-key"
terraform apply -var="key_name=your-key"
```

## Tests

```
cd app
pytest
```

## Folder structure

```
app/           - flask app
terraform/     - aws infra
k8s/           - kubernetes manifests
monitoring/    - prometheus and grafana
scripts/       - automation scripts
```

That's it.
