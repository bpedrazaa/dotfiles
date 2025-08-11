/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx        = 2;   /* border pixel of windows */
static const unsigned int gappx           = 15;  /* gaps between windows */
static const unsigned int snap            = 32;  /* snap pixel */
static const int showbar                  = 1;   /* 0 means no bar */
static const int topbar                   = 1;   /* 0 means bottom bar */
static const int swallowfloating          = 0;   /* 1 means swallow floating windows by default */
static const unsigned int systraypinning  = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft   = 0;   /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing  = 2;   /* systray spacing */
static const int systraypinningfailfirst  = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const unsigned int systrayiconsize = 18;  /* systray icon size in px */
static const int showsystray              = 1;   /* 0 means no systray */
static const char *fonts[]                = { "JetBrainsMonoNerdFont:size=12:antialias=true:style=SemiBold" };
static const char dmenufont[]             = "JetBrainsMonoNerdFont:size=12:antialias=true:style=SemiBold";
static const char col_gray1[]             = "#222222";
static const char col_gray2[]             = "#444444";
static const char col_gray3[]             = "#bbbbbb";
static const char col_gray4[]             = "#eeeeee";
static const char col_cyan[]              = "#81A1C1";
static const char *colors[][3]            = {
  /*               fg         bg         border   */
  [SchemeNorm] = { "#FFFFFF", "#000000", "#BCBCBC"  },
  [SchemeSel]  = { "#FFFFFF", "#555555", "#EFEFEF"  },
};

/* tagging */
static const char *tags[] = { "[1] ", "[2] 󰖟", "[3] ", "[4] 󰓇", "[5] ", "[6] ", "7", "8", "9" };

static const Rule rules[] = {
  /* xprop(1):
   *  WM_CLASS(STRING) = instance, class
   *  WM_NAME(STRING) = title
   */
  /* class              instance title           tags mask  isfloating  isterminal  noswallow  monitor */
  { "kitty",            NULL,    NULL,           0,         0,          1,          0,        -1 },
  { "st-256color",      NULL,    NULL,           0,         0,          1,          0,        -1 },
  { "firefox",          NULL,    NULL,           1 << 1,    0,          0,          -1,        0 },
  { "Double Commander", NULL,    NULL,           0,         1,          0,          0,         0 },
  { "Spotify",          NULL,    NULL,           1 << 3,    0,          0,          0,         0 },
  { "thunderbird",      NULL,    NULL,           1 << 4,    0,          0,          0,         0 },
  { "obs",              NULL,    NULL,           1 << 5,    0,          0,          0,         0 },
  { NULL,               NULL,    "Event Tester", 0,         0,          0,          1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.5;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
  /* symbol     arrange function */
  // { "[]=",      tile },    /* first entry is default */
  { "",      tile },    /* first entry is default */
  { "><>",      NULL },    /* no layout function means floating behavior */
  { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
  { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run_desktop", "-m", dmenumon, "-l" , "10", "-g", "3", NULL };
static const char *terminal[] = { "kitty", NULL };
static const char *browser[] = { "firefox", NULL };
static const char *spotify[] = { "spotify", NULL };
static const char *spotify_next[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.Next", NULL };
static const char *spotify_prev[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.Previous", NULL };
static const char *spotify_play_pause[] = { "dbus-send", "--print-reply", "--dest=org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2", "org.mpris.MediaPlayer2.Player.PlayPause", NULL };
static const char *obs[] = { "obs", NULL };
static const char *flameshot[] = { "flameshot", "gui", NULL };
static const char *doublecmd[] = { "doublecmd", NULL };

// Power Menu
static const char *powermenu[]  = {"/home/bpedrazaa/.config/dwm/scripts/powermenu.sh",   NULL};

// Laptop configuration
static const char *inclight[]  = {"/home/bpedrazaa/.config/dwm/scripts/brightness.sh", "up",   NULL};
static const char *declight[]  = {"/home/bpedrazaa/.config/dwm/scripts/brightness.sh", "down",   NULL};
static const char *incvolume[]  = {"/home/bpedrazaa/.config/dwm/scripts/volume.sh", "up",   NULL};
static const char *decvolume[]  = {"/home/bpedrazaa/.config/dwm/scripts/volume.sh", "down", NULL};
static const char *mutevolume[] = {"/home/bpedrazaa/.config/dwm/scripts/volume.sh", "mute", NULL};

static const Key keys[] = {
  /* modifier                     key           function        argument */
  /* apps */
  { MODKEY,                       XK_Return,    spawn,          {.v = terminal } },
  { MODKEY,                       XK_w,         spawn,          {.v = browser} },
  { MODKEY,                       XK_d,         spawn,          {.v = doublecmd} },
  { MODKEY,                       XK_s,         spawn,          {.v = spotify} },
  { ControlMask,                  XK_Right,     spawn,          {.v = spotify_next} },
  { ControlMask,                  XK_Left,      spawn,          {.v = spotify_prev} },
  { ControlMask,                  XK_Tab,       spawn,          {.v = spotify_play_pause} },
  { MODKEY,                       XK_o,         spawn,          {.v = obs} },
  { MODKEY,                       XK_space,     spawn,          {.v = dmenucmd} },
  { 0,                            XK_Print,     spawn,          {.v = flameshot } },
  { MODKEY,                       XK_BackSpace, spawn,          {.v = powermenu} },
  /* dwm shortcuts */
  { MODKEY,                       XK_b,         togglebar,      {0} },
  { MODKEY,                       XK_j,         focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,         focusstack,     {.i = -1 } },
  { MODKEY,                       XK_h,         setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,         setmfact,       {.f = +0.05} },
  { MODKEY|ShiftMask,             XK_Return,    zoom,           {0} },
  { MODKEY,                       XK_Tab,       view,           {0} },
  { MODKEY|ShiftMask,             XK_q,         quit,           {0} },
  { MODKEY,                       XK_q,         killclient,     {0} },
  { MODKEY|ShiftMask,             XK_space,     togglefloating, {0} },
  { MODKEY,                       XK_comma,     focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period,    focusmon,       {.i = +1 } },
  { MODKEY|ShiftMask,             XK_comma,     tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period,    tagmon,         {.i = +1 } },
  { MODKEY,                       XK_minus,     setgaps,        {.i = -1 } },
  { MODKEY,                       XK_equal,     setgaps,        {.i = +1 } },
  { MODKEY|ShiftMask,             XK_equal,     setgaps,        {.i = 0  } },

  {0, XF86XK_MonBrightnessUp,                   spawn,          {.v = inclight}},
  {0, XF86XK_MonBrightnessDown,                 spawn,          {.v = declight}},
  {0, XF86XK_AudioRaiseVolume,                  spawn,          {.v = incvolume}},
  {0, XF86XK_AudioLowerVolume,                  spawn,          {.v = decvolume}},
  {0, XF86XK_AudioMute,                         spawn,          {.v = mutevolume}},

  // { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  // { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
  // { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  // { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
  // { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  // { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  // { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  // { MODKEY,                       XK_space,  setlayout,      {0} },
  /* tags */
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  // { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  // { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  // { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  // { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
