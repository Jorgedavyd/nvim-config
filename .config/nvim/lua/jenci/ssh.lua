local ssh = {}

ssh.config = {
    machines = {},
    project_config_file = ".nvim_remote_config.json"
}

function ssh.general(script, cmd)
    script = script .. " " .. cmd .. "&&"
    return script
end

function ssh.connect(script, config)
    local path = vim.fn.expand("%:p:h")
    local proj_name = path:match("projects/" .. "([^/]+)")
    local cmd = ("ssh %s@%s && cd %s"):format("main", config.host, "~/projects/" .. proj_name)
    return ssh.general(script, cmd)
end

function ssh.close(script)
    local cmd = "git restore ."
    return ssh.general(script, cmd)
end

function ssh.keymap.set (letter, cmd, desc, config)
    config = config or false
    local script = ""
    if not config then
        print("Config not provided")
    end
    vim.keymap.set('n', ("<leader>m%s"):format(letter), function ()
        script = ssh.connect(script, config)
        script = ssh.general(script, cmd)
        script = ssh.close(script)
        vim.cmd(script)
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
    local file_path = vim.fn.getcwd()
    local func = function (letter, name, script)
        ssh.keymap.set(letter, script .. file_path, ("Script automation with %s"):format(name), config.main)
    end

    local languages = {
        {"lu", "Lua", "lua "},
        {"cc", "C++", "g++ "},
        {"cu", "CUDA", "nvcc "},
        {"c", "C", "clang "},
        {"py", "Python", "python3 -m "},
    }

    for _, language in pairs(languages) do
        func(language[1], language[2], language[3])
    end
end

function ssh.setup(user_config)
    ssh.config = vim.tbl_deep_extend("force", ssh.config, user_config or {})
    ssh.load_project_config()
    ssh.keymap.default(ssh.config)
end

--ssh = nil
return ssh
