variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
    default = "10.0.1.0/24"
}
variable "availability_zone" {
    default = "us-east-1a"
}
variable "instance_type" {
    default = "t3.micro"
}
variable "env" {
    default = "dev"
}
variable "ami_id" {
    default = "ami-0cae6d6fe6048ca2c"
}
variable "region" {
    default = "us-east-1"
}