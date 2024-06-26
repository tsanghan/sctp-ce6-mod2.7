# OUTPUT #

# output "instance_public_fqdn" {
#   value = aws_instance.web_server.public_dns
# }

# output "instance_id" {
#   value = aws_instance.web_server.id
# }

output "instance" {
  value = aws_instance.web_server
}

