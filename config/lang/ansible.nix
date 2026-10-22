{pkgs, ...}: {
  lsp.servers.ansiblels = {
    enable = true;
    package = pkgs.ansible-language-server;
  };

  # ansiblels validates with ansible-lint
  extraPackages = [pkgs.ansible-lint];

  # From https://github.com/mfussenegger/nvim-ansible/blob/bba61168b7aef735e7f950fdfece5ef6c388eacf/ftdetect/ansible.lua#L4-L13
  filetype.pattern = {
    ".*/defaults/.*%.ya?ml" = "yaml.ansible";
    ".*/host_vars/.*%.ya?ml" = "yaml.ansible";
    ".*/group_vars/.*%.ya?ml" = "yaml.ansible";
    ".*/group_vars/.*/.*%.ya?ml" = "yaml.ansible";
    ".*/playbook.*%.ya?ml" = "yaml.ansible";
    ".*/playbooks/.*%.ya?ml" = "yaml.ansible";
    ".*/roles/.*/tasks/.*%.ya?ml" = "yaml.ansible";
    ".*/roles/.*/handlers/.*%.ya?ml" = "yaml.ansible";
    ".*/tasks/.*%.ya?ml" = "yaml.ansible";
    ".*/molecule/.*%.ya?ml" = "yaml.ansible";
  };

  # The yaml grammar comes from ./kubernetes.nix
  plugins.treesitter.languageRegister.yaml = ["yaml.ansible"];
}
