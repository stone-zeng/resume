\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{resume}{2019-09-05}{v0.1}{Resume class for Xiangdong Zeng}

\LoadClass { article }
\RequirePackage
  {
    datetime2,
    enumitem,
    fontawesome5,
    fontspec,
    geometry,
    graphics,
    hologo,
    ragged2e,
    xcolor,
    xparse,
    hyperref,
  }

\setmainfont { Crimson }
\setsansfont { FiraSans~ Light }
\newfontfamily \__resume_font_title: { FiraSans }
  [
    UprightFont = *~ ExtraLight,
    BoldFont    = *~ Semibold,
    LetterSpace = 12,
  ]

\geometry
  {
    paper   = a4paper,
    hmargin = 1.5 cm,
    top     = 2.4 cm,
    bottom  = 1.2 cm,
  }

\setlist
  {
    parsep     = 0 pt,
    topsep     = 0 pt,
    itemsep    = 0 pt,
    leftmargin = 1.5 em,
  }

\hypersetup { pdfborder = 0 0 0 }

\pagestyle { empty }

\cs_new_protected:Npn \resume_font_size:nn #1#2
  { \fontsize {#1} {#2} \selectfont }
\cs_new_protected:Npn \resume_font_size:n #1
  { \resume_font_size:nn {#1} { \fp_eval:n { #1*1.2 } } }

\cs_set:Npn \resume_gray_color:  { \color [HTML] {757575} }
\cs_set:Npn \resume_theme_color: { \color [HTML] {009688} }

\DeclareDocumentCommand \maketitle { }
  {
    \vspace* {-12ex}

    \begin{center}
      % Name
      \group_begin:
        \resume_font_size:n {36}
        \__resume_font_title:
        \scshape  \g__resume_name_a_str \enspace
        \bfseries \g__resume_name_b_str \par
      \group_end:

      \vspace {4ex}

      % Information
      \group_begin:
        \resume_gray_color:
        \clist_set:Nn \l_tmpa_clist
          {
            \__resume_icon_text:nn     { \faMobile*           }
              { \str_use:N \g__resume_phone_str },
            \__resume_icon_text_url:nn { \faEnvelope[regular] } { mail    },
            \__resume_icon_text_url:nn { \faGithub            } { github  },
            \__resume_icon_text_url:nn { \faTwitter           } { twitter },
          }
        \clist_use:Nn \l_tmpa_clist { \quad \textbullet \quad }
        \par
      \group_end:

      \vspace {1ex}
      \hrulefill
      \vspace {-2ex}
    \end{center}

    % PDF metadata
    \group_begin:
      \str_set:Nx \l_tmpa_str {  \g__resume_name_a_str\ \g__resume_name_b_str }
      \hypersetup
        {
          pdfauthor = { \l_tmpa_str },
          pdftitle  = { Resume~ of~ \l_tmpa_str }
        }
    \group_end:
  }

\cs_new_protected:Npn \__resume_icon_text:nn #1#2
  {
    \scalebox {0.75} {#1}
    \hspace {0.3em}
    #2
  }

\cs_new_protected:Npn \__resume_icon_text_url:nn #1#2
  {
    \__resume_icon_text:nn {#1}
      {
        \exp_args:Nx \href
          { \str_use:c { g__resume_ #2 _url_str } }
          { \str_use:c { g__resume_ #2 _str     } }
      }
  }

\NewDocumentCommand \name { m m }
  {
    \str_gset:Nn \g__resume_name_a_str {#1}
    \str_gset:Nn \g__resume_name_b_str {#2}
  }
\str_new:N \g__resume_name_a_str
\str_new:N \g__resume_name_b_str

\NewDocumentCommand \phone { m }
  { \str_gset:Nn \g__resume_phone_str {#1} }
\str_new:N \g__resume_phone_str

\cs_new_protected:Npn \__resume_def_url_aux:nn #1#2
  {
    \str_new:c { g__resume_ #1     _str }
    \str_new:c { g__resume_ #1 _url_str }
    \cs_set_protected:cpn {#1}
      {
        \group_begin:
          \__resume_set_specials:
          \cs_set_protected:cpn { __resume_ #1 _ aux } ####1
            {
                \str_gset:cn { g__resume_ #1     _str } {    ####1 }
                \str_gset:cn { g__resume_ #1 _url_str } { #2 ####1 }
                \__resume_restore_specials:
              \group_end:
            }
          \use:c { __resume_ #1 _ aux }
      }
  }
\cs_new_protected:Npn \__resume_set_specials:
  {
    \char_set_catcode_other:N \_
    \char_set_catcode_other:N \$
  }
\cs_new_protected:Npn \__resume_restore_specials:
  {
    \char_set_catcode_math_subscript:N \_
    \char_set_catcode_math_toggle:N    \$
  }
\__resume_def_url_aux:nn { mail    } { mailto:              }
\__resume_def_url_aux:nn { github  } { https://github.com/  }
\__resume_def_url_aux:nn { twitter } { https://twitter.com/ }

\NewDocumentEnvironment { leftpanel } { +b }
  { \tl_gset:Nn \g__resume_left_panel_tl {#1} } { }
\NewDocumentEnvironment { rightpanel } { +b }
  { \tl_gset:Nn \g__resume_right_panel_tl {#1} } { }
\tl_new:N \g__resume_left_panel_tl
\tl_new:N \g__resume_right_panel_tl

\NewDocumentCommand \makebody { O {0.6} O {20pt} }
  {
    \dim_set:Nn \l__resume_left_panel_wd_dim
      { #1 \textwidth - #2 / 2 }
    \dim_set:Nn \l__resume_rightt_panel_wd_dim
      { \fp_eval:n { 1 - #1 } \textwidth - #2 / 2 }
    \noindent
    \begin{tabular}
        {
          @ { } p { \dim_use:N \l__resume_left_panel_wd_dim }
          @ { \hspace {#2} }
          p { \dim_use:N \l__resume_rightt_panel_wd_dim } @{ }
        }
      \RaggedRight \g__resume_left_panel_tl &
      \raggedright \g__resume_right_panel_tl
    \end{tabular}
    \vfill

    % Page foot
    \group_begin:
      \resume_gray_color:
      \resume_font_size:n { 6 }
      \sffamily
      \hfill Last~ updated:~ { \DTMnow }
    \group_end:
  }
\dim_new:N \l__resume_left_panel_wd_dim
\dim_new:N \l__resume_rightt_panel_wd_dim

\DeclareDocumentCommand \section { m }
  {
    \vspace {2ex}
    \group_begin:
      \resume_theme_color:
      \resume_font_size:n { 18 }
      \sffamily
      #1
    \group_end:
    \vspace {2ex}
    \par
  }

\NewDocumentEnvironment { entry } { m m m }
  {
    \group_begin:
      \resume_gray_color:
      \resume_font_size:n { 8 }
      \sffamily
      #2 \hfill #3
    \group_end:
    \par
    \group_begin:
      \resume_font_size:n { 10 }
      \bfseries
      #1
    \group_end:
    \par
    \itemize
  }
  { \enditemize \vspace {1ex} }

\NewDocumentEnvironment { entry* } { m }
  {
    \group_begin:
      \resume_font_size:n { 10 }
      \bfseries
      #1
    \group_end:
    \par
    \itemize
  }
  { \enditemize \vspace {1ex} }

\DeclareDocumentCommand \LaTeX { }
  {
    L
    \kern -.34em
    \raisebox {.21em} { \scshape a }
    \kern -.15em
    \TeX
  }
\DeclareDocumentCommand \TeX    { } { \hologo { TeX    } }
\DeclareDocumentCommand \pdfTeX { } { \hologo { pdfTeX } }
\DeclareDocumentCommand \XeTeX  { } { \hologo { XeTeX  } }
\DeclareDocumentCommand \LuaTeX { } { \hologo { LuaTeX } }
\DeclareDocumentCommand \ApTeX  { } { Ap \kern -.05em \TeX }
\DeclareDocumentCommand \CTeX   { } { C \TeX }

\cs_set:Npn \slash
  { \hspace{0.1em} / \hspace{0.1em} }

\endinput
