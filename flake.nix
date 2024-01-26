{
  description = "A script for calling kubo ipfs client with a remote server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... }@inputs: 
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, ... }:
        {
          packages.ipfs-remote = pkgs.writeShellScriptBin "ipfs-remote" ''
            export IPFS_EXEC="${pkgs.kubo}/bin/ipfs"
            exec "${./ipfs-remote.sh}" "$@"
          '';
        };
    };
}

