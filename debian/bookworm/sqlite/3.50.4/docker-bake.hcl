target "sqlite-3_50_4" {
    context = "debian/bookworm/sqlite/3.50.4"
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
