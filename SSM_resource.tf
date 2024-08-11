resource "aws_ssm_document" "ssm_document" {
  name          = "RestartSSHService"
  document_type  = "Command"

  content = jsonencode({
    schemaVersion = "2.2",
    description   = "Restart SSH service",
    mainSteps      = [
      {
        action = "aws:runShellScript",
        name   = "restartSSH",
        inputs = {
          runCommand = [
            "sudo systemctl restart sshd"
          ]
        }
      }
    ]
  })

  tags = {
    Name = "RestartSSHService"
  }
}
