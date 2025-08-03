target "oniguruma-6_9_10" {
    context = "debian/bookworm/oniguruma/6.9.10"
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
