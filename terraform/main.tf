resource "tanzu-mission-control_cluster" "create_tkgs_workload" {
  management_cluster_name = "${var.session_name}-mgmt"
  provisioner_name        = "<vSphere_namespace_here>"
  name                    = "${var.session_name}-tf"

  meta {
    labels = { "key" : "test" }
  }

  spec {
    cluster_group = "${var.session_name}-cg"
    tkg_service_vsphere {
      settings {
        network {
          pods {
            cidr_blocks = [
              "172.20.0.0/16",
            ]
          }
          services {
            cidr_blocks = [
              "10.96.0.0/16",
            ]
          }
        }
      }

      distribution {
        version = "v1.21.6+vmware.1-tkg.1.b3d708a"
      }

      topology {
        control_plane {
          class             = "best-effort-small"
          storage_class     = "<storage_class_here>"
          high_availability = false
        }
        node_pools {
          spec {
            worker_node_count = "1"
            tkg_service_vsphere {
              class         = "best-effort-small"
              storage_class = "<storage_class_here>"
            }
          }
          info {
            name = "default-nodepool"
          }
        }
      }
    }
  }
  ready_wait_timeout = "10m"
}
