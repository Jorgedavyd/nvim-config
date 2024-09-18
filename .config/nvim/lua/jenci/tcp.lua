local M = {}

M.config = {
    machines = {},
    project_config_file = ".nvim_remote_config.json"
}

function M.load_project_config()
    local current_dir = vim.fn.getcwd()
    local config_path = current_dir .. '/' .. M.config.project_config_file
    local f = io.open(config_path, "r")
    if f then
        local content = f:read("*all")
        f:close()
        local ok, project_config = pcall(vim.fn.json_decode, content)
        if ok then
            M.config = vim.tbl_deep_extend("force", M.config, project_config)
        else
            vim.notify("Failed to parse project config: " .. project_config, vim.log.levels.ERROR)
        end
    end
end

function M.connect(config)
    local client = vim.loop.new_tcp()
    client:connect(config.host, config.port, function (err)
        if err then
            vim.notify("Couldn't connect due to " .. err, vim.log.levels.ERROR)
            return
        end
        vim.notify("Connected to " .. config.name, vim.log.levels.INFO)
    end)
    config['client'] = client
    return config
end

function M.close(config)
    local client = config.client
    if client then
        client:shutdown()
        client:close()
        config['client'] = nil
        vim.notify("Disconnected from " .. config.name, vim.log.levels.INFO)
    end
    return config
end

function M.write(client, cmd)
    client:write(cmd, function (err)
        if err then
            vim.notify('Not valid cmd: ' .. err, vim.log.levels.ERROR)
        else
            vim.notify('Command executed: ' .. cmd, vim.log.levels.INFO)
        end
    end)
end

function M.rsync(host)
    local path = vim.fn.expand("%:p:h")
    local project = path:match("projects/" .. "([^/]+)")
    if not project then
        vim.notify("Current file not in any project", vim.log.levels.WARN)
        return
    end
    local local_cmd = ("rsync -az ~/projects/%s %s@%s:~/projects/%s "):format(
        project, "main", host, project
    )
    vim.fn.jobstart(local_cmd, {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                vim.notify("Rsync completed successfully", vim.log.levels.INFO)
            else
                vim.notify("Rsync failed with exit code: " .. exit_code, vim.log.levels.ERROR)
            end
        end
    })
end

function M.execute_command(command, config, sync)
    if sync then
        M.rsync(config.host)
    end

    config = M.connect(config)

    vim.ui.input({ prompt = command }, function (cmd)
        if cmd then
            local full_command = command .. cmd .. "\n"
            M.write(config.client, full_command)
            config.client:read_start(function(err, chunk)
                if err then
                    vim.notify("Error reading output: " .. err, vim.log.levels.ERROR)
                elseif chunk then
                    vim.schedule(function()
                        vim.notify(chunk, vim.log.levels.INFO)
                    end)
                end
            end)

            M.write(config.client, "git restore .\n")
        end
    end)

    vim.defer_fn(function()
        config = M.close(config)
    end, 5000)  -- Close connection after 5 seconds
end

function M.setup_keymaps()
    local function set_machine_keymap(letter, command, desc, machine_key, sync)
        local keymap = ("<leader>m%s"):format(letter)
        vim.keymap.set('n', keymap, function()
            M.execute_command(command, M.config.machines[machine_key], sync)
        end, {silent = false, noremap = true, desc = desc})
    end

    set_machine_keymap('p', "python3 -m ", "Execute Python script on main", "main", true)
    set_machine_keymap('l', "lua ", "Execute Lua script on main", "main", true)
    set_machine_keymap('cp', "clang++ ", "Compile C++ on main", "main", true)
    set_machine_keymap('cu', "nvcc ", "Compile CUDA on main", "main", true)
    set_machine_keymap('q', "", "Execute query on database", "data", false)
end

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
    M.load_project_config()
    M.setup_keymaps()
end

return M
