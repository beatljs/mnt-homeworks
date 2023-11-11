locals {
  ssh-key = "jenkins: ${file("~/.ssh/id_ed25519.pub")}"
  
  for_hosts = {
      jenkins_vm = yandex_compute_instance.my_jenkins_vm
   }
}
