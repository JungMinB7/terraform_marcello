resource "aws_eip" "vpn_eip" { ### 탄력적 ip
  vpc = true

  tags = {
    Name = "${var.openvpn_name}-openvpn-eip"
  }
}

resource "aws_instance" "openvpn" {
  ami                    = var.ami_id  # 🔧 AMI는 main.tf에서 지정
  instance_type          = var.instance_type # 인스턴스 타입
  subnet_id              = var.subnet_id
  associate_public_ip_address = false  # ❌ 퍼블릭 IP 자동 할당 X
  key_name               = var.key_name
  security_groups        = [var.security_group_id]
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "${var.openvpn_name}-openvpn"
  }

  # 탄력적 IP 연결은 밑에서 별도로!
  depends_on = [aws_eip.vpn_eip]
}
## 탄력적 IP 할당
resource "aws_eip_association" "vpn_eip_assoc" {
  instance_id   = aws_instance.openvpn.id
  allocation_id = aws_eip.vpn_eip.id
}
