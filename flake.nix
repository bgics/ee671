{
  description = "ee671 setup flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          magic = import ./magic.nix { inherit pkgs; };
          open_pdks = import ./open_pdks.nix { inherit pkgs; };
        in
        {
          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [
                ngspice
                magic
                open_pdks
              ];
              shellHook = ''
                export PDK_ROOT=${open_pdks}/share/pdk
              '';
            };
          };
        }
      );
}
