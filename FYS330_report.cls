\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{330_report}
[2020 report style used in Tampere University]

% Inherit from the report document class.
\LoadClass[11pt, a4paper, hidelinks]{report}

% Gain access to internal macros.
\makeatletter

%%%%% CLASS OPTIONS %%%%%
\newcommand{\@mainlanguage}{english} %finnish
\newcommand{\@otherlanguage}{english}
\newcommand{\@citationstyle}{numeric}

% Language selection.
\newif\if@langenglish\@langenglishfalse
\DeclareOption{english}{%
    \@langenglishtrue
    \renewcommand{\@mainlanguage}{english}
    \renewcommand{\@otherlanguage}{finnish}
}
\DeclareOption{finnish}{%
    \@langenglishfalse
    \renewcommand{\@mainlanguage}{finnish}
    \renewcommand{\@otherlanguage}{english}
}

% Citation style selection.
\DeclareOption{numeric}{%
    \renewcommand{\@citationstyle}{numeric}
}
\DeclareOption{authoryear}{%
    \renewcommand{\@citationstyle}{authoryear}
}

\DeclareOption*{
  \ClassWarning{tauthesis}{Unknown option '\CurrentOption'}
}

% Default options.
% \ExecuteOptions{finnish,numeric}
\ExecuteOptions{english,numeric}

\ProcessOptions\relax

%%%%% PACKAGES %%%%%
\RequirePackage[utf8]{inputenc}

% Graphs
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.15}

% Subfigures and wrapping text
\RequirePackage{subcaption}

% Mathematics packages
\RequirePackage{amsmath, amssymb}
%\usepackage{bm}

% date commands
\RequirePackage[nodayofweek]{datetime}
% ISO-19005 compliant document (pdf/A-1b)
% Requires sRGB_IEC61966-2-1_black_scaled.icc
\RequirePackage[a-1b]{pdfx}

% UTF-8 input
\RequirePackage[utf8]{inputenc}

% Arial-like font selection
\RequirePackage{helvet}

\RequirePackage[T1]{fontenc}

\renewcommand\familydefault{\sfdefault}
\fontfamily{\familydefault}\selectfont

\let\openbox\undefined

% Page geometry and heading handling
\RequirePackage
    [top=2.5cm,
    bottom=2.5cm,
    left=4cm,
    right=2cm]{geometry}
\special{papersize={210mm,297mm}}
\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
\RequirePackage{setspace}
\RequirePackage{parskip}

\spacing{1.213}
\setlength{\headheight}{13.6pt}

\newlength\chapterspace
\setlength\chapterspace{0.4cm}

% Try to prevent large figures appearing
% by themselves without any text. Be
% careful not to make \floatpagefraction
% larger than \topfraction.
\renewcommand{\topfraction}{0.85}        % default 0.7
\renewcommand{\textfraction}{0.1}        % default 0.2
\renewcommand{\floatpagefraction}{0.75}

% Define the header and footer content.

