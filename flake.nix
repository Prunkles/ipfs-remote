{
  description = "A script for calling kubo ipfs client with a remote server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... }@inputs: 
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-linux" "aarch64-darwin" "x86_64-linux" "i686-linux" "x86_64-darwin" ];
      perSystem = { pkgs, ... }:
        rec {
          packages.ipfs-remote = pkgs.writeShellScriptBin "ipfs-remote" ''
            export IPFS_EXEC="${pkgs.kubo}/bin/ipfs"
            exec "${./ipfs-remote.sh}" "$@"
          '';
          packages.default = packages.ipfs-remote;
        };
    };
}

