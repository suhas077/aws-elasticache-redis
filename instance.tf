
resource "aws_instance" "example" {
  ami           = lookup(var.AMIS, "us-east-1", "") # last parameter is the default value
  instance_type = "t2.small"
  monitoring = true
  key_name = aws_key_pair.mykeypair.key_name
  subnet_id              = "${element(aws_subnet.default.*.id,0)}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
} 
resource "null_resource" "file"{
  
    connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = aws_instance.example.public_ip
    private_key=file(var.PATH_TO_PRIVATE_KEY)
    }
    
     provisioner "file" {
        source = "startup.sh"
        destination = "startup.sh"
          }


    provisioner "remote-exec" {
        inline = [
          "chmod +x ~/startup.sh",
          "cd ~",
          "./startup.sh"
        ]
            }   
             depends_on = [aws_instance.example]
    }
