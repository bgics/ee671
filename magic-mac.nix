{ pkgs, tcl, tk, ... }: pkgs.stdenv.mkDerivation {
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
    cairo
    git
    pkg-config
    python3
    libGL
    libGLU
  ] ++ [ tcl tk ];

  configurePhase = ''
    ./configure \
      --prefix=$out \
      --with-tcl=${tcl}/lib \
      --with-tk=${tk}/lib \
      --x-includes=${pkgs.xorg.libX11.dev}/include \
      --x-libraries=${pkgs.xorg.libX11}/lib \
      CFLAGS=-Wno-error=implicit-function-declaration
  '';

  buildPhase = "make";
  installPhase = "make install";
}
