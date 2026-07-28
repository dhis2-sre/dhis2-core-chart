# dhis2

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

DHIS 2 Helm chart bundling a CloudNativePG PostgreSQL cluster and an optional MinIO file store

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | minio | 14.7.5 |

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
| database.existingSecret | string | `""` | Existing secret containing database credentials |
| database.hostname | string | `""` | Hostname or IP address of the PostgreSQL server. When empty, resolves to <release>-postgresql, the service of the bundled PostgreSQL subchart. |
| database.password | string | `"dhis"` | Default database password. |
| database.secretKeys.password | string | `"password"` | Key for password in the secret |
| database.secretKeys.username | string | `"username"` | Optional: Key for username in the secret. If empty, uses the plain username value |
| database.username | string | `"dhis"` | Default database username. |
| dhis2Home | string | `"/opt/dhis2"` | DHIS 2 home directory. |
| doris.createDatabase | bool | `true` | Create the database on install and drop it on uninstall. |
| doris.database | string | `""` | Name of the Doris database for this instance. |
| doris.enabled | bool | `false` | Whether to use Doris as the analytics database. |
| doris.existingSecret | string | `""` | Existing secret with the Doris credentials. |
| doris.hostname | string | `""` | Hostname of the Doris frontend (MySQL protocol). |
| doris.password | string | `""` | Doris password. Ignored when existingSecret is set. |
| doris.port | int | `9030` |  |
| doris.secretKeys.password | string | `"password"` |  |
| doris.secretKeys.username | string | `"username"` |  |
| doris.useSSL | bool | `false` |  |
| doris.username | string | `""` | Doris username. Ignored when existingSecret is set. |
| enableQueryLogging | bool | `false` | Enable SQL query logging |
| flyway.migrateOutOfOrder | bool | `false` | Allow out-of-order migrations |
| flyway.repairBeforeMigration | bool | `false` | Repair before migrations |
| fullnameOverride | string | `""` | Overrides the full name of the deployment (including namespace). |
| global.postgresql.auth.database | string | `"dhis2"` | Database name shared by the PostgreSQL cluster bootstrap and DHIS 2's connection settings. |
| global.postgresql.auth.password | string | `"dhis"` | Database password shared by the PostgreSQL cluster secrets and DHIS 2's connection settings. |
| global.postgresql.auth.username | string | `"dhis"` | Database username shared by the PostgreSQL cluster bootstrap and DHIS 2's connection settings. |
| global.security.allowInsecureImages | bool | `true` | Required for the bitnamilegacy minio image repository configured below. |
| glowroot.config | object | `{"gauges":[{"mbeanAttributes":[{"name":"HeapMemoryUsage.used"},{"name":"NonHeapMemoryUsage.used"}],"mbeanObjectName":"java.lang:type=Memory"}],"general":{"agentDisplayName":"DHIS2"},"ui":{"defaultGaugeNames":[],"defaultPercentiles":[50,95,99,99.9],"defaultTransactionType":"Web"},"web":{"bindAddress":"0.0.0.0","contextPath":"/glowroot","port":4000}}` | Glowroot configuration |
| glowroot.enabled | bool | `false` | Whether to enable Glowroot or not. |
| glowroot.expectedSha | string | `"7c7a46d8f0d020962f9299eb3c809a49d3156afb4ded46fae9088a603bc66fa3"` | Glowroot expected sha |
| glowroot.image | string | `"alpine:latest"` | Glowroot init container image |
| glowroot.ingress.enabled | bool | `true` | Enable Glowroot ingress |
| glowroot.ingress.path | string | `"/glowroot"` | Glowroot ingress path |
| glowroot.port | int | `4000` | Glowroot port |
| glowroot.version | string | `"0.14.2"` | Glowroot version |
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
| ingress.path | string | `"/"` | Path (should start with /) |
| initContainers | list | `[]` | Init containers. |
| javaOpts | string | `""` | Additional options for JVM.catalinaOpts: "-Dcontext.path='' -Dcontext.sameSiteCookies='lax'" |
| javaTempDir | string | `"/tmp/dhis"` | Temporary directory for Java (used when readOnlyRootFilesystem is true). |
| jobs.authentication.dhis2.password | string | `"district"` | Default DHIS2 username. |
| jobs.authentication.dhis2.username | string | `"admin"` | Default DHIS2 username. |
| jobs.enableUsers.enabled | bool | `false` | Whether the "Enable Users" job is enabled. |
| jobs.enableUsers.targetUser | string | `"alinana,arabiceB"` | List of users to target. Support multiple users by adding a comma-separated list of usernames. |
| jobs.generateAnalytics.enabled | bool | `false` | Whether the "Generate Analytics" job is enabled. |
| jobs.installApps.apps | list | `[{"name":"Capture","version":"latest"},{"name":"Dashboard","version":"latest"}]` | List of applications to install/update |
| jobs.installApps.enabled | bool | `false` | Whether the "Install Apps" job is enabled. |
| keda.enabled | bool | `false` | Whether to enable KEDA scaling or not. |
| keda.initialCooldownPeriod | int | `3600` | The delay before the cooldownPeriod starts after the initial creation |
| keda.proxy | object | `{"hostname":"keda-add-ons-http-interceptor-proxy.keda.svc"}` | KEDA HTTP interceptor proxy hostname |
| keda.replicas.max | int | `1` | Maximum number of replicas |
| keda.replicas.min | int | `0` | Minimum number of replicas |
| keda.scaledownPeriod | int | `600` | The delay before scaling down, starts after the last scaling event |
| keda.scalingMetric.requestRate.granularity | string | `"1s"` |  |
| keda.scalingMetric.requestRate.targetValue | int | `5` |  |
| keda.scalingMetric.requestRate.window | string | `"30s"` |  |
| livenessProbe.path | string | `"/"` | Path |
| livenessProbe.timeoutSeconds | int | `1` | Timeout in seconds |
| log4j2 | string | `"config/log4j2.xml"` | Path to the log4j2 configuration file. Set to `config/log4j2-json.xml` for structured JSON logging suitable for log aggregators like Loki. |
| minIO.container | string | `"dhis2"` | Bucket name in the storage service, must match minio.defaultBuckets. |
| minIO.endpoint | string | `""` | Endpoint URL for the MinIO server. When empty, resolves to http://<release>-minio:9000, the service of the bundled MinIO subchart. |
| minIO.identity | string | `"dhisdhis"` | Access key, must match minio.auth.rootUser. |
| minIO.location | string | `"eu-west-1"` | AWS region or custom location identifier. |
| minIO.provider | string | `"s3"` | Provider type, currently only 's3' is supported. |
| minIO.secret | string | `"dhisdhis"` | Secret key, must match minio.auth.rootPassword. |
| minReadySeconds | int | `120` | Minimum number of seconds for the pod to be ready before being considered available. |
| minio.auth.rootPassword | string | `"dhisdhis"` | MinIO secret key, must match minIO.secret. |
| minio.auth.rootUser | string | `"dhisdhis"` | MinIO access key, must match minIO.identity. |
| minio.defaultBuckets | string | `"dhis2"` | Bucket created on startup, must match minIO.container. |
| minio.enabled | bool | `false` | Deploy the MinIO subchart. Enable together with storage.type=minio. |
| minio.image.repository | string | `"bitnamilegacy/minio"` | Bitnami stopped publishing versioned minio images to the bitnami repository; the legacy repository carries them (requires global.security.allowInsecureImages). |
| minio.resourcesPreset | string | `"none"` | The Bitnami default preset starves the file store under load; no preset is applied and explicit resources should be set instead. |
| nameOverride | string | `""` | Overrides the chart's default name. |
| nodeSelector | object | `{}` | Node selector labels that allow pods to be scheduled only onto nodes matching these labels. |
| podAnnotations | object | `{}` | Annotations applied to all pods deployed by this chart. |
| podLabels | object | `{}` | Labels applied to all pods deployed by this chart. |
| podSecurityContext | object | `{}` | Security context settings for pods (e.g., fsGroup). |
| postgresql.commonLabels | object | `{}` | Labels propagated by the operator to every object it creates, including pods. |
| postgresql.enabled | bool | `true` | Deploy a CloudNativePG PostgreSQL cluster. Requires the CloudNativePG operator; disable to bring your own database and set database.hostname. |
| postgresql.imageName | string | `"ghcr.io/cloudnative-pg/postgis:17-3.5"` | PostGIS-enabled operand image; DHIS 2 requires the postgis extension. |
| postgresql.instances | int | `1` | Number of PostgreSQL instances (pods) in the cluster. |
| postgresql.resources | object | `{}` | Resources of the PostgreSQL containers. |
| postgresql.seed.enabled | bool | `false` | Run a one-time seed job once the database is ready. The job waits for the database, skips if the dhis2_chart_seed_complete marker table exists, runs the script with superuser PG* environment prepared, then creates the marker. DHIS 2 waits for the marker before starting. |
| postgresql.seed.extraEnv | list | `[]` | Extra environment variables for the seed job. |
| postgresql.seed.image | string | `"dhis2/postgresql-curl:17"` | Image for the seed job and the wait-for-seed init container; needs psql and curl. |
| postgresql.seed.script | string | `""` | Shell script performing the seed. |
| postgresql.storageClass | string | `""` | Storage class for the instance volumes; empty uses the cluster default. |
| postgresql.storageSize | string | `"8Gi"` | Storage size of each instance. |
| readinessProbe.path | string | `"/"` | Path |
| readinessProbe.timeoutSeconds | int | `1` | Timeout in seconds |
| replicaCount | int | `1` | Number of replicas (instances) of DHIS 2 to run. |
| resources | object | `{}` | Resource requests and limits for containers. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsGroup":65534,"runAsNonRoot":true,"runAsUser":65534}` | Don't change anything here unless you really know what you are doing |
| securityContext.allowPrivilegeEscalation | bool | `false` | Whether to allow privilege escalation |
| securityContext.readOnlyRootFilesystem | bool | `true` | Whether to use a read-only root filesystem |
| securityContext.runAsGroup | int | `65534` | See `securityContext.runAsUser` |
| securityContext.runAsNonRoot | bool | `true` | Enforce application running as a non-privileged user |
| securityContext.runAsUser | int | `65534` | 65534 is commonly used as a non-root user, and it corresponds to the nobody user in the distroless image which is used for DHIS2 builds after 2.42. Before 2.42, the user id 65532 is used |
| serverXml | string | `"config/server.xml"` | Path to the Tomcat server XML configuration file. |
| service.annotations | object | `{}` | Additional annotations for the service |
| service.port | int | `8080` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Additional annotations for the service account. |
| serviceAccount.create | bool | `true` | Whether a service account should be created. |
| serviceAccount.name | string | `""` | Name of an existing service account to use. If not set and create is true, a name is generated using the fullname template |
| sessionCookieSameSite | string | `"Lax"` | Value can be 'Lax', 'Strict', or 'None'. |
| startupProbe.failureThreshold | int | `26` | Maximum number of failures. |
| startupProbe.path | string | `"/"` | Path |
| startupProbe.periodSeconds | int | `5` | Period between each try |
| storage | object | `{"className":null,"type":"filesystem","volumeSize":"8Gi"}` | Custom configuration snippet (optional). customConfigSnippet: |  custom = property File store configuration. When the type is "minio" or "s3", volumeSize/className are ignored and no pvc is created. |
| storage.className | string | `nil` | Name of the storage class. It's recommended to update this to a storage class which exists on your cluster. Such as "gp2" on AWS. |
| storage.type | string | `"filesystem"` | File store type: "filesystem", "minio" or "s3". When "minio", also set minio.enabled=true above. |
| storage.volumeSize | string | `"8Gi"` | Size of the Persistent Volume Claim, e.g., 8Gi for 8 gigabytes. |
| strategy.rollingUpdate.maxSurge | int | `1` | Maximum surge |
| strategy.rollingUpdate.maxUnavailable | int | `0` | Maximum unavailable |
| strategy.type | string | `"RollingUpdate"` | Deployment strategy for rolling updates. |
| tolerations | list | `[]` | Tolerations that are added to pods to allow them to schedule onto nodes with certain taints. |

