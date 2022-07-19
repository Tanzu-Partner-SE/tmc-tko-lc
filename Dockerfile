#FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:681ef8d2e6fc8414b3783e4de424adbfabf2aa0126e34fa7dcd07dab61e55a89
FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:a8870aa60b45495d298df5b65c69b3d7972608da4367bd6e69d6e392ac969dd4
ARG KIND_VERSION="v0.12.0"
# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
    chmod 755 /usr/local/bin/tmc
# Tanzu
# RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
#     chmod 755 /usr/local/bin/tanzu

# Utilities
RUN apt-get update && apt-get install -y unzip sudo wget gnupg software-properties-common
# install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

RUN sudo apt update && apt-get install terraform

RUN gpasswd -a eduk8s sudo 

RUN chown -R eduk8s /home/eduk8s 

RUN echo 'eduk8s  ALL=(ALL) /bin/su' >>  /etc/sudoers

RUN curl -Lso /usr/bin/kind "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64" && \
    chmod +x /usr/bin/kind

USER 1001