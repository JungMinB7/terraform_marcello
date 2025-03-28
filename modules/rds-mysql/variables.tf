variable "rds_name" {
  description = "RDS 이름 접두사"
  type        = string
}

variable "db_name" {
  description = "MySQL DB 이름"
  type        = string
}

variable "allocated_storage" {
  description = "스토리지 (GB)"
  type        = number
}

variable "engine" {
  description = "DB 엔진 (mysql 등)"
  type        = string
  default = "mysql"
}

variable "engine_version" {
  description = "DB 엔진 버전"
  type        = string
  default = "8.0"
}

variable "instance_class" {
  description = "DB 인스턴스 타입"
  type        = string
}

variable "username" {
  description = "DB 사용자 이름"
  type        = string
}

variable "password" {
  description = "DB 비밀번호"
  type        = string
}

variable "port" {
  description = "DB 포트"
  type        = number
}

variable "multi_az" {
  description = "멀티 AZ 활성화 여부"
  type        = bool
}

variable "subnet_ids" {
  description = "RDS가 배치될 서브넷 리스트"
  type        = list(string)
}

variable "security_group_id" {
  description = "RDS에 연결할 SG ID"
  type        = string
}

