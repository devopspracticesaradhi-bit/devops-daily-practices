output "names_of_instances" {
  value = [for instance in aws_instance.my-test : instance.tags["name"]]
}