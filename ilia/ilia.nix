
{
  pkgs,
  lib,
  stdenv,
  makeWrapper,
  fetchgit,
  json-glib,
  gettext,
  gobject-introspection,
  intltool,
  gtk3,
  tracker,
  meson,
  vala,
  cmake,
  pkg-config,
  libgee,
  ninja,
  gtk-layer-shell,
}:

stdenv.mkDerivation {
  pname = "ilia";
  version = "v0.0.0";

  src = fetchGit {
    url = "https://github.com/regolith-linux/ilia";
    ref = "ubuntu/jammy";
  };

  nativeBuildInputs = [

  ];

  buildInputs = [
    makeWrapper
    json-glib
    gettext
    gobject-introspection
    intltool
    gtk3
    tracker
    meson
    vala
    cmake
    pkg-config
    libgee
    ninja
    gtk-layer-shell
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp src/ilia $out/bin
    runHook postInstall
  '';

  postInstall = ''
    echo "Compiling Schemas"
    mkdir -p $out/share/glib-2.0/schemas/
    glib-compile-schemas --targetdir=$out/share/glib-2.0/schemas $src/data

    wrapProgram "$out/bin/ilia" --set XDG_DATA_DIRS "$out/share/gsettings-schemas/ilia-v0.0.0"
  '';

  meta = {
    description = "Regolith ilia";
  };
}
