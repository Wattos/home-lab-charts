{{- define "common.volume" -}}
{{- if .Values.storage.mounts.config.enabled }}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "common.names.name" . }}-config
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "{{ .Values.storage.mounts.config.storageClassName }}"
  resources:
    requests:
      storage: "{{ .Values.storage.mounts.config.size }}"
{{- end -}}
{{- end }}