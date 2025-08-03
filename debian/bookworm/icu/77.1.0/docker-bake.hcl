target "icu-77_1_0" {
    context = "debian/bookworm/icu/77.1.0"
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
