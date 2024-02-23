{ pkgs
, lib
, ...
}:
let
  version = "0.7.2";
in
pkgs.buildGoModule rec {
  inherit version;
  pname = "scrutiny-collector";

  src = pkgs.fetchFromGitHub {
    owner = "AnalogJ";
    repo = "scrutiny";
    rev = "refs/tags/v${version}";
    hash = "sha256-UYKi+WTsasUaE6irzMAHr66k7wXyec8FXc8AWjEk0qs=";
  };

  subPackages = "collector/cmd/collector-metrics";

  vendorHash = "sha256-SiQw6pq0Fyy8Ia39S/Vgp9Mlfog2drtVn43g+GXiQuI=";

  buildInputs = with pkgs; [ makeWrapper ];

  CGO_ENABLED = 0;

  ldflags = [ "-extldflags=-static" ];

  tags = [ "static" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $GOPATH/bin/collector-metrics $out/bin/scrutiny-collector-metrics
    wrapProgram $out/bin/scrutiny-collector-metrics \
      --prefix PATH : ${lib.makeBinPath [ pkgs.smartmontools ]}
    runHook postInstall
  '';

  meta = {
    description = "Hard disk metrics collector for Scrutiny.";
    homepage = "https://github.com/AnalogJ/scrutiny";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
    mainProgram = "scrutiny-collector-metrics";
    platforms = lib.platforms.linux;
  };
}
