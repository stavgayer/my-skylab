{{/*
Compute clusterMaxWorkers as the sum of per-pod-type max workers.
*/}}
{{- define "ray.clusterMaxWorkers" -}}
{{- $total := .Values.head.maxWorkers }}
{{- range .Values.workers }}
{{- $total = add $total .maxWorkers }}
{{- end }}
{{- $total }}
{{- end }}
