terramate {
  required_version = "~> 0.4"

  config {
    git {
      default_branch    = "main"
      default_remote    = "origin"
      check_untracked   = true
      check_uncommitted = true
      check_remote      = true
    }
  }
}
