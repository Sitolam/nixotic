_: {
  windowrulev2 = [
    # only allow shadows for floating windows
    "noshadow, floating:0"

    # idle inhibit while watching videos
    "idleinhibit focus, class:^(mpv|.+exe)$"
    "idleinhibit fullscreen, class:.*"

    # make Firefox PiP window floating and sticky
    "float, title:^(Picture-in-Picture)$"
    "pin, title:^(Picture-in-Picture)$"

    "float, class:^(1Password)$"
    "stayfocused,title:^(Quick Access — 1Password)$"
    "dimaround,title:^(Quick Access — 1Password)$"
    "noanim,title:^(Quick Access — 1Password)$"

    "float, class:^(org.gnome.*)$"
    "float, class:^(pavucontrol)$"
    "float, class:(blueberry\.py)"

    # make pop-up file dialogs floating, centred, and pinned
    "float, title:(Open|Progress|Save File)"
    "center, title:(Open|Progress|Save File)"
    "pin, title:(Open|Progress|Save File)"
    "float, class:^(code)$"
    "center, class:^(code)$"
    "pin, class:^(code)$"

    # assign windows to workspaces
    "workspace 1 silent, class:[Ff]irefox"
    "workspace 2 silent, class:[Oo]bsidian"
    "workspace 2 silent, class:google-chrome"
    "workspace 2 silent, class:[Rr]ambox"
    "workspace 1 silent, class:[Ss]ignal"
    "workspace 5 silent, class:code-url-handler"

    # throw sharing indicators away
    "workspace special silent, title:^(Firefox — Sharing Indicator)$"
    "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"


    # add some blur
    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    
    "opacity 0.90 0.90,class:^(firefox)$"
    "opacity 0.90 0.90,class:^(Brave-browser)$"
    "opacity 0.80 0.80,class:^(Steam)$"
    "opacity 0.80 0.80,class:^(steam)$"
    "opacity 0.80 0.80,class:^(steamwebhelper)$"
    "opacity 0.80 0.80,class:^(Spotify)$"
    "opacity 0.80 0.80,class:^(Code)$"
    "opacity 0.80 0.80,class:^(code-url-handler)$"
    "opacity 0.80 0.80,class:^(kitty)$"
    "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
    "opacity 0.80 0.80,class:^(org.kde.ark)$"
    "opacity 0.80 0.80,class:^(nwg-look)$"
    "opacity 0.80 0.80,class:^(qt5ct)$"
    "opacity 0.80 0.80,class:^(qt6ct)$"
    "opacity 0.80 0.80,class:^(kvantummanager)$"
    
    "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$" #Clapper-Gtk
    "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$" #Flatseal-Gtk
    "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$" #Cartridges-Gtk
    "opacity 0.80 0.80,class:^(com.obsproject.Studio)$" #Obs-Qt
    "opacity 0.80 0.80,class:^(gnome-boxes)$" #Boxes-Gtk
    "opacity 0.80 0.80,class:^(discord)$" #Discord-Electron
    "opacity 0.80 0.80,class:^(WebCord)$" #WebCord-Electron
    "opacity 0.80 0.80,class:^(ArmCord)$" #ArmCord-Electron
    "opacity 0.80 0.80,class:^(app.drey.Warp)$" #Warp-Gtk
    "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$" #ProtonUp-Qt
    "opacity 0.80 0.80,class:^(yad)$" #Protontricks-Gtk
    "opacity 0.80 0.80,class:^(Signal)$" #Signal-Gtk
    "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$" #planify-Gtk
    "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$" #Upscaler-Gtk
    "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$" #VideoDownloader-Gtk
    
    "opacity 0.80 0.70,class:^(pavucontrol)$"
    "opacity 0.80 0.70,class:^(blueman-manager)$"
    "opacity 0.80 0.70,class:^(nm-applet)$"
    "opacity 0.80 0.70,class:^(nm-connection-editor)$"
    "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
    
    "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
    "float,title:^(Picture-in-Picture)$"
    "float,class:^(firefox)$,title:^(Library)$"
    "float,class:^(vlc)$"
    "float,class:^(kvantummanager)$"
    "float,class:^(qt5ct)$"
    "float,class:^(qt6ct)$"
    "float,class:^(nwg-look)$"
    "float,class:^(org.kde.ark)$"
    "float,class:^(Signal)$" #Signal-Gtk
    "float,class:^(com.github.rafostar.Clapper)$" #Clapper-Gtk
    "float,class:^(app.drey.Warp)$" #Warp-Gtk
    "float,class:^(net.davidotek.pupgui2)$" #ProtonUp-Qt
    "float,class:^(yad)$" #Protontricks-Gtk
    "float,class:^(eog)$" #Imageviewer-Gtk
    "float,class:^(io.github.alainm23.planify)$" #planify-Gtk
    "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" #Upscaler-Gtk
    "float,class:^(com.github.unrud.VideoDownloader)$" #VideoDownloader-Gkk
    "float,class:^(pavucontrol)$"
    "float,class:^(blueman-manager)$"
    "float,class:^(nm-applet)$"
    "float,class:^(nm-connection-editor)$"
    "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
    "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
    "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
    
    
    
  ];
  layerrule = [
  	# █░░ ▄▀█ █▄█ █▀▀ █▀█   █▀█ █░█ █░░ █▀▀ █▀
    # █▄▄ █▀█ ░█░ ██▄ █▀▄   █▀▄ █▄█ █▄▄ ██▄ ▄█
    
    
    "blur,rofi"
    "ignorezero,rofi"
    "blur,notifications"
    "ignorezero,notifications"
    "blur,swaync-notification-window"
    "ignorezero,swaync-notification-window"
    "blur,swaync-control-center"
    "ignorezero,swaync-control-center"
    "blur,logout_dialog"
  ];
}
