{
  description = "Reveal-md devshell for running the presentations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-23.05;
  };

  outputs = {nixpkgs, ...}: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    devShell = genSystems (system: let
      inherit (pkgs.${system}) mkShell reveal-md;
    in
      mkShell {
        packages = [
          (reveal-md.override {
            dontNpmInstall = true;
            prePatch = ''
              export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
            '';
            postInstall = ''
              mkdir -p $out/bin
              ln -sf $out/lib/node_modules/reveal-md/bin/reveal-md.js $out/bin/reveal-md
            '';
          })
        ];
      });
  };
}
