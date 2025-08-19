{ pkgs, tcl, tk, ... }: pkgs.stdenv.mkDerivation {
  pname = "netgen";
  version = "a60dac6";

  src = pkgs.fetchgit {
    url = "git://opencircuitdesign.com/netgen";
    rev = "a60dac61249af548a3e87f0b6cb62335de5f2841";
    hash = "sha256-e/Vld5euQrm2oc9Ijs2CXWDmr3tfmnO3BTR8Co8la6E=";
  };

  nativeBuildInputs = with pkgs; [
    gnum4
    xorg.libX11
    cairo
    git
    pkg-config
    python3
    libGL
    libGLU
  ] ++ [ tcl tk ];

  configurePhase = ''
    ./configure --prefix=$out --with-tcl=${tcl} --with-tk=${tk}
  '';

  buildPhase = "make";
  installPhase = "make install";
}
