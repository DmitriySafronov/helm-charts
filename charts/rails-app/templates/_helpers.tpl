{{/*
Expand the name of the chart.
*/}}
{{- define "rails-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rails-app.fullname" -}}
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
{{- define "rails-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rails-app.labels" -}}
helm.sh/chart: {{ include "rails-app.chart" . }}
{{ include "rails-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rails-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rails-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rails-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rails-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified headless svc name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rails-app.svc-headless-name" -}}
{{- if .Values.fullnameOverride }}
{{- printf "%s-hl" (.Values.fullnameOverride | trunc 60 | trimSuffix "-") }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-hl" (.Release.Name | trunc 60 | trimSuffix "-") }}
{{- else }}
{{- printf "%s-hl" (printf "%s-%s" .Release.Name $name | trunc 60 | trimSuffix "-") }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Migration job name.
*/}}
{{- define "rails-app.migration-job-name" -}}
{{- printf "%s-migration" (default .Chart.Name .Values.nameOverride | trunc 53 | trimSuffix "-") }}
{{- end }}

/* ---------------------- */
/* sidekiq */

{{- define "rails-app.name.sidekiq" -}}
{{- if .Values.fullnameOverride }}
{{- printf "%s-sidekiq" (.Values.fullnameOverride | trunc 55 | trimSuffix "-") }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "%s-sidekiq" (.Release.Name | trunc 55 | trimSuffix "-") }}
{{- else }}
{{- printf "%s-sidekiq" (printf "%s-%s" .Release.Name $name | trunc 55 | trimSuffix "-") }}
{{- end }}
{{- end }}
{{- end }}

{{- define "rails-app.selectorLabels.sidekiq" -}}
app.kubernetes.io/name: {{ include "rails-app.name.sidekiq" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "rails-app.labels.sidekiq" -}}
helm.sh/chart: {{ include "rails-app.chart" . }}
{{ include "rails-app.selectorLabels.sidekiq" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
