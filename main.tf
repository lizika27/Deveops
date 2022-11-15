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


resource "aws_route" "Liz-route"{
  route_table_id = aws_vpc.liz-dev-vpc.main_route_table_id
  
  destination_cidr_block = "0.0.0.0/0"
  
  gateway_id = "${aws_internet_gateway.liz_igw.id}"
}



