{{- define "common.service" -}}
{{- if .Values.service.enabled -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
spec:
  ports:
  - name: {{ include "common.names.fullname" . }}
    port: 80
    targetPort: {{ .Values.deployment.port | int }}
    
  selector:
    app: {{ include "common.names.fullname" . }}

{{- end -}}
{{- end }}