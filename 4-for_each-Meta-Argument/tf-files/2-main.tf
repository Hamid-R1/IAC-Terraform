# without for_each 
resource "aws_s3_bucket" "web-s3" {
  bucket = "web-s3-bucket-web1"
  tags = {
    Name = "bucket-for-web1"
  }
}


# for_each with set of strings(toset) funtion
resource "aws_s3_bucket" "db-s3" {
  for_each = toset(["db-s3-bucket-db1", "db-s3-bucket-db2"])
  bucket   = each.value       #"${each.value}"
  tags = {
    "Name" = each.value       #"${each.value}"
  }
}
# Notes:-  each.value == each.key (gives same value)#


# for_each with  maps
resource "aws_s3_bucket" "app-s3" {
  for_each = {
    test-env = "app-s3-bucket-app1"
    dev-env = "app-s3-bucket-app2"
  }
  bucket =  "${each.key}-${each.value}"
  tags = {
    environment = each.key      #"${each.key}"
    Name =  each.value          #"${each.value}"
  }
}
