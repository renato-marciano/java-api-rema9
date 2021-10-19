# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.192.0/containers/codespaces-linux/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/vscode/devcontainers/universal:1-focal

# ** [Optional] Uncomment this section to install additional packages. **
USER root
#
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
#

RUN RELEASE=$(curl https://api.github.com/repos/rancher/k3d/releases/latest | jq -r .tag_name) \
  && curl -L "https://github.com/rancher/k3d/releases/download/${RELEASE}/k3d-linux-amd64" -o /usr/local/bin/k3d \
  && chmod +x /usr/local/bin/k3d

RUN RELEASE=$(curl https://api.github.com/repos/vmware-tanzu/octant/releases/latest | jq -r .tag_name[1:]) \
  && curl -LO "https://github.com/vmware-tanzu/octant/releases/download/v${RELEASE}/octant_${RELEASE}_Linux-64bit.tar.gz" \
  && tar xvf "octant_${RELEASE}_Linux-64bit.tar.gz" \
  && mv "./octant_${RELEASE}_Linux-64bit/octant" /usr/local/bin/octant

USER codespace
