{{- define "common.deployment" -}}
{{- if .Values.deployment.enabled -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
spec:
  selector:
    matchLabels:
      app: {{ include "common.names.fullname" . }}
  replicas: {{ default 1 .Values.deployment.replicaCount | int }}
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: {{ include "common.names.fullname" . }}
    spec:
      containers:
      - name: {{ include "common.names.fullname" . }}
        image: {{ .Values.deployment.image }}
        imagePullPolicy: Always
        ports:
        - containerPort: {{ .Values.deployment.port | int }}
        env:
        {{- toYaml .Values.deployment.env | nindent 8 }}
        volumeMounts:
        {{- if .Values.storage.mounts.config.enabled }}
        - name: {{ include "common.names.name" . }}-config
          mountPath: /config
        {{- end }}  
        {{- if .Values.storage.mounts.media.enabled }}
        - name: {{ include "common.names.name" . }}-media
          mountPath: /media
        {{- end }}
      volumes:
      {{- if .Values.storage.mounts.config.enabled }}
      - name: {{ include "common.names.name" . }}-config
        persistentVolumeClaim:
          claimName: {{ include "common.names.name" . }}-config
      {{- end }}
      {{- if .Values.storage.mounts.media.enabled }}
      - name: {{ include "common.names.name" . }}-media
        nfs:
          server: "{{ .Values.storage.mounts.media.volume.nfs.server }}"
          path: "{{ .Values.storage.mounts.media.volume.nfs.path }}"
      {{- end }}
{{- end }}
{{- end }}