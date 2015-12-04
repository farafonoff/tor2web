package = "tor2web"
version = "dev-2"
source = {
    url = 'git://github.com/farafonoff/tor2web',
    tag = 'master',
}
description = {
    summary = "Access all sites via tor without Tor Browser",
    homepage = "https://github.com/farafonoff/tor2web",
    maintainer = "farafonoff@gmail.com",
    license = "MIT"
}
dependencies = {
    "lua ~> 5.1",
    "socks5 >= 1.5"
}
build = {
    type = "builtin",
    modules = {
        tor2web = "tor2web.lua",
    },
}

