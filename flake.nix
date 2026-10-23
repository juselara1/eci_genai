{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
      buildInputs = with pkgs; [
        python313
        uv
        ruff
        zuban
        ty
      ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.lib.makeLibraryPath buildInputs}";
        buildInputs = buildInputs;
        shellHook = ''
          		if [[ ! -d .venv/ ]]; then
          			echo "Creating initial virtual environment..."
          			uv venv && uv sync --no-dev
          		fi
          		echo "Activating environment"
          		source .venv/bin/activate
          		[[ -f ".env" ]] && source .env
              [[ -f "env.sh" ]] && source env.sh
          		'';
      };
    };
}

