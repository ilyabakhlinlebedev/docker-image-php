target "default" {
    context = "debian/bookworm/php/8.3.24"
    dockerfile = "Dockerfile"
    platforms = [
        "linux/amd64",
    ]
    tags = [
        "ilyabakhlinlebedev/php:8.3.24",
        "ilyabakhlinlebedev/php:8.3",
    ]
}
