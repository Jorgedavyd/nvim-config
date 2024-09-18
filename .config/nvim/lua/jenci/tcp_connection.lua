-- Main config workflow
Machines = {
    config = {
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
    }
}

function Machines.connect(config)
    local client = vim.loop.new_tcp()
    client:connect(config.host, config.port, function (err)
        if err then
            error("Couldn't connect due to" .. err)
            return
        end
    end)
    config['client'] = client
    return config
end

function Machines.close (config)
    local client = config.client
    client:shutdown()
    client:close()
    config['client'] = nil
    return config
end

function vim.keymap.set.Machines (letter, func, desc, config, sync)
    sync = sync or true
    if sync then
        Machines.rsync(config.host)
    end
    local keymap = ("<leader>m%s"):format(letter)
    local target = config or Machines.config.main

    vim.keymap.set('n', keymap, function ()
        target = Machines.connect(target)
        func(target)
        target = Machines.close(target)
        end, {silent = false, noremap = true, desc = ("TCP Connection to main config: %s"):format(desc)})
end

function Machines.write (client, cmd)
    client:write(cmd, function (err)
        if err then
            print('Not valid cmd' .. err)
        else
            print('Command:' .. cmd)
        end
    end)
end

function Machines.rsync (host)
    local path = vim.fn.expand("%:p:h")
    local project = path:match("projects/" .. "([^/]+)")

    if not project then
        print("Current file not in any project")
        return
    end

    local local_cmd = ("rsync -az ~/projects/%s %s@%s:~/projects/%s "):format(
        project, "main", host, project
    )
    vim.cmd(local_cmd)
end

function Machines.command(command, config)
    vim.ui.input({ prompt = command}, function (cmd)
        command = command .. cmd
        Machines.write(config.client, command)
        Machines.write(config.client, "git restore .\n")
    end)
end

vim.keymap.set.Machines('p', function (config)
    Machines.command("python3 -m ", config)
end, "Main config connection for Python scripts.")

vim.keymap.set.Machines('l', function (config)
    Machines.command("lua ", config)
end, "Main config connection for Lua scripts.")

vim.keymap.set.Machines('cp', function (config)
    Machines.command("clang++ ", config)
end, "Main config connection for C++ scripts.")

vim.keymap.set.Machines('cu', function (config)
    Machines.command("nvcc ", config)
end, "Main config connection for CUDA")

vim.keymap.set.Machines('q', function (config)
    Machines.command("", config)
end, "Database config connection for query.", Machines.config.data, false)
