{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "common.all" -}}

  {{- include "common.values.setup" . }}

  {{ include "common.volume" . | nindent 0 }}
  
  {{ include "common.deployment" . | nindent 0 }}
  
  {{ include "common.service" . | nindent 0 }}

  {{ include "common.ingress" .  | nindent 0 }}

{{- end -}}