provider "aws" {
    region = "ap-south-1"
    profile  = "Rahul"
}

resource "aws_instance" "os" {
  ami           = "ami-0ad704c126371a549"
  instance_type = "t2.micro"
  key_name = "newkey"
 tags = {
    Name = "OS-from-Model"	
  }
}

resource "aws_ebs_volume" "vol" {
  availability_zone = aws_instance.os.availability_zone
  size              = 1
  tags = {
    Name = "EBS-from-Model"
  }
}

resource "aws_volume_attachment" "ebs-attach" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.vol.id
  instance_id = aws_instance.os.id
  force_detach = true
}