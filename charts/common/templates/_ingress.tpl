{{- define "common.ingress" -}}
{{- if .Values.ingress.enabled -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    app: {{ include "common.names.fullname" . }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
    release: "{{ .Release.Name }}"
    heritage: "{{ .Release.Service }}"
  annotations:
    kubernetes.io/tls-acme: "true"
    {{- toYaml .Values.ingress.annotations | nindent 4 }}
spec:
  rules:
    - host: {{ .Values.ingress.host }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: {{ include "common.names.fullname" . }}
                port:
                  number: 80
  tls:
  - secretName: {{ include "common.names.name" . }}-cert
    hosts:
    - {{ .Values.ingress.host }}
{{- end -}}
{{- end -}}
