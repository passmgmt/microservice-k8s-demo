{{- define "microservice-k8s-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "microservice-k8s-demo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name (include "microservice-k8s-demo.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
