{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        LOGSTASH_PATH = toString pkgs.logstash7-oss;
        LOGSTASH_SOURCE = "1";
        buildInputs = with pkgs; [
          jruby
          logstash7-oss
        ];
      };
    }
  );
}
