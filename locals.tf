##################################################################################
# LOCALS
##################################################################################

locals {
  common_tags = {
    Name = "tsanghan-ce6"
  }
  vpc_tags = {
    Name = "tsanghan-ce6-vpc"
  }

  igw_tags = {
    Name = "tsanghan-ce6-igw"
  }

  igw_rt_tags = {
    Name = "tsanghan-ce6-igw-rt"
  }

  db_rt_tags = {
    Name = "tsanghan-ce6-db-rt"
  }

  natgw1_rt_tags = {
    Name = "tsanghan-ce6-natgw1-rt"
  }

  natgw2_rt_tags = {
    Name = "tsanghan-ce6-natgw2-rt"
  }

  front_sub1_tags = {
    Name = "tsanghan-ce6-front1a"
  }

  front_sub2_tags = {
    Name = "tsanghan-ce6-front1b"
  }

  app_sub1_tags = {
    Name = "tsanghan-ce6-app1a"
  }

  app_sub2_tags = {
    Name = "tsanghan-ce6-app1b"
  }

  db_sub1_tags = {
    Name = "tsanghan-ce6-db1a"
  }

  db_sub2_tags = {
    Name = "tsanghan-ce6-db1b"
  }

  natgw1_tags = {
    Name = "tsanghan-ce6-natgw1"
  }

  natgw2_tags = {
    Name = "tsanghan-ce6-natgw2"
  }

  eip1_tags = {
    Name = "tsanghan-ce6-eip1"
  }

  eip2_tags = {
    Name = "tsanghan-ce6-eip2"
  }

  random = {
    Name = "${random_id.server.hex}"
  }

}