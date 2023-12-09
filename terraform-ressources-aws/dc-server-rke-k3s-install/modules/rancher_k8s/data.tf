data "template_cloudinit_config" "rancher_k8s_just_docker_install" {
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.docker_config.rendered
  }
}

data "template_cloudinit_config" "rancher_k8s_install" {
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.docker_config.rendered
  }
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.run_rancher.rendered
  }
  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.kubectl_install.rendered
  }
}

data "template_file" "docker_config" {
  template = file("scripts/docker.sh")
}

data "template_file" "run_rancher" {
  template = file("scripts/rancher.sh")
}

data "template_file" "kubectl_install" {
  template = file("scripts/kubectl.sh")
}
