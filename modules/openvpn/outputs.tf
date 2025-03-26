output "openvpn_instance_id" {
  value = aws_instance.openvpn.id
}

output "openvpn_eip" {
  description = "Public Elastic IP address of the OpenVPN instance"
  value       = aws_eip.vpn_eip.public_ip
}
