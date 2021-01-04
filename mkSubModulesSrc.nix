let
  recomposedInputAkaGitSubmodules = mkSubmodulesSrc {
    root = rootGitRepoFlake;

    submodules = {
      "submodule/insubdir/repo" = repoFlake;

      systemd = fetchGit {
        url = file:///git/github.com/systemd/systemd;
        rev = "ae366f3acbc1a45504e9875099b17a7e1a221d03";
      };
    };
  };

  decomposedInputAkaRustCratesFromGit = decomposeSrc {
    src = someFlake;
    outputs = {
      outputNameFoo = [ "path/fileToKeep.cpp" "makefile" ];
      outputNameBar = [ "src/whatever.rs" "build.rs" ];
    };
  };

in
{
  rustProject = mkDerivation {
    # ...
    src = decomposedInputAkaRustCratesFromGit.outputNameBar;
  };

  cppProject = mkDerivation {
    # ...
    src = decomposedInputAkaRustCratesFromGit.outputNameFoo;
  };

  submodulesProject = mkDerivation {
    # ...
    src = recomposedInputAkaGitSubmodules;
  };
}
