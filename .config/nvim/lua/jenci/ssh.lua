local ssh = {}

ssh.keymap = {}

ssh.config = {
    machines = {},
    project_config_file = ".nvim_remote_config.json"
}

function ssh.call(cmd, config)
    local path = vim.fn.expand("%:p:h")
    local proj_name = path:match("projects/" .. "([^/]+)")
    local base_dir = "~/projects/"
    local proj_dir = base_dir .. proj_name

    cmd = ([[
rsync -az --exclude "env" %s %s@%s:%s
ssh %s@%s >> EOF
cd %s
git stash
%s
git restore .
EOF
        ]]):format(
        proj_dir, "main", config.host, proj_dir, "main", config.host, proj_dir, cmd
    )
    vim.fn.system(cmd)
end

function ssh.keymap.set (letter, desc, config)
    config = config or false
    if not config then
        print("Config not provided")
    end
    vim.keymap.set('n', ("<leader>m%s"):format(letter), function ()
        local cmd = vim.ui.input({prompt = "command: "}, function (err)
            if err then
                print("Error encountered: " .. err)
            else
                print("Running on %s" .. config.host)
            end
        end)
        ssh.call(cmd, config)
    end, {silent = false, noremap = true, desc = desc})
end

function ssh.load_project_config()
    local current_dir = vim.fn.getcwd()
    local config_path = current_dir .. '/' .. ssh.config.project_config_file
    local f = io.open(config_path, "r")
    if f then
        local content = f:read("*all")
        f:close()
        local ok, project_config = pcall(vim.fn.json_decode, content)
        if ok then
            ssh.config = vim.tbl_deep_extend("force", ssh.config, project_config)
        else
            vim.notify("Failed to parse project config: " .. project_config, vim.log.levels.ERROR)
        end
    end
end

function ssh.keymap.default (config)
    local func = function (letter, name, mini_config)
        ssh.keymap.set(letter, ("Script automation with %s"):format(name), mini_config)
    end

    local languages = {
        {"lu", "Lua"},
        {"cc", "C++"},
        {"cu", "CUDA"},
        {"c", "C"},
        {"py", "Python"},
    }

    for _, language in pairs(languages) do
        func(language[1], language[2], config.machines.main)
    end
end

function ssh.setup(user_config)
    ssh.config = vim.tbl_deep_extend("force", ssh.config, user_config or {})
    ssh.load_project_config()
    ssh.keymap.default(ssh.config)
end

--ssh = nil
return ssh
