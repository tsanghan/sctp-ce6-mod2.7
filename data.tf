data "cloudinit_config" "web_server" {

  part {
    filename     = "hello-script.sh"
    content_type = "text/x-shellscript"

    content = file("cloud-init/run-script.sh")
  }

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("cloud-init/cloud-config.yaml")
  }
}

data "http" "myip" {
  url = "http://api.ipify.org"
}