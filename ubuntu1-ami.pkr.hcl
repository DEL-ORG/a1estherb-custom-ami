packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.3.0"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  secret_key   = "j4lfVWjpnLvWMLdJQ4YiQZ35EGMnoMxQE/XGW6dI"
  access_key   = "AKIAZI2LE2Z6CLDSGQZ7"
  ami_name     = "ubuntu-20.04-a1estherb"
  instance_type = "t2.micro"
  region       = "us-east-1"
  source_ami   = "ami-06aa3f7caf3a30282"
  ssh_username = "ubuntu"
}

build {
  name    = "my-first-build"
  sources = ["sources.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y tree apt-utils awscli docker-compose mysql-client postgresql-client docker.io default-jdk default-jre python3 python3-pip git nodejs npm maven wget ansible htop vim watch build-essential openssh-server snapd",  # Install Snap package manager
      "sudo snap install terraform --classic",  # Include --classic flag for Terraform installation
      "sudo snap install helm --classic",
      "sudo snap install kubectl --classic",
      "sudo snap install kubectx --classic",   # Include --classic flag for kubectx installation
   ]
   }
}
