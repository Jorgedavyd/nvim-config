local network = require("jenci.ssh") or require("jenci.tcp")

network.setup(
    {
        machines = {
            main = {
                host = "192.168.100.100",
                port = "22",
                name = "Training beast"
            },
            data = {
                host = "192.168.100.253",
                port = "8888",
                name = "Database"
            },
        },
        project_config_file = ".nvim_remote_config.json"
    }
)

