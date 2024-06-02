\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume-zh}[2023-10-12 Resume class for Xiangdong Zeng (Chinese)]
\LoadClass{article}

\usepackage{ctexheading}
\usepackage{enumitem}
\usepackage{fancyhdr}
\usepackage{geometry}
\usepackage{ragged2e}
\usepackage{xcolor}
\usepackage[no-math]{xeCJK}
\usepackage[bookmarks=false]{hyperref}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
\linespread{1.15}\selectfont
\setlist{parsep=0pt, topsep=0pt, itemsep=0pt, leftmargin=1.2em}
\geometry{a4paper, hmargin=2cm, vmargin=1.25cm, footskip=10.25pt}
% \geometry{showframe}

\ExplSyntaxOn
\ctex_patch_cmd:Nnn \@iiiminipage
  { \@setminipage }
  { \@setminipage \RaggedRight }
\ExplSyntaxOff

\definecolor{gray}{HTML}{a3a3a3}
\definecolor{headings}{HTML}{3b82f6}
\definecolor{subheadings}{HTML}{333333}

\setCJKmainfont{Source Han Serif SC}[ItalicFont=*]
\setmainfont{Crimson}[
  Extension      = .otf,
  UprightFont    = *-Roman,
  ItalicFont     = *-Italic,
  BoldFont       = *-Bold,
  BoldItalicFont = *-BoldItalic,
  Scale          = 1.05,
]

\ctexset{
  section = {
    numbering  = false,
    format     = \color{headings}\Large,
    beforeskip = 16pt,
    afterskip  = 12pt,
    fixskip    = true,
  },
  subsection = {
    numbering  = false,
    format     = \color{subheadings}\bfseries\large,
    beforeskip = 12pt,
    afterskip  = 8pt,
    fixskip    = true,
  },
  paragraph = {
    runin      = false,
    format     = \color{gray}\normalfont\normalsize,
    beforeskip = 8pt,
    afterskip  = 4pt,
    fixskip    = true,
  }
}
\ExplSyntaxOn
\xeCJK_new_class:n { PoZheHao }
\__xeCJK_save_CJK_class:n { PoZheHao }
\xeCJK_declare_char_class:nn { PoZheHao } { "2014 }
\seq_map_inline:Nn \g__xeCJK_class_seq
  {
    \str_if_eq:nnF {#1} { PoZheHao }
      {
        \xeCJK_copy_inter_class_toks:nnnn { PoZheHao } {#1} { FullRight } {#1}
        \xeCJK_copy_inter_class_toks:nnnn {#1} { PoZheHao } {#1} { FullRight }
      }
  }
\ExplSyntaxOff

\ExplSyntaxOn
\cs_new:Npn \now
  {
    \the\year \raisebox{0.05em}{-}
    \int_compare:nNnT { \c_sys_month_int  } < { 10 } { 0 }
    \int_use:N \c_sys_month_int \raisebox{0.05em}{-}
    \int_compare:nNnT { \c_sys_day_int    } < { 10 } { 0 }
    \int_use:N \c_sys_day_int {} ~
    \int_compare:nNnT { \c_sys_hour_int   } < { 10 } { 0 }
    \int_use:N \c_sys_hour_int :
    \int_compare:nNnT { \c_sys_minute_int } < { 10 } { 0 }
    \int_use:N \c_sys_minute_int
  }
\ExplSyntaxOff
\newcommand{\lastupdated}{%
  \thispagestyle{fancy}%
  \fancyhf{}%
  \renewcommand\headrulewidth{0pt}%
  \rfoot{\footnotesize\textcolor{gray}{Last updated: \now}}}

\newcommand{\namesection}[2]{{
  \hypersetup{hidelinks}%
  \noindent\centering
  \fontsize{30pt}{40pt}\bfseries\selectfont #1
  \par
  \fontsize{10pt}{18pt}\normalfont\color{gray}\selectfont #2
  \par
  \noindent\makebox[\linewidth]{\color{gray}\rule{\paperwidth}{0.4pt}}
  \vspace{-16pt}
}}

\let\resume@subsection\subsection
\RenewDocumentCommand{\subsection}{mo}{
  \IfNoValueTF{#2}{
    \resume@subsection{#1}
  }{
    \resume@subsection{#1\allowbreak\enspace\textcolor{gray}{\normalfont\normalsize#2}}
  }
}

\newcommand{\location}[1]{\textcolor{gray}{#1}}
