{{- define "warden.webhook.configuration" -}}
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  creationTimestamp: null
  name: warden-validating-webhook-configuration
webhooks:
  - admissionReviewVersions:
      - v1
      - v1beta1
    clientConfig:
      {{- include "kubecube.webhook.caBundle" . | nindent 6 }}
      service:
        name: warden
        namespace: {{ template "kubecube.namespace" . }}
        port: 8443
        path: /validate-core-kubernetes-v1-resource-quota
    failurePolicy: Fail
    name: vresourcequota.kb.io
    rules:
      - apiGroups:
          - ""
        apiVersions:
          - v1
        operations:
          - CREATE
          - UPDATE
          - DELETE
        resources:
          - resourcequotas
    sideEffects: None
  - admissionReviewVersions:
      - v1
      - v1beta1
    clientConfig:
      {{- include "kubecube.webhook.caBundle" . | nindent 6 }}
      service:
        name: warden
        namespace: {{ template "kubecube.namespace" . }}
        port: 8443
        path: /warden-validate-hotplug-kubecube-io-v1-hotplug
    failurePolicy: Fail
    name: vhotplug.kb.io
    rules:
      - apiGroups:
          - hotplug.kubecube.io
        apiVersions:
          - v1
        operations:
          - CREATE
          - UPDATE
          - DELETE
        resources:
          - hotplugs
    sideEffects: None
  - admissionReviewVersions:
      - v1
      - v1beta1
    clientConfig:
      {{- include "kubecube.webhook.caBundle" . | nindent 6 }}
      service:
        name: warden
        namespace: {{ template "kubecube.namespace" . }}
        port: 8443
        path: /warden-validate-tenant-kubecube-io-v1-project
    failurePolicy: Fail
    name: vproject.kb.io
    rules:
      - apiGroups:
          - tenant.kubecube.io
        apiVersions:
          - v1
        operations:
          - DELETE
        resources:
          - projects
    sideEffects: None
  - admissionReviewVersions:
      - v1
      - v1beta1
    clientConfig:
      {{- include "kubecube.webhook.caBundle" . | nindent 6 }}
      service:
        name: warden
        namespace: {{ template "kubecube.namespace" . }}
        port: 8443
        path: /warden-validate-tenant-kubecube-io-v1-tenant
    failurePolicy: Fail
    name: vtenant.kb.io
    rules:
      - apiGroups:
          - tenant.kubecube.io
        apiVersions:
          - v1
        operations:
          - DELETE
        resources:
          - tenants
    sideEffects: None
---
{{- end -}}