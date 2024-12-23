# Mindshift-Technologies CI/CD Pipeline Setup

This repository demonstrates the creation of a robust CI/CD pipeline integrating **Jenkins**, **GitHub**, **Docker**, and **Kubernetes** to automate build, test, and deployment processes. Follow the steps below to replicate the setup on your system.

---

## Prerequisites
Before proceeding, ensure the following tools are installed and configured on your system:

1. **Git**: For version control and repository management.
2. **Docker**: To containerize your application.
3. **Jenkins**: For CI/CD pipeline automation.
4. **Kubernetes (kubectl + Minikube)**: For container orchestration.
5. **A GitHub Account**: To host the repository.

---

## Repository Contents
This repository contains:

- **`Jenkinsfile`**: Defines the pipeline steps for Jenkins.
- **`Dockerfile`**: Instructions to build the Docker image for the application.
- **Application Source Code**: Includes the necessary files to run the application.

---

## Step-by-Step Guide

### **Step 1: Clone the Repository**
Clone this repository to your local system:

```bash
git clone https://github.com/arnav108276/Mindshift-Technologies.git
cd Mindshift-Technologies
```

### **Step 2: Install and Start Jenkins**
1. **Download Jenkins** from [Jenkins official site](https://www.jenkins.io/).
2. **Start Jenkins**:
   ```bash
   java -jar jenkins.war
   ```
   Access Jenkins at `http://localhost:8080`.

3. **Install Required Plugins**:
   - Docker Pipeline
   - Kubernetes Plugin
   - Git Plugin

### **Step 3: Configure GitHub Repository in Jenkins**
1. Create a new **Freestyle Project** or **Pipeline** in Jenkins.
2. Configure the project to use **Pipeline Script from SCM**:
   - Repository URL: `https://github.com/arnav108276/Mindshift-Technologies.git`
   - Branch: `main`

### **Step 4: Create a Dockerfile**
The `Dockerfile` in this repository defines how to containerize the application. Ensure it is present in the root directory.

**Example Dockerfile:**
```dockerfile
FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 80
CMD ["npm", "start"]
```

### **Step 5: Create the Jenkins Pipeline**
1. Add a `Jenkinsfile` to the repository to define the pipeline steps:

**Example Jenkinsfile:**
```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/arnav108276/Mindshift-Technologies.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('mindshift-image')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials') {
                        docker.image('mindshift-image').push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
```

### **Step 6: Kubernetes Configuration**
1. Create a `deployment.yaml` file for Kubernetes deployment:

**Example deployment.yaml:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mindshift-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: mindshift
  template:
    metadata:
      labels:
        app: mindshift
    spec:
      containers:
      - name: mindshift-container
        image: mindshift-image:latest
        ports:
        - containerPort: 80
```

2. Deploy the application:
   ```bash
   kubectl apply -f deployment.yaml
   ```

3. Verify the deployment:
   ```bash
   kubectl get pods
   ```

### **Step 7: Test the Pipeline**
1. Trigger the pipeline in Jenkins.
2. Verify each stage (clone, build, push, deploy).
3. Check the application running in Kubernetes:
   ```bash
   minikube service mindshift-deployment
   ```

---



---

## Conclusion
This repository demonstrates a complete CI/CD pipeline integrating Jenkins, Docker, GitHub, and Kubernetes to streamline development and deployment. For questions or contributions, feel free to open an issue or fork the repository.
