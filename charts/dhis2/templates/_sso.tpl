{{- define "dhis2-core-helm.ssoBaseUrl" -}}
{{- if .Values.sso.baseUrl -}}
{{- trimSuffix "/" .Values.sso.baseUrl -}}
{{- else if .Values.ingress.enabled -}}
http{{ if .Values.ingress.certIssuer }}s{{ end }}://{{ .Values.ingress.hostname }}{{ .Values.ingress.path }}
{{- end -}}
{{- end -}}

{{- define "dhis2-core-helm.ssoValidate" -}}
{{- $server := .Values.sso.authorizationServer -}}
{{- if $server.enabled -}}
  {{- $url := include "dhis2-core-helm.ssoBaseUrl" . -}}
  {{- if not (hasPrefix "https://" $url) -}}
    {{- fail "sso.authorizationServer requires a public HTTPS sso.baseUrl (or TLS-enabled ingress)" -}}
  {{- end -}}
  {{- if not (regexMatch "^[A-Za-z0-9_-]+$" ($server.keyAlias | default "")) -}}
    {{- fail "sso.authorizationServer.keyAlias must contain only letters, digits, underscores or hyphens" -}}
  {{- end -}}
  {{- if and $server.existingSecret (not (regexMatch "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$" $server.existingSecret)) -}}
    {{- fail "sso.authorizationServer.existingSecret must be a Kubernetes Secret name" -}}
  {{- end -}}
  {{- if $server.existingSecret -}}
    {{- if or $server.keystoreBase64 $server.password $server.keyPassword -}}
      {{- fail "sso.authorizationServer: choose existingSecret or chart-managed keystore/password, not both" -}}
    {{- end -}}
  {{- else -}}
    {{- if or (not $server.keystoreBase64) (not $server.password) -}}
      {{- fail "sso.authorizationServer requires existingSecret or keystoreBase64 and password" -}}
    {{- end -}}
    {{- if not (regexMatch "^[A-Za-z0-9+/]+={0,2}$" $server.keystoreBase64) -}}
      {{- fail "sso.authorizationServer.keystoreBase64 must be base64-encoded" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- if and .Values.sso.baseUrl (not (regexMatch "^https?://[^/[:space:]]+(/[^[:space:]]*)?$" .Values.sso.baseUrl)) -}}
  {{- fail "sso.baseUrl must be a valid HTTP(S) URL without whitespace" -}}
{{- end -}}
{{- $seen := dict -}}
{{- range .Values.sso.oidc.providers -}}
  {{- if not (regexMatch "^[a-z][a-z0-9-]*$" (.id | default "")) -}}
    {{- fail "sso.oidc.providers[].id must start with a lowercase letter and contain only lowercase letters, digits or hyphens" -}}
  {{- end -}}
  {{- if has .id (list "azure" "google" "wso2" "dhis2") -}}
    {{- fail (printf "sso.oidc.providers[%s].id is reserved by DHIS2" .id) -}}
  {{- end -}}
  {{- if hasKey $seen .id -}}
    {{- fail (printf "duplicate OIDC provider id: %s" .id) -}}
  {{- end -}}
  {{- $_ := set $seen .id true -}}
  {{- if or (not .clientId) (not .authorizationUri) (not .tokenUri) (not .userInfoUri) (not .jwkUri) -}}
    {{- fail (printf "OIDC provider %s requires clientId, authorizationUri, tokenUri, userInfoUri and jwkUri" .id) -}}
  {{- end -}}
  {{- $provider := . -}}
  {{- range $field := list .authorizationUri .tokenUri .userInfoUri .jwkUri -}}
    {{- if not (regexMatch "^https://[^[:space:]]+$" $field) -}}
      {{- fail (printf "OIDC provider %s endpoints must be HTTPS URLs without whitespace" $provider.id) -}}
    {{- end -}}
  {{- end -}}
  {{- range $field := list .clientId (.mappingClaim | default "") (.scopes | default "") (.displayAlias | default "") (.redirectUrl | default "") (.endSessionEndpoint | default "") -}}
    {{- if regexMatch "[\r\n]" $field -}}
      {{- fail (printf "OIDC provider %s settings must be single-line" $provider.id) -}}
    {{- end -}}
  {{- end -}}
  {{- if and .existingSecret (not (regexMatch "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$" .existingSecret)) -}}
    {{- fail (printf "OIDC provider %s existingSecret must be a Kubernetes Secret name" .id) -}}
  {{- end -}}
  {{- if and .existingSecret .clientSecret -}}
    {{- fail (printf "OIDC provider %s: choose existingSecret or clientSecret, not both" .id) -}}
  {{- end -}}
  {{- if not (or .existingSecret .clientSecret) -}}
    {{- fail (printf "OIDC provider %s requires existingSecret or clientSecret" .id) -}}
  {{- end -}}
{{- end -}}
{{- end -}}
