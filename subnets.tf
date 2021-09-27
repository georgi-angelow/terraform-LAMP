
# Create a new subnet for the created VPC
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

    tags = {
        Name = "main"
    } 
}

data "aws_availability_zones" "availability_zones" {}

#Create private subnet one
resource "aws_subnet" "private_subnet_one" {
vpc_id            = aws_vpc.main.id
cidr_block        = "10.0.2.0/24"
availability_zone = data.aws_availability_zones.availability_zones.names[0]

    tags = {
        Name = "private_subnet_one"
    }
}

# Create private subnet two
resource "aws_subnet" "private_subnet_two" {
vpc_id            = aws_vpc.main.id
cidr_block        = "10.0.3.0/24"
availability_zone = data.aws_availability_zones.availability_zones.names[1]

    tags = {
        Name = "private_subnet_two"
    }
}


# Create aws rds subnet groups
resource "aws_db_subnet_group" "my_database_subnet_group" {
name = "mydbsg"
subnet_ids = [aws_subnet.private_subnet_one.id,aws_subnet.private_subnet_two.id]

    tags = {
        Name = "my_database_subnet_group"
    }
}