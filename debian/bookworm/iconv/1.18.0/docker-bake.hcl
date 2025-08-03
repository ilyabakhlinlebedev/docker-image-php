target "iconv-1_18_0" {
    context = "debian/bookworm/iconv/1.18.0"
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
