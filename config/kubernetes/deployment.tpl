apiVersion: apps/v1
kind: Deployment
metadata:
  name: cdpt-deploys-dashboard
spec:
  replicas: 1
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 100%
      maxUnavailable: 50%
  selector:
    matchLabels:
      app: cdpt-deploys-dashboard
  template:
    metadata:
      labels:
        app: cdpt-deploys-dashboard
    spec:
      containers:
        - name: webapp
          imagePullPolicy: Always
          image: ${ECR_URL}:${IMAGE_TAG}
          ports:
            - containerPort: 3000
          command: ["./config/docker/entrypoint-webapp.sh"]
          env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: rds-postgresql-instance-output
                  key: url
          envFrom:
            - configMapRef:
                name: environment-variables
            - secretRef:
                name: app-secrets
          livenessProbe:
            httpGet:
              path: /up
              port: 3000
              httpHeaders:
                - name: X-Forwarded-Proto
                  value: https
                - name: X-Forwarded-Ssl
                  value: "on"
            periodSeconds: 10
            timeoutSeconds: 10
