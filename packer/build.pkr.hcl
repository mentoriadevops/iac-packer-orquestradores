build {
  sources = ["sources.googlecompute.imagem-nomad"]

  provisioner "ansible" {
    galaxy_file            = "./ansible/nomad/requirements.yml"
    galaxy_force_install   = true
    galaxy_force_with_deps = true

    playbook_file = "./ansible/nomad/playbook.yml"
    ansible_env_vars = [
      "ANSIBLE_REMOTE_TMP=/tmp/.ansible/tmp",
      "ANSIBLE_SSH_ARGS='-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=ssh-rsa'",
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]

    user = var.config_gcp.usuario_ssh

    // extra_arguments = ["-vvvv"]
  }
}

build {
  sources = ["sources.googlecompute.imagem-rke"]

  provisioner "ansible" {
    galaxy_file          = "./ansible/rke/requirements.yml"
    galaxy_force_install = true

    playbook_file = "./ansible/rke/playbook.yml"
    ansible_env_vars = [
      "ANSIBLE_REMOTE_TMP=/tmp/.ansible/tmp",
      "ANSIBLE_SSH_ARGS='-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=ssh-rsa'",
      "ANSIBLE_HOST_KEY_CHECKING=False"
    ]

    user = var.config_gcp.usuario_ssh

    // extra_arguments = ["-vvvv"]
  }
}