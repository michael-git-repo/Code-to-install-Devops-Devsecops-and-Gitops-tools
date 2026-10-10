output "machine_elastic_ips" {
  description = "Elastic IP addresses mapped to their respective machine names"
  value = {
    "Kubernetes EKS Server" = aws_eip.eks_eip.public_ip
    "Monitoring"            = aws_eip.monitoring_eip.public_ip
  }
}

output "pem_file_download_path" {
  description = "Saved path of your shared PEM key on your Windows laptop"
  value       = local_file.pem_file.filename
}