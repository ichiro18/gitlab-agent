{{/*
Expand the name of the chart.
*/}}
{{- define "gitlab-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gitlab-agent.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gitlab-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gitlab-agent.labels" -}}
helm.sh/chart: {{ include "gitlab-agent.chart" . }}
{{ include "gitlab-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gitlab-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gitlab-agent.name" . }}
app: {{ include "gitlab-agent.name" . }}
{{- end }}

{{/*
Secret Name
*/}}
{{- define "gitlab-agent.secretName" -}}
{{- if .Values.config.secretName }}
{{- .Values.config.secretName }}
{{- else }}
{{- printf "%s-token" (include "gitlab-agent.fullname" .) -}}
{{- end }}
{{- end }}

{{/*
Observability TLS Secret Name
*/}}
{{- define "gitlab-agent.observabilitySecretName" -}}
{{- $name := (((.Values.config.observability).tls).secret).name }}
{{- if $name }}
{{-   $name }}
{{- else }}
{{-   printf "%s-observability" (include "gitlab-agent.fullname" .) -}}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gitlab-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gitlab-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
