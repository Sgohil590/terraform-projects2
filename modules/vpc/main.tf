provider "aws" {
    region = var.region
} 


resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = { Name = "tf-vpc"
  }
} 


resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.this.id 
    cidr_block              =  var.public_subnet_cidr
    map_public_ip_on_launch =   true  
    tags = { Name = "tf-public-subnet" }
}


#private Subnet 
resource "aws_subnet" "private" {
    vpc_id      = aws_vpc.this.id 
    cidr_block  = var.private_subnet_cidr 
    tags = { Name =  "tf-private-subnet" }
} 

resource "aws_internet_gateway" "this" {
    vpc_id   = aws_vpc.this.id 
    tags = {
        Name = "tf-igw"
    }
} 

resource "aws_route_table" "public" {
   vpc_id   = aws_vpc.this.id  
   
   route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.this.id 

   }

    tags = { Name = "tf-public-rt" } 
} 
# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
