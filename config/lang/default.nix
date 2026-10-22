# One file per language: LSP servers, formatters, linters, debug/test adapters and grammars
{
  imports = [
    ./ansible.nix
    ./bash.nix
    ./c.nix
    ./go.nix
    ./kubernetes.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./terraform.nix
    ./typescript.nix
  ];
}
