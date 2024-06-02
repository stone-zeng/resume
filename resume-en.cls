\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume-en}[2023-10-12 Resume class for Xiangdong Zeng (English)]
\LoadClass{article}

\usepackage{ctexheading}
\usepackage{enumitem}
\usepackage{fancyhdr}
\usepackage[no-math]{fontspec}
\usepackage{geometry}
\usepackage{ragged2e}
\usepackage{xcolor}
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

\setmainfont{Crimson}[
  Extension      = .otf,
  UprightFont    = *-Roman,
  ItalicFont     = *-Italic,
  BoldFont       = *-Bold,
  BoldItalicFont = *-BoldItalic,
  Scale          = 1.05,
]
\setsansfont{SourceSansPro}[
  Extension   = .otf,
  UprightFont = *-Light,
  ItalicFont  = *-LightIt,
]
\newfontfamily\NameFont{SourceSansPro}[
  Extension   = .otf,
  UprightFont = *-ExtraLight,
  BoldFont    = *-Semibold,
  LetterSpace = 12,
]

\ctexset{
  section = {
    numbering  = false,
    format     = \color{headings}\sffamily\Large,
    beforeskip = 14pt,
    afterskip  = 10pt,
    fixskip    = true,
  },
  subsection = {
    numbering  = false,
    format     = \color{subheadings}\bfseries\large,
    beforeskip = 10pt,
    afterskip  = 6pt,
    fixskip    = true,
  },
  paragraph = {
    runin      = false,
    format     = \color{gray}\normalfont\normalsize,
    beforeskip = 6pt,
    afterskip  = 4pt,
    fixskip    = true,
  }
}

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

\newcommand{\namesection}[3]{{
  \hypersetup{hidelinks}%
  \noindent\centering
  \NameFont\fontsize{32pt}{48pt}\selectfont
  \textsc{#1\enspace\textbf{#2}}
  \par
  \fontsize{10pt}{18pt}\normalfont\color{gray}\selectfont #3
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
