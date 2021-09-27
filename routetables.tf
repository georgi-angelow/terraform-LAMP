# Manage the default route table of the VPC and
# add a route for 0.0.0.0/0 that sends traffic
# to the managed internet gateway.
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
      tags = {
        "Name" = "main"
    }
}

# Assosiate public subnet with public route table
resource "aws_route_table_association" "public_subnet_route_table" {
subnet_id = aws_subnet.main.id
route_table_id = aws_default_route_table.main.id
}

# Create private subnet route table
resource "aws_route_table" "private_subnet_route_table" {
vpc_id = aws_vpc.main.id
    
    tags ={
        Name = "private_subnet_route_table"
    }
}
# Assosiate private subnets with private route table
resource "aws_route_table_association" "myvpc_private_subnet_one_route_table_assosiation" {
subnet_id      = aws_subnet.private_subnet_one.id
route_table_id = aws_route_table.private_subnet_route_table.id
}
resource "aws_route_table_association" "myvpc_private_subnet_two_route_table_assosiation" {
subnet_id      = aws_subnet.private_subnet_two.id
route_table_id = aws_route_table.private_subnet_route_table.id
}
