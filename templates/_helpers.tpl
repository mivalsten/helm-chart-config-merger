{{- define "helper.calculatedValues" -}}
    {{- $empty := dict "values" dict -}}
    {{- $common := .Values.config.values -}} 
    {{- $env := .Values.env -}}
    {{- $reg := .Values.region -}}
    {{- $zone := .Values.zone -}}
    {{- $envVals := get .Values.config $env | default $empty -}}
    {{- $regVals := get $envVals $reg | default $empty -}}
    {{- $zoneVals := get $regVals $zone | default dict -}}

#envVals
{{/* $envVals | toYaml }}
---
#regVals
{{ $regVals | toYaml }}
---
#zoneVals
{{ $zoneVals | toYaml */}}

#final config
{{ mergeOverwrite 
    ($common | default dict)
    ($envVals.values | default dict)
    ($regVals.values | default dict)
    $zoneVals | toYaml }}

{{- end -}}