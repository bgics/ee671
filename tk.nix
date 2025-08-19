{ pkgs, tcl, ... }:
pkgs.stdenv.mkDerivation {
  pname = "tk";
  version = "8.6.17";

  src = pkgs.fetchurl {
    url = "https://prdownloads.sourceforge.net/tcl/tk8.6.17-src.tar.gz";
    hash = "sha256-5Jgt9vlpwIv53YWKaJEFm0o/UNxsh8EKutu+L8SDiUY=";
  };

  nativeBuildInputs = with pkgs; [ xorg.libX11 ] ++ [ tcl ];

  configurePhase = ''
    cd unix
    ./configure \
      --prefix=$out \
      --with-tcl=${tcl}/lib \
      --with-x \
      --x-includes=${pkgs.xorg.libX11.dev}/include \
      --x-libraries=${pkgs.xorg.libX11}/lib
  '';

  buildPhase = "make";
  installPhase = "make install";
}
