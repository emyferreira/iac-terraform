resource "aws_instance" "ec2-terraform2" { // nome para controle do terraform
    ami = "ami-066784287e358dad1"
    instance_type = "t2.micro"
    tags = {
      Name = "ec2-terraform2-separado" // nome que vai aparecer no painel da amazon
    }
}