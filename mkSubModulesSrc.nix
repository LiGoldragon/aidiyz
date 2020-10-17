mkSubmodulesSrc {
  root = rootGitRepoFlake.self;

  submodules = {
    "submodule/insubdir/repo" = repoFlake.self;

    systemd = fetchGit {
      url = file:///git/github.com/systemd/systemd;
      rev = "ae366f3acbc1a45504e9875099b17a7e1a221d03";
    };

  };
}
