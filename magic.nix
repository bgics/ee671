{ pkgs, ... }: pkgs.stdenv.mkDerivation {
  pname = "magic";
  version = "b4912fd";

  src = pkgs.fetchgit {
    url = "https://github.com/RTimothyEdwards/magic";
    rev = "b4912fd550ec8b95a760b70fb7c434926cf4f278";
    hash = "sha256-FQ2R4Uf4T6H/B6+YwQPARpmvia3OLR/qVpFPejYhcLA=";
  };

  nativeBuildInputs = with pkgs; [
    gnum4
    xorg.libX11
    tcl
    tk
    cairo
    git
    pkg-config
    python3
    libGL
    libGLU
  ];

  configurePhase = ''
    ./configure --prefix=$out --with-tcl=${pkgs.tcl} --with-tk=${pkgs.tk}
  '';

  buildPhase = "make";
  installPhase = "make install";
}
