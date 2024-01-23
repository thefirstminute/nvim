return {
  "David-Kunz/gen.nvim",
  config = function()
    require('gen').setup({
      model = "mistral",    -- The default model to use.
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_prompt = true,   -- Shows the Prompt submitted to Ollama.
      -- make the split only 25% of the window
      split_size = 25,
      split_direction = "horizontal",

      show_model = true,    -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = true, -- Never closes the window automatically.
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
      -- Function to initialize Ollama
      command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      list_models = '<function>', -- Retrieves a list of model names
      debug = false             -- Prints errors and the command which is run.
    })

    local gen = require('gen')
    gen.prompts['Phrank'] = {
      prompt =
      "You senior php programming genius. You ONLY write PROCEEDURAL and FUNCTIONAL code! You answer with brief, safe, performant, proceedural code snippets, no explanations or wasted words. You never provide object oriented examples, nor use pdo. $input:\n$text",
      replace = false
    }

    gen.prompts['Lou'] = {
      prompt =
      "You senior Lua programming genius. You answer with brief, safe, performant, code snippets, no explanations or wasted words. $input:\n$text",
      replace = false
    }

    gen.prompts['Neo'] = {
      prompt =
      "You Neovim genius. You answer with brief, safe, performant, code snippets, no explanations or wasted words. $input:\n$text",
      replace = false
    }

    vim.api.nvim_exec([[
    augroup ResizeGenSplit
    autocmd!
    autocmd BufNew gen.nvim vertical resize 45
    augroup END
    ]], false)

  end
}
