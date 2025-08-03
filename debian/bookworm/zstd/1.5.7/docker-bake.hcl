target "default" {
    context = "debian/bookworm/zstd/1.5.7"
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
        "linux/amd64"
    ]
}
