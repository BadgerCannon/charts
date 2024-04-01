{{- define "yt-dlp.cronjobs" -}}
{{ range $cj := .Values.cronjobs }}
  {{ $name := $cj.name }}
  {{ $command := $cj.command }}
  {{ $schedule := $cj.schedule }}

{{ $name }}:
  enabled: true
  type: CronJob
  schedule: {{ $schedule | quote }}
  podSpec:
    restartPolicy: Never
    containers:
      {{ $name }}:
        enabled: true
        primary: true
        imageSelector: image
        resources:
          excludeExtra: true
        command:
          - yt-dlp
          - |
            {{ range $command }}
              {{ . | nindent 12 }}
            {{ end }}
        probes:
          liveness:
            enabled: false
          readiness:
            enabled: false
          startup:
            enabled: false
{{ end }}
{{- end -}}
