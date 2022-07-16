{
  description = ''SOCKS server and client'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimSocks-master.flake = false;
  inputs.src-nimSocks-master.ref   = "refs/heads/master";
  inputs.src-nimSocks-master.owner = "enthus1ast";
  inputs.src-nimSocks-master.repo  = "nimSocks";
  inputs.src-nimSocks-master.type  = "github";
  
  inputs."nimsha2".owner = "nim-nix-pkgs";
  inputs."nimsha2".ref   = "master";
  inputs."nimsha2".repo  = "nimsha2";
  inputs."nimsha2".dir   = "master";
  inputs."nimsha2".type  = "github";
  inputs."nimsha2".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimsha2".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."dbg".owner = "nim-nix-pkgs";
  inputs."dbg".ref   = "master";
  inputs."dbg".repo  = "dbg";
  inputs."dbg".dir   = "master";
  inputs."dbg".type  = "github";
  inputs."dbg".inputs.nixpkgs.follows = "nixpkgs";
  inputs."dbg".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/enthus1ast/nimisprivateip".owner = "nim-nix-pkgs";
  inputs."github.com/enthus1ast/nimisprivateip".ref   = "master";
  inputs."github.com/enthus1ast/nimisprivateip".repo  = "github.com/enthus1ast/nimisprivateip";
  inputs."github.com/enthus1ast/nimisprivateip".dir   = "";
  inputs."github.com/enthus1ast/nimisprivateip".type  = "github";
  inputs."github.com/enthus1ast/nimisprivateip".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/enthus1ast/nimisprivateip".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimSocks-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimSocks-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}