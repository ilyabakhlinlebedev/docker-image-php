target "default" {
    context = "debian/bookworm/curl/7.88.1"
    dockerfile = "Dockerfile"
    output = [
        {
            dest = "debian/bookworm/php/8.3.24"
            type = "local"
        }
    ]
    platforms = [
        "linux/amd64",
    ]
}
