resource "aws_instance" "ec2-terraform1" { // nome para controle do terraform
    ami = "ami-066784287e358dad1"
    instance_type = "t2.small"
    tags = {
      Name = "ec2-terraform1-separado" // nome que vai aparecer no painel da amazon
    }
}