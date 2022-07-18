# #!/bin/bash

# set -x
# set +e

# echo "Setting up KIND cluster"

# cat <<EOF > /opt/workshop/setup.d/kind-config.yaml
# apiVersion: kind.x-k8s.io/v1alpha4
# kind: Cluster
# networking:
#   apiServerPort: 6443
#   apiServerAddress: $(hostname -i)
#   disableDefaultCNI: true
#   podSubnet: 192.168.0.0/16 # set to Calico's default subnet
#   #podSubnet: "10.245.0.0/16"
#   serviceSubnet: "10.246.0.0/16"
# nodes:
#   - role: control-plane
#     kubeadmConfigPatches:
#       - |
#         kind: ClusterConfiguration
#         apiVersion: kubeadm.k8s.io/v1beta3
#         controlPlaneEndpoint: $(hostname -i):6443
#         apiServer:
#         certSANs:
#         - localhost
#         - $(hostname -i)
#         - 127.0.0.1
#     extraPortMappings:
#     - containerPort: 80
#       hostPort: 80
#       listenAddress: "0.0.0.0"
#       protocol: TCP
#     - containerPort: 443
#       hostPort: 443
#       listenAddress: "0.0.0.0"
#       protocol: TCP
#     - containerPort: 30080
#       hostPort: 30080
#       listenAddress: "0.0.0.0"
#       protocol: TCP  
# EOF

# kind get clusters | egrep -e "$SESSION_NAME-cluster"
# if [ "$?" != "0" ]; then
#   kind create cluster --name $SESSION_NAME-cluster --config /opt/workshop/setup.d/kind-config.yaml --wait=30s
#   kubectl apply -f https://projectcalico.docs.tigera.io/manifests/calico.yaml
#   exit 0
# fi
