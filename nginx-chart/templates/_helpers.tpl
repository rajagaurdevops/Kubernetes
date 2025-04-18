{{/*
Return the name of the chart
*/}}
{{- define "my-nginx-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Return the full name of the release
*/}}
{{- define "my-nginx-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
