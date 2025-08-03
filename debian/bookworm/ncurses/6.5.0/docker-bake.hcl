target "ncurses-6_5_0" {
    context = "debian/bookworm/ncurses/6.5.0"
    dockerfile = "Dockerfile"
    output = [
        {
            dest = "debian/bookworm/readline/8.2.0"
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
