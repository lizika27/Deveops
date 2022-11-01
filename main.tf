terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "liz-dev-vpc" {
   cidr_block = "10.20.0.0/16"

   tags = {
    Name = "liz-dev-vpc"
   }
 
}

resource "aws_subnet" "liz-k8s-subnet" {
  vpc_id = "${aws_vpc.liz-dev-vpc.id}"
  cidr_block = "10.20.1.0/27"
  tags = {

    Name = "liz-k8s-subnet"
  }  
}


resource "aws_internet_gateway" "liz_igw" {
  vpc_id = "${aws_vpc.liz-dev-vpc.id}"

  tags = {
    Name = "liz_igw"
  }
  
}

resource "aws_network_interface" "function" {
  subnet_id = "${aws_subnet.liz-k8s-subnet.id}"
  private_ips = ["10.20.1.16"]

  tags = {
    Name = "liz_PNI"
  }
  
}