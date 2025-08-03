target "brotli-1_1_0" {
    context = "debian/bookworm/brotli/1.1.0"
    dockerfile = "Dockerfile"
    output = [
        {
            dest = "debian/bookworm/curl/7.88.1"
            type = "local"
        },
        {
            dest = "debian/bookworm/php/8.3.24"
            type = "local"
        },
    ]
    platforms = [
        "linux/amd64",
    ]
}
