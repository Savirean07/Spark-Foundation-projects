output "instance_id" {
  value = "${aws_instance.foo.id}"
}
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
output "aws_vpc_cidr_block" {
    value = "${aws_vpc.main.cidr_block}"
}
output "aws_subnet_cidr_block" {
    value = "${aws_subnet.main.cidr_block}"
}
output "aws_vpc_ipv6_cidr_block" {
  value = "${aws_vpc.main.ipv6_cidr_block}"
}
output "aws_subnet_id" {
  value = "${aws_subnet.main.id}"
}
output "aws_subnet_id2" {
  value = "${aws_subnet.main2.id}"
}