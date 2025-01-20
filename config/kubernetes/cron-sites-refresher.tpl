apiVersion: batch/v1
kind: CronJob
metadata:
  name: sites-refresher
spec:
  schedule: "0,5,10,15,20,25,30,35,40,45,50,55 * * * *"
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 1
  failedJobsHistoryLimit: 3
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
            - command:
              - /bin/sh
              - "-c"
              - "bin/rails runner 'SitesRefreshJob.perform_later'"
              name: sites-refresher
              image: ${ECR_URL}:${IMAGE_TAG}
              imagePullPolicy: IfNotPresent
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
                    name: app-secretsname: app-secrets
