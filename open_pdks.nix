{ pkgs, magic, ... }:
let
  sky130_fd_pr = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_pr";
    rev = "1232782c1b9fab3aacda74d67ce7c92bf7da8105";
    hash = "sha256-e1rW38ylpL8yf9GRKYGEw+NRqoLVOCVNGhwXyyzWPkk=";
  };

  sky130_fd_io = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_io";
    rev = "b9c10d039816c4026f9a10cf8a200b9b5caa1b63";
    hash = "sha256-VZaI2cdKg2J2xwzOoDH4YOut51FNYKCWhQQdCrbYVLw=";
    fetchSubmodules = false;
  };

  sky130_fd_sc_hd = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_hd";
    rev = "5a42fd01a0eeb2338340438443c7062e198d97a4";
    hash = "sha256-Lbygr7WskW4kccz1tq4RsZ7PqqBij+7eQCUgQx20E2M=";
  };

  sky130_fd_sc_hdll = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_hdll";
    rev = "d48faa83ef2d8573d85384c4eb019ab78295db0b";
    hash = "sha256-KePNsYbdJKaKKk32Q2Yz8Fot33Aa+V8UUrhkitKslb4=";
  };

  sky130_fd_sc_lp = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_lp";
    rev = "b93a1a75fa1b864872ebb0b078f6a2dd6e318d7c";
    hash = "sha256-vR7mdpwyOyMuwQiXFcKmqOhGYy21rwKE3lnXv2VZtVU=";
  };

  sky130_fd_sc_hs = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_hs";
    rev = "9a855e97aa75f8a14be7eadc365c28d50045d5fc";
    hash = "sha256-Ah6+n8JhefUPZ85O36iyCpefYHB4LC4wJFn98u6IoSw=";
  };

  sky130_fd_sc_ms = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_ms";
    rev = "26d0047c0e2dbe28fe4950f171411f6e8b3d0564";
    hash = "sha256-zkokJdtbLrKn2vlsYSx+M7niYYofXjueMgP19rJc2z4=";
  };

  sky130_fd_sc_ls = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_ls";
    rev = "8e7040bfc58a17386e3d900c0e3b9c9163545c4a";
    hash = "sha256-Iew6cVD+0E7+TETuBI+e8jY83lXdHr3zgvKcPiQL0rc=";
  };

  sky130_fd_sc_hvl = pkgs.fetchgit {
    url = "https://github.com/efabless/skywater-pdk-libs-sky130_fd_sc_hvl";
    rev = "5f544a6d5b9385ac563811e7a455b050eea5fb70";
    hash = "sha256-oKo6TCs4X/1RJYyoI9CLlMrJYBNW43uPH86uFkxZtkg=";
  };

  sky130_sram_macros = pkgs.fetchgit {
    url = "https://github.com/fossi-foundation/sky130_sram_macros";
    rev = "5ad1c96053ee8223fe7e956e314646adfce605dd";
    hash = "sha256-pEZwDBPaJ6VgfZr5FVrgY8Yll9KylO9/K7E5FM5h1Xk=";
  };

  sky130_osu_sc_t15 = pkgs.fetchgit {
    url = "https://foss-eda-tools.googlesource.com/skywater-pdk/libs/sky130_osu_sc_t15";
    rev = "95d1c19abb47e1b2945847acb4e817b1b8417c43";
    hash = "sha256-cijsh9r/2LShYHa5TI3d7pM/6AwfYu73qLYOlPQ/5qQ=";
  };

  sky130_klayout_pdk = pkgs.fetchgit {
    url = "https://github.com/fossi-foundation/sky130_klayout_pdk";
    rev = "9861f40ff389c86fbe082122ee868a065cd4cfd4";
    hash = "sha256-QAa9DCpD6w7msNqgdCaMU/QUopwlvsZHn9VhljQPwps=";
  };

  sky130_ml_xx_hd = pkgs.fetchgit {
    url = "https://github.com/PaulSchulz/sky130_pschulz_xx_hd";
    rev = "6eb3b0718552b034f1bf1870285ff135e3fb2dcb";
    hash = "sha256-+7DxRIZJM7rsMUcWA6DjVNMaPrhlY2CwdK8RhVNOuDA=";
  };

  sky130_xchem = pkgs.fetchgit {
    url = "https://github.com/StefanSchippers/xschem_sky130";
    rev = "5a1a7e9d6878d676cecbc88a2062e6c72b514c6c";
    hash = "sha256-K3sDDWr30OfsdHaVVrsIDxob8nHfa6KKglmaErWQ8cY=";
  };

  sky130_precheck = pkgs.fetchgit {
    url = "https://github.com/fossi-foundation/mpw_precheck";
    rev = "7eb869a4b6a5807f49d5ae738c541cce39c41ba5";
    hash = "sha256-5rUXcqm2xOGHOSDhelfN+Ct1Cxl7fHCtkpjdb6DCVvM=";
  };

  pythonWithPackages = pkgs.python311.withPackages
    (ps: with ps; [
      distutils
    ]);
in
pkgs.stdenv.mkDerivation {
  pname = "open_pdks";
  version = "c6d73a3";

  src = pkgs.fetchgit {
    url = "https://github.com/RTimothyEdwards/open_pdks";
    rev = "c6d73a35f524070e85faff4a6a9eef49553ebc2b";
    hash = "sha256-UnR0iAk159n05ja5rYfbgI7wIpVRSJsQ8No+XEiDJC8=";
  };

  nativeBuildInputs = with pkgs; [
    magic
    pythonWithPackages
    bash
    coreutils
    symlinks
  ];

  configurePhase = ''
    export STAGING_DIR=$TMPDIR
          ./configure \
        --enable-sky130-pdk \
        --enable-sram-sky130 \
        --enable-primitive-sky130=${sky130_fd_pr} \
        --enable-io-sky130=${sky130_fd_io} \
        --enable-sc-hd-sky130=${sky130_fd_sc_hd} \
        --enable-sc-hdll-sky130=${sky130_fd_sc_hdll} \
        --enable-sc-lp-sky130=${sky130_fd_sc_lp} \
        --enable-sc-hs-sky130=${sky130_fd_sc_hs} \
        --enable-sc-ms-sky130=${sky130_fd_sc_ms} \
        --enable-sc-ls-sky130=${sky130_fd_sc_ls} \
        --enable-sc-hvl-sky130=${sky130_fd_sc_hvl} \
        --enable-sram-sky130=${sky130_sram_macros} \
        --enable-osu-t15-sky130=${sky130_osu_sc_t15} \
        --enable-klayout-sky130=${sky130_klayout_pdk} \
        --enable-alpha-sky130=${sky130_ml_xx_hd} \
        --enable-xschem-sky130=${sky130_xchem} \
        --enable-precheck-sky130=${sky130_precheck} \
        --prefix=$STAGING_DIR
      find . -type f -exec sed -i "s|/bin/bash|${pkgs.bash}/bin/bash|g" {} +
      find . -type f -name "*.py" -exec sed -i '1s|^#!/usr/bin/env python3|#!${pythonWithPackages}/bin/python3|' {} +
  '';

  buildPhase = ''
    make -j $NIX_BUILD_CORES
  '';

  installPhase = ''
    chmod -R u+rwX $STAGING_DIR || true
    make install
    symlinks -cr $STAGING_DIR || true
    mkdir $out
    cp -a $STAGING_DIR/. $out/
  '';
}
