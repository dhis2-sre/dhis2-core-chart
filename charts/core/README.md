# core

![Version: 0.29.0](https://img.shields.io/badge/Version-0.29.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

DHIS 2 Helm Chart

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for pod scheduling, allowing you to define preferred or required co-location of pods. |
| autoscaling.enabled | bool | `false` | Whether horizontal pod autoscaler is enabled. |
| autoscaling.maxReplicas | int | `100` | Maximum number of replicas for the deployment. |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas for the deployment. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage to scale based on. |
| commonLabels | object | `{}` | Common labels applied to all Kubernetes resources created by this chart. |
| contextPath | string | `"/"` | Context path settings for Embedded Tomcat |
| database.database | string | `"dhis2"` | Name of the database to use. |
| database.hostname | string | `"dhis2-postgresql.dhis2.svc"` | Hostname or IP address of the PostgreSQL server. |
| database.password | string | `"dhis"` | Default database password. |
| database.username | string | `"dhis"` | Default database username. |
| dhis2Home | string | `"/opt/dhis2"` | DHIS 2 home directory. |
| enableQueryLogging | bool | `false` | Enable SQL query logging |
| flyway.migrateOutOfOrder | bool | `false` | Allow out-of-order migrations |
| flyway.repairBeforeMigration | bool | `false` | Repair before migrations |
| fullnameOverride | string | `""` | Overrides the full name of the deployment (including namespace). |
| googleAuth.clientEmail | string | `""` | The email address of the service account. |
| googleAuth.clientId | string | `""` | The OAuth 2.0 Client ID. |
| googleAuth.privateKey | string | `""` | The private key in PEM format. Use single quotes if it contains \n or other special characters. |
| googleAuth.privateKeyId | string | `""` | The private key ID used for authentication. |
| googleAuth.projectId | string | `""` | The unique ID of the Google Cloud Project. |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy. |
| image.repository | string | `"dhis2/core"` | Docker image repository name. |
| image.tag | float | `2.42` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | List of secrets to use for pulling images from private registries. |
| ingress.annotations | object | `{}` | Annotations which should be applied to the ingress resource |
| ingress.className | string | `"nginx"` | Class name |
| ingress.enabled | bool | `true` | Whether to enable ingress or not. |
| ingress.hostname | string | `"dhis2-core.127.0.0.1.nip.io"` | Hostname |
| ingress.path | string | `"/"` | Path |
| initContainers | list | `[]` | Init containers. |
| javaOpts | string | `""` | Additional options for JVM.catalinaOpts: "-Dcontext.path='' -Dcontext.sameSiteCookies='lax'" |
| jobs.authentication.dhis2.password | string | `"district"` | Default DHIS2 username. |
| jobs.authentication.dhis2.username | string | `"admin"` | Default DHIS2 username. |
| jobs.enableUsers.enabled | bool | `false` | Whether the "Enable Users" job is enabled. |
| jobs.enableUsers.targetUser | string | `"alinana,arabiceB"` | List of users to target. Support multiple users by adding a comma-separated list of usernames. |
| jobs.generateAnalytics.enabled | bool | `false` | Whether the "Generate Analytics" job is enabled. |
| jobs.installApps.apps | list | `[{"name":"Capture","version":"latest"},{"name":"Dashboard","version":"latest"}]` | List of applications to install/update |
| jobs.installApps.enabled | bool | `false` | Whether the "Install Apps" job is enabled. |
| livenessProbe.path | string | `"/"` | Path |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds |
| log4j2 | string | `"config/log4j2.xml"` | Path to the log4j2 configuration file. |
| minReadySeconds | int | `120` | Minimum number of seconds for the pod to be ready before being considered available. |
| nameOverride | string | `""` | Overrides the chart's default name. |
| nodeSelector | object | `{}` | Node selector labels that allow pods to be scheduled only onto nodes matching these labels. |
| podAnnotations | object | `{}` | Annotations applied to all pods deployed by this chart. |
| podLabels | object | `{}` | Labels applied to all pods deployed by this chart. |
| podSecurityContext | object | `{}` | Security context settings for pods (e.g., fsGroup). |
| readinessProbe.path | string | `"/"` | Path |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds |
| replicaCount | int | `1` | Number of replicas (instances) of DHIS 2 to run. |
| resources | object | `{}` | Resource requests and limits for containers. |
| securityContext.allowPrivilegeEscalation | bool | `false` | Whether to allow privilege escalation |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` | Don't change this. DHIS2 currently doesn't support read-only filesystem since it requires write access to its home directory |
| securityContext.runAsGroup | int | `65534` | See `securityContext.runAsUser` |
| securityContext.runAsNonRoot | bool | `true` | Enforce application running as a non-privileged user |
| securityContext.runAsUser | int | `65534` | 65534 is commonly used as a non-root user, and it corresponds to the nobody user in the distroless image which is used for DHIS2 builds after 2.42. Before 2.42, the user id 65532 is used |
| serverXml | string | `"config/server.xml"` | Path to the Tomcat server XML configuration file. |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Additional annotations for the service account. |
| serviceAccount.create | bool | `true` | Whether a service account should be created. |
| serviceAccount.name | string | `""` | Name of an existing service account to use. If not set and create is true, a name is generated using the fullname template |
| sessionCookieSameSite | string | `"Lax"` | Value can be 'Lax', 'Strict', or 'None'. |
| startupProbe.failureThreshold | int | `26` | Maximum number of failures. |
| startupProbe.path | string | `"/"` | Path |
| startupProbe.periodSeconds | int | `5` | Period between each try |
| storage | object | `{"className":null,"volumeSize":"8Gi"}` | If "minIO" or "S3" is configured, then the following configuration is ignored and no pvc will be created |
| storage.className | string | `nil` | Name of the storage class. |
| storage.volumeSize | string | `"8Gi"` | Size of the Persistent Volume Claim, e.g., 8Gi for 8 gigabytes. |
| strategy.rollingUpdate.maxSurge | int | `1` | Maximum surge |
| strategy.rollingUpdate.maxUnavailable | int | `0` | Maximum unavailable |
| strategy.type | string | `"RollingUpdate"` | Deployment strategy for rolling updates. |
| tolerations | list | `[]` | Tolerations that are added to pods to allow them to schedule onto nodes with certain taints. |

