{ config, lib, pkgs, ... }:

{
    programs.cmus = with config.renix.activeTheme.termColour; {
        enable = true;
        extraConfig = ''
            set format_current=%{artist} - %{album}%! - %{title}
            set format_heading_album=%{artist} - %{album}%= %{duration}
            set format_heading_artist=%{artist}%= %{duration}
            set format_title=%{artist} - %{album} - %{title}
            set format_trackwin=%{title}%= %{duration}
            set format_trackwin_album=%{album} %= %{duration}
            set format_treewin=  %{album}
            set sort_albums_by_name=true
            set pause_on_output_change=true
            set auto_expand_albums_search=false
            set repeat=true
            set color_cmdline_bg=${mainBg}
            set color_cmdline_fg=${mainFg}
            set color_cmdline_attr=bold
            set color_separator=${accentFg}
            set color_statusline_bg=${mainBg}
            set color_statusline_fg=${mainFg}
            set color_statusline_attr=default
            set color_titleline_bg=${accentBg}
            set color_titleline_fg=${accentFg}
            set color_titleline_attr=bold
            set color_win_bg=${mainBg}
            set color_win_cur=${mainFg}
            set color_win_cur_attr=bold
            set color_win_cur_sel_bg=${accentBg}
            set color_win_cur_sel_fg=${accentFg}
            set color_win_cur_sel_attr=bold
            set color_win_dir=${mainFg}
            set color_win_fg=${mainFg}
            set color_win_inactive_cur_sel_bg=${mainBg}
            set color_win_inactive_cur_sel_fg=${mainFg}
            set color_win_inactive_cur_sel_attr=bold
            set color_win_inactive_sel_bg=${mainBg}
            set color_win_inactive_sel_fg=${mainFg}
            set color_win_sel_bg=${accentBg}
            set color_win_sel_fg=${accentFg}
            set color_win_sel_attr=bold
            set color_win_title_bg=${accentBg}
            set color_win_title_fg=${accentFg}
            set color_win_title_attr=bold
            fset soundtrack=artist="Soundtracks"
            factivate !soundtrack
        '';
    };
}
