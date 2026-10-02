{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Gustav Tonér";
      user.email = "gustav.toner@gmail.com";
      init.defaultBranch = "main";
      alias = {
        a = "add";
        aa = "add --all";
        ci = "commit";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        cl = "clone";
        cm = "commit -m";
        co = "checkout";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        rbi = "rebase -i";
        st = "status";
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };
  };

  programs.gh = {
    enable = true;
    settings.aliases = {
      co = "pr checkout";
      pv = "pr view";
    };
    extensions = [ pkgs.gh-s ];
  };

  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };

  programs.claude-code.enable = true;
}
