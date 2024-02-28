{ config, pkgs, ... }:

{
  home.username = "brettsmith";
  home.homeDirectory = "/Users/brettsmith";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    jq
    ripgrep
    nix
    nodejs
    python3
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    # extraConfig = "colorscheme gruvbox \n inoremap jk <Esc>";
    # plugins = with pkgs.vimPlugins; [
      # vim-nix
      # gruvbox
    # ];
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -g status-right '#[fg=black,bg=color15] #{cpu_percentage}  %H:%M '
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux

      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.config/tmux/.tmux.conf

      # vim-like pane switching
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # resize panes
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R
      bind -r C-h resize-pane -L

      bind -r m resize-pane -Z

      set -g mouse on
    '';
  };
}
