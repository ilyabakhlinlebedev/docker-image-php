target "libzip-1_11_4" {
    context = "debian/bookworm/libzip/1.11.4"
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
