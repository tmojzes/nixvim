let
  dap = fn: "function() require('dap').${fn}() end";
  map = mode: key: action: desc: {
    inherit mode key;
    action.__raw = action;
    options.desc = desc;
  };
in {
  # Language adapters are configured in ./lang
  plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>d";
        group = "debug";
        mode = ["n" "v"];
      }
    ];
  };

  keymaps = [
    (map "n" "<leader>dB" "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end" "Breakpoint Condition")
    (map "n" "<leader>db" (dap "toggle_breakpoint") "Toggle Breakpoint")
    (map "n" "<leader>dc" (dap "continue") "Run/Continue")
    (map "n" "<leader>dC" (dap "run_to_cursor") "Run to Cursor")
    (map "n" "<leader>dg" (dap "goto_") "Go to Line (No Execute)")
    (map "n" "<leader>di" (dap "step_into") "Step Into")
    (map "n" "<leader>dj" (dap "down") "Down")
    (map "n" "<leader>dk" (dap "up") "Up")
    (map "n" "<leader>dl" (dap "run_last") "Run Last")
    (map "n" "<leader>do" (dap "step_out") "Step Out")
    (map "n" "<leader>dO" (dap "step_over") "Step Over")
    (map "n" "<leader>dP" (dap "pause") "Pause")
    (map "n" "<leader>dr" "function() require('dap').repl.toggle() end" "Toggle REPL")
    (map "n" "<leader>ds" (dap "session") "Session")
    (map "n" "<leader>dt" (dap "terminate") "Terminate")
    (map "n" "<leader>dw" "function() require('dap.ui.widgets').hover() end" "Widgets")
    (map "n" "<leader>du" "function() require('dapui').toggle({}) end" "Dap UI")
    (map ["n" "v"] "<leader>de" "function() require('dapui').eval() end" "Eval")
  ];

  # Open the UI when a session starts and close it when the session ends
  extraConfigLua = ''
    do
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
    end
  '';
}
