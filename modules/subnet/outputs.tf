output "public_subnet_ids" {
  value = [
    for key, subnet in aws_subnet.subnet :
    key == "public-a-openvpn" || key == "public-b-alb" ? subnet.id : null
  ]
}

output "private_subnet_ids" {
  value = [
    for key, subnet in aws_subnet.subnet :
    key == "private-a" || key == "private-b" ? subnet.id : null
  ]
}

output "db_subnet_ids" {
  value = [
    for key, subnet in aws_subnet.subnet :
    key == "db-a" || key == "db-b" ? subnet.id : null
  ]
}