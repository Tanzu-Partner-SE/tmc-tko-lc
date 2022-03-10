FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:681ef8d2e6fc8414b3783e4de424adbfabf2aa0126e34fa7dcd07dab61e55a89

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
    chmod 755 /usr/local/bin/tmc
# Policy Tools
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 && \
    chmod 755 /usr/local/bin/opa
# Tanzu
RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
    chmod 755 /usr/local/bin/tanzu
# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.1.0/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn
# Utilities
RUN apt-get update && apt-get install -y unzip

USER 1001