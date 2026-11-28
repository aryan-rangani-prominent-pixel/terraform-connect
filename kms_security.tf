resource "aws_kms_key" "bank_connect_key" {
    enable_key_rotation = true
    deletion_window_in_days = 30
}
resource "aws_kms_alias" "bank_connect_key" {
  name = "alias/ar_bank_connect_security"
  target_key_id = aws_kms_key.bank_connect_key.key_id
}