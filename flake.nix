{
  description = "A flake for building a sample cpp";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            # Make sure this is first so clangd LSP works correctly
            cargo
            clang-tools
            llvmPackages_16.libstdcxxClang
            lldb_17
            gdb
            git
            git-lfs
            nix-index
            pkg-config
            pre-commit
            rust-analyzer
            rustc
          ];
          # Dependencies that only exist in the runtime environment
          buildInputs = with pkgs; [
            zstd
          ];
        };
      });
}
