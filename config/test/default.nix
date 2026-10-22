let
  map = key: action: desc: {
    mode = "n";
    inherit key;
    action.__raw = action;
    options.desc = desc;
  };
in {
  # Language adapters are configured in ./lang
  plugins = {
    neotest = {
      enable = true;
      settings = {
        status.virtual_text = true;
        output.open_on_run = true;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>t";
        group = "test";
      }
    ];
  };

  keymaps = [
    (map "<leader>tt" "function() require('neotest').run.run(vim.fn.expand('%')) end" "Run File")
    (map "<leader>tT" "function() require('neotest').run.run(vim.uv.cwd()) end" "Run All Test Files")
    (map "<leader>tr" "function() require('neotest').run.run() end" "Run Nearest")
    (map "<leader>tl" "function() require('neotest').run.run_last() end" "Run Last")
    (map "<leader>ts" "function() require('neotest').summary.toggle() end" "Toggle Summary")
    (map "<leader>to" "function() require('neotest').output.open({ enter = true, auto_close = true }) end" "Show Output")
    (map "<leader>tO" "function() require('neotest').output_panel.toggle() end" "Toggle Output Panel")
    (map "<leader>tS" "function() require('neotest').run.stop() end" "Stop")
    (map "<leader>tw" "function() require('neotest').watch.toggle(vim.fn.expand('%')) end" "Toggle Watch")
    (map "<leader>td" "function() require('neotest').run.run({ strategy = 'dap' }) end" "Debug Nearest")
  ];
}
