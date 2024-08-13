# Create Null Reource and provisioners OR allow you to run scripts or commands as part of terraform work flow
resource "null_resource" "null_copy_ssh_key_to_nastion" {
  depends_on = [ azurerm_linux_virtual_machine.bastion_host_linuxvm ]
  ## Connection block for a provisioners to connect Azure VM instance
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  ## File provisioner : Copy the terrafrom-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }
  ## Remote exce provisioner : Using remote-exce provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod 400 /tmp/terraform-azure.pem"
     ]
  }
}

## Creation Time Provisioner : By default they are create during resources creation (terraform apply)
## Destroy Time provisioner : Will be executed during "terraform destroy " commad (when = destroy)

