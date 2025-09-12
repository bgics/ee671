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
          tcl = import ./tcl.nix { inherit pkgs; };
          tk = import ./tk.nix { inherit pkgs tcl; };

          magic =
            if system == "x86_64-linux" then
              import ./magic.nix { inherit pkgs; }
            else
              import ./magic-mac.nix { inherit pkgs tcl tk; };

          netgen =
            if system == "x86_64-linux" then
              import ./netgen.nix { inherit pkgs; }
            else
              import ./netgen.nix { inherit pkgs tcl tk; };

          open_pdks = import ./open_pdks.nix { inherit pkgs magic; };
        in
        {
          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [
                ngspice
                iverilog
                gtkwave
                gnuplot
                magic
                netgen
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