\pagestyle{fancyplain}
\fancyhf{}
\rhead{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Define chapter and section heading styles.

\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

% Chapter
\titleformat
    {\chapter}{\raggedright\bf\LARGE\sffamily}
    {\thechapter}{\chapterspace}
    {\fancyhf{}\rhead{\thepage}\MakeUppercase{#1}}
\titleformat
    {name=\chapter, numberless}
    {\raggedright\bf\LARGE\sffamily}{}{0em}
    {\fancyhf{}\rhead{\thepage}\MakeUppercase{#1}}
\titlespacing{\chapter}{0em}{42pt}{42pt}
\titlespacing{name=\chapter, numberless}{0em}{18pt}{18pt}

% Section
\titleformat
    {\section}{\raggedright\bf\Large\sffamily}
    {\thesection}{\chapterspace}{#1}
\titleformat
    {name=\section, numberless}
    {\raggedright\bf\Large\sffamily}{}{0em}{#1}
\titlespacing{\section}{0em}{18pt}{12pt}
\titlespacing{name=\section, numberless}{0em}{18pt}{12pt}

% Subsection
\titleformat
    {\subsection}{\raggedright\bf\Large\sffamily}
    {\thesubsection}{\chapterspace}{#1}
\titleformat
    {name=\subsection, numberless}
    {\raggedright\bf\Large\sffamily}{}{0em}{#1}
\titlespacing{\subsection}{0em}{18pt}{12pt}
\titlespacing{name=\subsection, numberless}{0em}{18pt}{12pt}

% Subsubsection
\titleformat
    {\subsubsection}{\raggedright\bf\large\sffamily}
    {\thesubsubsection}{\chapterspace}{#1}
\titleformat
    {name=\subsubsection, numberless}
    {\raggedright\bf\large\sffamily}{}{0em}{#1}
\titlespacing{\subsubsection}{0em}{18pt}{12pt}
\titlespacing{name=\subsubsection, numberless}{0em}{18pt}{12pt}

% Language support for Finnish and English
\RequirePackage[\@otherlanguage, main=\@mainlanguage]{babel}
\RequirePackage{csquotes}

% Powerful color package
\RequirePackage{xcolor}
\definecolor{taupurple}{RGB}{78,0,148}

% Date and time handling
% \RequirePackage[en-GB,finnish]{datetime2}
% \DTMlangsetup[en-GB,finnish]{showdayofmonth=false}
\RequirePackage[en-GB]{datetime2} %,english
\DTMlangsetup[en-GB]{showdayofmonth=false,monthyearsep={,\space}}



\usepackage[super]{nth}

% Extra packages needed for the example Gantt-chart / task-list tables
% further below (Chapter 2). Keep these even if you redesign the tables,
% since they are what makes the shaded Gantt cells and long tables possible.
\usepackage{array}     % fixed-width table columns (>{...} column spec)
\usepackage{colortbl}  % \cellcolor for shading Gantt cells
\usepackage{longtable} % in case the task list grows across pages
\usepackage{booktabs}  % \toprule / \midrule / \bottomrule for clean table rules


% ---------------------------------------------------------------------
% A small helper environment for the guidance notes sprinkled through
% this template. Delete individual notes as you replace them with your
% own content -- by the time your document is finished, no instruction
% boxes should remain.
% ---------------------------------------------------------------------
\newcommand{\instructionbox}[1]{%
  \begin{quote}
  \small\itshape\color{taupurple}
  \textbf{Template instructions:} #1
  \end{quote}
}

% ---------------------------------------------------------------------
% Helpers for the full-width Gantt chart in Chapter 2: a shared length
% for the week columns (computed from \textwidth so the chart always
% spans the full text block regardless of margins), and two macros that
% shade a week-cell AND print its week number in it, so each active
% cell is self-labelled instead of only being readable via the header.
% ---------------------------------------------------------------------
\newlength{\wkcolwidth}
\newlength{\tlremaining}
\newcommand{\gwk}[1]{\cellcolor{taupurple!55}\textcolor{white}{\tiny\textbf{#1}}}   % active week
\newcommand{\gwkm}[1]{\cellcolor{taupurple!90}\textcolor{white}{\tiny\textbf{#1}}} % milestone week
\newcommand{\gdl}[1]{\cellcolor{orange!70}\textcolor{white}{\tiny\textbf{#1}}}     % deliverable marker

% Smart bibliography handling
\RequirePackage
    [backend=biber,
    sorting=nyt,
    citestyle=\@citationstyle,
    bibstyle=\@citationstyle,
    maxbibnames=99,
    giveninits=true,
    uniquename=init,
    sortcites,
    sortlocale=fin]{biblatex}

\DefineBibliographyStrings{finnish}{%
  bibliography = {Lähteet},
  references = {Lähteet},
  in = {}
}
\DefineBibliographyStrings{english}{%
  bibliography = {References},
  references = {References},
  in = {}
}

\DeclareNameAlias{sortname}{last-first}

\DeclareFieldFormat[%
  article,inbook,incollection,inproceedings,
  patent,thesis,unpublished]{citetitle}{#1\isdot}
\DeclareFieldFormat[%
  article,inbook,incollection,inproceedings,
  patent,thesis,unpublished]{title}{#1\isdot}
\DeclareFieldFormat{pages}{#1}

\AtBeginBibliography{\renewcommand*{\makelabel}[1]{#1\hss}}

\DefineBibliographyExtras{english}{\let\finalandcomma=\empty}

% Graphics inclusion and drawing
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc}

% Caption formatting
\RequirePackage
    [labelfont={bf,it},
    font=it,
    labelsep=period]{caption}
\renewcommand{\arraystretch}{1.25}

% (SI) unit handling
\RequirePackage{siunitx}

\sisetup{
    detect-all,
    math-sf=\mathrm, %roman
    %math-sf=\mathsf, %sans serif
    exponent-product=\cdot
}

\if@langenglish
    \sisetup{output-decimal-marker={.}}
\else
    \sisetup{output-decimal-marker={,}}
\fi

% Code listing handling
\RequirePackage{listings}

% textcl=true courtesy of Mika Kuitula
\lstset{texcl=true, captionpos=b, commentstyle=\tt}

% List of symbols and abbreviations, remove automake
\RequirePackage[nonumberlist, nopostdot]{glossaries}

\if@langenglish
    \newcommand{\@glossaryname}{List of Symbols and Abbreviations}
\else
    \newcommand{\@glossaryname}{Lyhenteet ja merkinnät}
\fi

\renewcommand{\glossary}{
    \glsaddall
    \setglossarystyle{long}
    \setlength{\glsdescwidth}{0.75\textwidth}
    \renewcommand*{\glsgroupskip}{}
    \printglossary[title=\@glossaryname]
}

% Table of contents formatting
\RequirePackage[titles]{tocloft}
%\RequirePackage[nottoc]{tocbibind}
\RequirePackage[titletoc]{appendix}

\if@langenglish
    \addto\captionsenglish{%
        \renewcommand{\contentsname}{Contents}%
        \renewcommand\listfigurename{List of Figures}%
        \renewcommand{\listtablename}{List of Tables}%
    }
    \renewcommand{\lstlistlistingname}{List of Programs and Algorithms}
\else
    \addto\captionsfinnish{%
        \renewcommand{\contentsname}{Sisällysluettelo}%
        \renewcommand\listfigurename{Kuvaluettelo}%
        \renewcommand{\listtablename}{Taulukkoluettelo}%
    }
    \renewcommand{\lstlistlistingname}{Ohjelma- ja algoritmiluettelo}
\fi

 
\renewcommand\cftchapfont{}
\renewcommand{\cftchappagefont}{}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{1pt}
\setlength{\cftbeforesecskip}{1pt}

% Flexible list modifications
\RequirePackage{enumitem}

\setlist{itemsep=-3pt, labelindent=1.27cm}

\RequirePackage{amsthm}


%%%%% COMMAND DEFINITIONS %%%%%

% Functional language selection
\newcommand{\xselectlanguage}[1]{%
  \begingroup\edef\x{\endgroup
    \noexpand\selectlanguage{#1}}\x
}

% \title command
\renewcommand{\title}[2]{%
    \gdef\@title{#1}
    \gdef\@othertitle{#2}
}
\renewcommand{\@title}[1]{
    \@latex@warning@no@line{No \noexpand\title given.}
}
\newcommand{\@othertitle}[1]{
    \@latex@warning@no@line{No \noexpand\othertitle given.}
}

% \subtitle command
\newcommand{\subtitle}[2]{%
    \gdef\@subtitle{#1}
    \gdef\@othersubtitle{#2}
}
\newcommand{\@subtitle}[1]{
    \@latex@warning@no@line{No \noexpand\subtitle given.}
}
\newcommand{\@othersubtitle}[1]{
    \@latex@warning@no@line{No \noexpand\othersubtitle given.}
}

% \finishdate command
\newcommand{\finishdate}[3]{
    \gdef\@finishyear{#1}
    \gdef\@finishmonth{#2}
    \gdef\@finishday{#3}
}
\newcommand{\@finishyear}[1]{
    \@latex@warning@no@line{No \noexpand\finishyear given.}
}
\newcommand{\@finishmonth}[1]{
    \@latex@warning@no@line{No \noexpand\finishmonth given.}
}
\newcommand{\@finishday}[1]{
    \@latex@warning@no@line{No \noexpand\finishday given.}
}

% \frontmatter command
\newcommand{\frontmatter}{
    \clearpage
    \pagenumbering{roman}
    \setcounter{page}{0}
}

% \mainmatter command
\newcommand{\mainmatter}{
    \clearpage
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

% Make the title
\renewcommand\maketitle{
    \thispagestyle{empty}
    \if@langenglish
        \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north west]
            at ($(current page.north west) + (1.16cm, -1.23cm)$)
            {\includegraphics[height=3.07cm]{tau-logo-fin-eng.eps}};
        \end{tikzpicture}
    \else
        \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north west]
            at ($(current page.north west) + (1.16cm, -1.23cm)$)
            {\includegraphics[height=3.07cm]{tau-logo-fin-eng.eps}};
        \end{tikzpicture}
    \fi
    \par\medskip
    \vspace{102pt}
    %% Sub-title -- Title -- Authors
    {\raggedleft\LARGE\color{taupurple}%
        \@subtitle\par}
    \vspace{82pt}
    {\raggedleft\bf\Huge\color{taupurple}%
        \MakeUppercase{\@title}\par}
        \vspace{20pt}
    {\raggedleft\LARGE\@author\par}
    \vfill
    {\raggedleft\large%
        % \@facultyname\\%
        % \@thesistype\\%
        %DTMDisplaydate%
        %    {\@finishyear}%
        %    {\@finishmonth}%
        %    {\@finishday}{-1}%
        \today
    \par}
    \vspace{42pt}
    \clearpage
    %% Authors -- Title -- Sub-title
    % {\raggedleft\LARGE\@author\par}
    % \vspace{82pt}
    % {\raggedleft\bf\huge\color{taupurple}%
    %     \MakeUppercase{\@title}\par}
    %     \vspace{20pt}
    % {\raggedleft\LARGE\color{taupurple}%
    %     \@subtitle\par}
    % \vfill
    % {\raggedleft\large%
    %     \@facultyname\\%
    %     \@thesistype\\%
    %     \DTMDisplaydate%
    %         {\@finishyear}%
    %         {\@finishmonth}%
    %         {\@finishday}{-1}%
    % \par}
    % \vspace{42pt}
    % \clearpage
}

%%%%%%%%%%%%%%%%%%%% EMPH %%%%%%%%%%%%%%%%%%%%
\let\emph\relax % there's no \RedeclareTextFontCommand
\DeclareTextFontCommand{\emph}{\bfseries\em}
\DeclareTextFontCommand{\emphLink}{\bfseries\em}

\newcommand*\define[1]{%
  %\textit{#1}%
  \index{#1@\protect\capitalisewords{#1}}%
   }
   
\usepackage{xparse}

\DeclareDocumentCommand\EMPH{ m g g}{%
    {\IfNoValueT{#3}%
    {\define{#1}}%
    \IfNoValueF {#3} {\define{#3}}%
    }%
    {\IfNoValueT{#2}%
    {\href{https://en.wikipedia.org/wiki/#1}{\emphLink{#1}}}%
    \IfNoValueF {#2} {\href{#2}{\emphLink{#1}}}%
    }%
}
%%%%% AI USE STATEMENT %%%%%
% Declaration of the use of artificial intelligence. Taken from the
% tauthesis class (fys-bsc-msc-thesis-templates) and adapted to project work.
% The statement is typeset by \aidisclaimerinclusioncmd (see main.tex), which
% inputs use-of-ai.tex (english) or tekoalyn-kaytto.tex (finnish).
\RequirePackage{tabularx}
\renewcommand\tabularxcolumn[1]{m{#1}} % vertically centred X columns

\if@langenglish
\newcommand{\@aidisclaimerfile}{use-of-ai.tex}
\newcommand{\@aidisclaimertitle}{Use~of~artificial~intelligence~in~this~work}
\newcommand{\@yestextcmd}{Yes}
\newcommand{\@notextcmd}{No}
\else
\newcommand{\@aidisclaimertitle}{Tekoälyn~käyttö~tässä~työssä}
\newcommand{\@aidisclaimerfile}{tekoalyn-kaytto.tex}
\newcommand{\@yestextcmd}{Kyllä}
\newcommand{\@notextcmd}{Ei}
\fi

\NewDocumentCommand\yesbox{}{\ensuremath{\text{\rlap{\ensuremath{\checkmark}}}\square}}
\NewDocumentCommand\nobox{}{\ensuremath{\text{\ensuremath{\square}}}}

\NewDocumentCommand\aitickbox{s}{
    \IfBooleanTF{#1}{
        \begin{quote}
            \indent\yesbox\hspace{1ex}\@yestextcmd
            \linebreak
            \indent\nobox\hspace{1ex}\@notextcmd
        \end{quote}
    }{
        \begin{quote}
            \indent\nobox\hspace{1ex}\@yestextcmd
            \linebreak
            \indent\yesbox\hspace{1ex}\@notextcmd
        \end{quote}
    }
}

\NewDocumentEnvironment{aidisclaimer}{s+b}{
    \chapter*{\@aidisclaimertitle}
    \if@langenglish
        Artificial intelligence (AI) has been used in generating this work:
    \else
        Työssäni on käytetty tekoälysovelluksia:
    \fi
    \IfBooleanTF{#1}{
        \aitickbox *
        #2
    }{
        \aitickbox
    }
}{
    \if@langenglish
        \section*{Acknowledgement of risks}
        I hereby acknowledge that, as an author of this work, I am fully
        responsible for the contents presented in this report. This includes
        the parts that were generated by an AI, in part or in their entirety. I
        therefore also acknowledge my responsibility in the case where use of
        AI has resulted in ethical guidelines being breached.
    \else
        \section*{Riskien tiedostaminen}
        Olen tietoinen siitä, että olen täysin vastuussa koko työni
        sisällöstä, mukaan lukien osat, joiden tuottamisessa on hyödynnetty
        tekoälyä, ja hyväksyn vastuun mahdollisista tästä seuranneista
        eettisten ohjeiden rikkomuksista.
    \fi
}

\NewDocumentCommand\aidisclaimerinclusioncmd{}{
    \input{\@aidisclaimerfile}
}

\makeatother

\endinput