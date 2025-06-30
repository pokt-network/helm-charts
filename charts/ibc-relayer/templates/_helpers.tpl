{{/*
Expand the name of the chart.
*/}}
{{- define "ibc-relayer.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ibc-relayer.fullname" -}}
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
{{- define "ibc-relayer.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ibc-relayer.labels" -}}
helm.sh/chart: {{ include "ibc-relayer.chart" . }}
{{ include "ibc-relayer.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ibc-relayer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ibc-relayer.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ibc-relayer.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ibc-relayer.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Import a key into hermes
*/}}
{{- define "ibc-relayer.hermesKeysAdd" -}}
    {{- if .coin_type }}
    /root/.hermes/bin/hermes keys add --chain {{ .name }} --mnemonic-file /root/.hermes/{{ .name }}.mnemonic --hd-path "m/44'/{{ .coin_type }}'/0'/0/0"
    {{- else }}
    /root/.hermes/bin/hermes keys add --chain {{ .name }} --mnemonic-file /root/.hermes/{{ .name }}.mnemonic
    {{- end }}
{{- end -}}
