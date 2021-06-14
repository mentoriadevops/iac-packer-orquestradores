source "googlecompute" "basic-example" {
  project_id = "dadosabertosfeira" ## TODO: change-me
  source_image = "ubuntu-2004-focal-v20210610"
  ## ubuntu?
  #ssh_username = "ubuntu"
  ssh_username = "packer" ## vai funcionar?

  zone = "us-central1-a"
}
