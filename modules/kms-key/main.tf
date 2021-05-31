resource "aws_kms_key" "this" {
  description = "${var.app_name} KMS Key"
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.app_name}"
  target_key_id = aws_kms_key.this.id
}
