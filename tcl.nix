{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "tcl";
  version = "8.6.17";

  src = pkgs.fetchurl {
    url = "https://prdownloads.sourceforge.net/tcl/tcl8.6.17-src.tar.gz";
    hash = "sha256-o5Azce/M6KQFxcJF0Cnp9oUCWKYPo3YcTViZVhCUmzE=";
  };

  nativeBuildInputs = with pkgs; [ xorg.libX11 ];

  configurePhase = ''
    cd unix
    ./configure --prefix=$out
  '';

  buildPhase = "make";
  installPhase = "make install";
}
