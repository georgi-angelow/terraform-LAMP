# Output webserver and dbserver address
output "db_server_address" {
value = aws_db_instance.my_database_instance.address
}
output "web_server_address" {
value = aws_instance.my_web_instance.public_dns
}