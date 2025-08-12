target "default" {
    context = "debian/bookworm/openssl/3.0.16"
    dockerfile = "Dockerfile"
    output = [
        {
            dest = "debian/bookworm/curl/7.88.1"
            type = "local"
        },
        {
            dest = "debian/bookworm/libzip/1.11.4"
            type = "local"
        },
        {
            dest = "debian/bookworm/php/8.3.24"
            type = "local"
        }
    ]
    platforms = [
        "linux/amd64",
    ]
}
