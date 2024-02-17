packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  access_key = "AKIAZI2LE2Z6CLDSGQZ7"
  secret_key = "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"

  instance_type = "t2.micro"
  region        = "us-east-1"  # Use us-east-1 as the region
  
  ami_name      = "ubuntu-20.04-a1estherb3"  # Tag images as ubuntu-20.04-a1estherb
  
  ssh_username = "ubuntu"
  
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  }
build {
  name = "a1estherb"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y tree apt-utils awscli docker-compose mysql-client postgresql-client docker.io default-jdk default-jre python3 python3-pip git nodejs npm maven wget ansible htop vim watch build-essential openssh-server snapd",  # Install Snap package manager
      "sudo snap install kubectl --classic",
      "sudo snap install kubectx --classic",
      "sudo snap install helm --classic", 
      "sudo snap install terraform --classic",
    
    ]
  }
}
