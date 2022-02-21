resource "null_resource" "get_lock" {
  triggers = {
    name = var.name
  }

  # Node Pool が 削除される際にスクリプトを実行して Drain を行います
  provisioner "local-exec" {
    command = "${path.module}/get-lock.sh lockfile1"
  }
}


resource "google_compute_address" "this" {
  name         = "${var.name}-address"
  address_type = "EXTERNAL"
  region       = "asia-northeast1"

  depends_on = [
    null_resource.get_lock
  ]
}

resource "null_resource" "release_lock" {
  triggers = {
    name = var.name
  }

  provisioner "local-exec" {
    command = "${path.module}/release-lock.sh lockfile1"
  }

  depends_on = [
    google_compute_address.this
  ]
}
