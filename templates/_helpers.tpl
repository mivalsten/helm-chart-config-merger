{{- define "helper.RegionsAndZones" -}}
    {{- $keys := .Keys -}}
    {{- $ret := list -}}
    {{- range $elem := $keys -}}
        {{- if regexMatch "^R.*" $elem -}}
            {{- $ret = append $ret $elem -}}
        {{- else if regexMatch "^zone.*" $elem -}}
            {{- $ret = append $ret $elem -}}
        {{- end -}}
    {{- end -}}
    {{- $ret -}}
{{- end -}}

{{- define "helper.calculatedValues" -}}
    {{- $empty := dict "values" dict -}}
    {{- $common := .Values.config -}} 
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
{{ $merged := mergeOverwrite 
    ($common | default dict)
    ($envVals | default dict)
    ($regVals | default dict)
    $zoneVals }}

{{- $allKeys := keys $merged -}}
{{- $keysToRemove := list -}}
{{- range $elem := $allKeys -}}
    {{- if regexMatch "^R.*" $elem -}}
        {{- $keysToRemove = append $keysToRemove $elem -}}
    {{- else if regexMatch "^zone.*" $elem -}}
        {{- $keysToRemove = append $keysToRemove $elem -}}
    {{- end -}}
{{- end -}}
{{- $keysToRemove = append $keysToRemove "Staging" -}}
{{- $keysToRemove = append $keysToRemove "Production" -}}

{{ range $keysToRemove }}
    {{ $merged = omit ($merged) . }}
{{- end }}
{{$merged | toYaml }}

{{- end -}}