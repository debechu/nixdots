{ pkgs, ... }:
let
  terminal = "kitty";
  file-manager = "${terminal} yazi";
  launcher-cmd = "rofi -show drun";
in
{
  home.packages = with pkgs;
    [
      (writeShellScriptBin "hyprland-login"
        ''
          waybar &
        '')
      (writeShellScriptBin "hyprland-logout"
        ''
          pkill waybar
        '')
    ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;

    # Only possible with Flakes
    # plugins = [ ];

    settings = {
      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
      ];
      workspace = [
        "1,monitor:eDP-1,persistent:true"
        "2,monitor:eDP-1,persistent:true"
        "3,monitor:eDP-1,persistent:true"
        "4,monitor:eDP-1,persistent:true"
        "5,monitor:eDP-1,persistent:true"
        "6,monitor:eDP-1,persistent:true"
      ];
      exec-once = [
        "hyprland-login"
      ];
      env = [
        "XCURSOR,24"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(fc9afaee) rgba(a37cffee) 30deg";
        "col.inactive_border" = "rgb(595959)";
        layout = "dwindle";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      decoration = {
        rounding = 10;
        drop_shadow = false;

        blur = {
          enabled = true;
          popups = true;
          size = 3;
          passes = 1;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "myBezier,0.05,0.9,0.1,1.05"
        ];
        animation = [
          "windows,1,7,myBezier"
          "windowsOut,1,7,default,popin 80%"
          "border,1,10,default"
          "borderangle,1,8,default"
          "fade,1,7,default"
          "workspaces,1,6,default"
        ];
      };
      gestures = {
        workspace_swipe = false;
      };
      input = {
        kb_layout = "de";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        accel_profile = "flat";
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };
      device = [
        {
          name = "keychron-keychron-k8-pro";
          kb_layout = "eu";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
        }
        {
          name = "keychron-keychron-k8-pro-keyboard";
          kb_layout = "eu";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
        }
      ];
      misc = {
        disable_hyprland_logo = true;
      };

      "$mainMod" = "SUPER";
      "$logout-cmd" = "hyprland-logout && hyprctl dispatch exit";
      bind = [
        "$mainMod,Q,exec,${terminal}"
        "$mainMod,C,killactive,"
        "$mainMod,M,exec,$logout-cmd"
        "$mainMod,E,exec,${file-manager}"
        "$mainMod,V,togglefloating,"
        "$mainMod,R,exec,${launcher-cmd}"
        "$mainMod,F,fullscreen,0"

        "$mainMod,H,movefocus,l"
        "$mainMod,J,movefocus,d"
        "$mainMod,K,movefocus,u"
        "$mainMod,L,movefocus,r"

        "$mainMod,1,workspace,1"
        "$mainMod,2,workspace,2"
        "$mainMod,3,workspace,3"
        "$mainMod,4,workspace,4"
        "$mainMod,5,workspace,5"
        "$mainMod,6,workspace,6"

        "$mainMod SHIFT,1,movetoworkspace,1"
        "$mainMod SHIFT,2,movetoworkspace,2"
        "$mainMod SHIFT,3,movetoworkspace,3"
        "$mainMod SHIFT,4,movetoworkspace,4"
        "$mainMod SHIFT,5,movetoworkspace,5"
        "$mainMod SHIFT,6,movetoworkspace,6"
      ];
      bindm = [
        "$mainMod,mouse:272,movewindow"
        "$mainMod,mouse:273,resizewindow"
      ];
    };
  };
}