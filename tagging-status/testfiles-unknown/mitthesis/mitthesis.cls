% MIT thesis class

% !TEX encoding = UTF-8 Unicode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  This file provides the mitthesis LaTeX class for formatting theses according to 
%%  MIT Libraries' requirements as of 2025.
%%
%%  This file's version and date:
	\def\versionno{1.19}
	\def\versiondate{2025/01/28\space}
%%
%%  Author: John H. Lienhard, V
%%          Department of Mechanical Engineering
%%          Massachusetts Institute of Technology
%%          Cambridge, MA 02139-4307 USA
%%
%%  This class is compatible with either pdfLaTeX or LuaLaTeX. 
%%
%%	Use an up-to-date LaTeX distribution: TeX Live 2023 or later is strongly recommended!
%%	All packages required by the class are in TeX Live and available from CTAN (https://ctan.org/). 
%%
%%
% =========================================================
%%
%% LICENSE:
%%
%% Copyright (c) 2025 John H. Lienhard
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
%% associated documentation files (the "Software"), to deal in the Software without restriction, 
%% including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
%% and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
%% subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in all copies or 
%% substantial portions of the Software.
%%
%% The software is provided "as is", without warranty of any kind, express or implied, including but 
%% not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. 
%% In no event shall the authors or copyright holders be liable for any claim, damages or other liability, 
%% whether in an action of contract, tort or otherwise, arising from, out of or in connection with the 
%% software or the use or other dealings in the software.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mitthesis}[\versiondate MIT Thesis Template (JHL)]

\LoadClass[12pt,openright]{report}% [twoside] option can be issued in the .tex file; point size must be set here.

\ExplSyntaxOn
  \str_const:Nn \ClassName {mitthesis}
\ExplSyntaxOff

%%%%%%%%%%%%%  Some compatibility for older latex distributions  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecommand\IfFormatAtLeastTF{\@ifl@t@r\fmtversion}% compare version to date; \If... added to latex 2020/10/01
\providecommand\IfPackageAtLeastTF{\@ifpackagelater}%    compare version to date; \If... added to latex 2020/10/01
\providecommand\IfPDFManagementActiveTF{\@secondoftwo}%  \If... added to latex 2021/07/23
\providecommand\IfPackageLoadedTF{\@ifpackageloaded}%    \If... added to latex 2021/11/15
\providecommand\ClassNoteNoLine[2]{\typeout{^^JClass Note #1: #2.^^J}}%  log & terminal note... added to latex 2021/11/15

\IfFormatAtLeastTF{2020/10/01}{%
	\ClassNoteNoLine{\ClassName}{Your LaTeX format is dated \fmtversion. LaTeX distributions from 2022/11/01 or later are strongly recommended for best results}
	}{%
	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion.  Formats dated 2022/11/01 or later are strongly recommended for this class. Older formats may generate errors}{Please UPDATE your LaTeX distribution to obtain best results. TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  You can try to click past the errors for now...}%
}

% check whether pdfmanagement (\DocumentMetadata) has been loaded (if not, fall back to hyperxmp and bookmark packages after loading hyperref)
\newif\ifmit@pdfmanagement
\IfPDFManagementActiveTF{
	\mit@pdfmanagementtrue 
}{
	\mit@pdfmanagementfalse
	\ClassWarningNoLine{\ClassName}{pdfmanagement is not active. Will load hyperxmp and bookmark packages instead}
}

% Enable pre-2020/10 formats to access essential macros later moved into LaTeX kernel
\ifdefined\NewDocumentCommand\else
  \RequirePackage{xparse}
\fi

% Allow pre 2021/11/15 formats to see the graphicx alt key without causing an error
\IfFormatAtLeastTF{2021/11/15}{
	\relax
}{ 
	\AtBeginDocument{
		\IfPackageLoadedTF{graphicx}{\define@key{Gin}{alt}{}}{\relax}
	}
}
% Most compatibility commands will be dropped as time goes by ...

%%%%%%%%%%%%%% Options for the class %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\IfFormatAtLeastTF{2022/11/01}{%
    \DeclareKeys{
    	fontset  .store  = \mit@fontset ,
    	fontset  .usage  = load ,
		lineno   .if     = mit@lineno ,
		lineno 	 .usage	 = load ,
		mydesign .if	 = mit@mydesign ,
		mydesign .usage	 = load ,
    } 
    \SetKeys[\ClassName]{fontset=defaultfonts}%
	\DeclareUnknownKeyHandler[\ClassName]{\relax}% suppress warning about unused keys
	\ProcessKeyOptions
}{% And more compatibility code for distributions pre-2022/11     
    \RequirePackage{kvoptions}
    \SetupKeyvalOptions{
      family=\ClassName,
      prefix=mit@,
      setkeys=\kvsetkeys,
    }
    % set key [fontset] for font selection
    \DeclareStringOption[defaultfonts]{fontset}[]
    %
    % set key [lineno] to load package lineno
    \DeclareBoolOption{lineno}
    %
    % set key [mydesign] to input file mydesign.tex
    \DeclareBoolOption{mydesign}
    %
    \ProcessKeyvalOptions{\ClassName}
    %
    %% Turn off these keys now that we're done with them
    \NewDocumentCommand\mit@DisableOption{m}{%
      \DisableKeyvalOption[%
        action=ignore,%
        class=\ClassName%
      ]{#1}{\ClassName}%
    }
    \NewDocumentCommand\mit@DisableKeys{>{\SplitList{;}}m}{\ProcessList{#1}{\mit@DisableOption}}
    %
    \mit@DisableKeys{fontset;lineno;mydesign}%
    %
    %% Suppress warnings about unused global options
    \DeclareOption*{}  
    \ProcessOptions \relax
}

%%%%%%%%%%%%%  Line numbering (class option)  %%%%%%%%%%%%%%%%%%%%%%%%%

\ifmit@lineno
    \RequirePackage[mathlines]{lineno} 
    \AtBeginDocument{\linenumbers}
\fi

%%% Enable dropping lineno option without trashing .aux file
\providecommand{\@LN@col}[1]{\relax}
\providecommand{\@LN}[2]{\relax}


%%%%%%%%%%%%%  Patch table of contents, list of figures, and list of tables  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We'd like these sections to have pdf bookmarks and to have the two lists appear in the table of contents and have
% pdf bookmarks.  This is not automatic for \chapter*, which is the format of toc, lof, and lot.

\RequirePackage{etoolbox}% provides \patchcmd

\patchcmd{\tableofcontents}{\contentsname}{\pdfbookmark[0]{Table of Contents}{toc}\contentsname}{}{} % placement matters.

%% Code to accommodate latex tagging. Rework once LaTeX3 team have finalized tagging structures.
%% No guarantee that this hack is hierarchically correct.
%% Current latex-lab places tags around \@schapter, which is harder to deal with here.

\ProvideDocumentCommand\MakeLinkTarget{sO{}m}{}

\patchcmd{\listoffigures}{\chapter*{\listfigurename}}{\chapter*{\phantomsection\listfigurename}\MakeLinkTarget*{listoffigures}\addcontentsline{toc}{frontmatter}{\listfigurename}}{}{}
\patchcmd{\listoftables}{\chapter*{\listtablename}}{\chapter*{\phantomsection\listtablename}\MakeLinkTarget*{listoftables}\addcontentsline{toc}{frontmatter}{\listtablename}}{}{}

\NewCommandCopy\l@frontmatter\l@chapter
\NewCommandCopy\l@backmatter\l@chapter
\providecommand*{\toclevel@frontmatter}{0}% prevent warning, see hyperref manual Sec. 13.3
\providecommand*{\toclevel@backmatter}{0}

%% if you want different formatting for front/back matter, change here (cf. report.cls). 
\patchcmd{\l@frontmatter}{\bfseries}{\itshape}{}{}
\patchcmd{\l@frontmatter}{\nobreak\hfil}{\upshape\nobreak\hfil}{}{}
\patchcmd{\l@frontmatter}{1.0em}{3pt}{}{} 
\patchcmd{\l@backmatter}{\bfseries}{\itshape}{}{}
\patchcmd{\l@backmatter}{\nobreak\hfil}{\upshape\nobreak\hfil}{}{}


%%%%%%%%%%%%%  Geometry, mathtools, graphics, design, fonts, hyperrefs, bookmarks, footnotes %%%%%%%%%%%%%%%%%%%

\RequirePackage[letterpaper,top=1in,bottom=1in,left=1in,right=1in,marginparwidth=50pt,headsep=12pt,footskip=0.5in,heightrounded]{geometry} 
% 44\baselineskip = \textheight - \topskip = 650.0pt - 12pt with rounded height

\RequirePackage{mathtools}% loads and extends amsmath; must load before hyperref and unicode-math

% To free \eqref from the normal font (i.e., for use in section headings)
\renewcommand{\eqref}[1]{\textup{\hbox{\m@th{(\ignorespaces\ref{#1}\unskip\@@italiccorr)}}}}
%
% amsmath def:  \newcommand{\eqref}[1]{\textup{\tagform@{\ref{#1}}}}
%				\def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip\@@italiccorr)}}
%				\def\maketag@@@#1{\hbox{\m@th\normalfont#1}}

% To streamline switching from lualatex to pdftex when using sample chapter 1, which puts \psi (as \mitpsi) in a toc entry
\ifpdftex\providecommand\mitpsi{\psi}\fi


\RequirePackage{graphicx}

%%%%%%%%%%%%  Design options %%%%%%%%%%%%%%%%%%%%%%%

% the packages in mydesign should come before babel (which may be loaded by fontset) and before hyperref
\ifmit@mydesign
	\IfFileExists{mydesign.tex}{\input{mydesign.tex}}{%
	\ClassError{\ClassName}{Missing file mydesign.tex. This file is necessary when using the class option [mydesign] }{%
			You have called the class option mydesign, but the file mydesign.tex is not found.  You can download a copy of that file from
			https://ctan.org/tex-archive/macros/latex/contrib/mitthesis/MIT-thesis-template.}%  
	}%
\else
	\RequirePackage[dvipsnames,svgnames,x11names]{xcolor}

	\RequirePackage{caption,subcaption}

	% Patch headings to automatically use bold math. Removed titlesec 2025/01/27
    % NOT every font includes a bold math version, so you may need to use other math macros in the headings to get bold math <== 
    % Predefined fontsets for which bold math exists are: CMR, Fira, Libertinus, Lucida, Newtx
	\patchcmd{\section}{\normalfont}{\mathversion{bold}\normalfont}{}{}
	\patchcmd{\subsection}{\normalfont}{\mathversion{bold}\normalfont}{}{}
	\patchcmd{\subsubsection}{\normalfont}{\mathversion{bold}\normalfont}{}{}
	\patchcmd{\paragraph}{\normalfont}{\mathversion{bold}\normalfont}{}{}
	\patchcmd{\subparagraph}{\normalfont}{\mathversion{bold}\normalfont}{}{}

	\ExplSyntaxOn 
	% temporary patch for lof/lot issue, will drop eventually, 2025/01/28
	\cs_if_exist:NT \tag_struct_end:n {
	  \AtBeginDocument{ 
			\renewcommand*\caption@anchor[1]{%
	        \ifmeasuring@ \else
           	\caption@raisedlink{\MakeLinkTarget*{#1}}%
	        \fi}%  
	  }
	 % temporary patch to fix tagging bug with large delimiters in some fonts, drop when resolved, 2025/01/28
	 \AtBeginDocument{ 
        \cs_set:Npn \bBigg@ #1 #2 {
          {
            \ensuremath {
              \Uvextensible height~#1~ \dimexpr0.5\big@size\relax ~ depth ~#1~  \dimexpr0.5\big@size\relax~ axis~exact~#2
            }
          }
      	 }
       }
      }
	\ExplSyntaxOff

	\AtBeginDocument{
		\hypersetup{
		linkcolor=Blue3,% color names from xcolor package
		citecolor=Blue3,
		urlcolor=violet,
		filecolor=red, 
		}
		\ifmit@lineno
			\renewcommand{\linenumberfont}{\sffamily\mdseries\tiny\color{violet}}% add \mdseries 2023/10/11
		\fi
	}	  	
\fi

%%%%%%%%%%%%  Font loading  %%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{iftex}[2019/11/07]% provides \ifpdftex, etc.

\ClassNoteNoLine{\ClassName}{Fontset key is \mit@fontset}
\IfFileExists{fontsets/\ClassName-\mit@fontset.tex}{% 2023/07/03
	\input{fontsets/\ClassName-\mit@fontset.tex}
}{%
	\ClassWarning{\ClassName}{Fontset file \ClassName-\mit@fontset.tex or subdirectory fontsets not found, will look for \mit@fontset.tex in your working directory}
	\IfFileExists{\mit@fontset.tex}{% 2023/08/30
		\input{\mit@fontset.tex}
		}{
    	\ClassWarning{\ClassName}{Fontset file \mit@fontset.tex not found, using default fonts. You may need to place the fontset file into your working directory}
    	\ifpdftex
        	\ClassNoteNoLine{\ClassName}{Loading Computer Modern text and math fonts (default for pdftex)}
        	\RequirePackage[T1]{fontenc}
        	\RequirePackage{bm}
        \else
        	\ClassNoteNoLine{\ClassName}{Loading Latin Modern text and math fonts (default for unicode engines)}
            \RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket}]{unicode-math}
            % suppress tiresome warnings about lack of integration between mathtools and unicode-math.
            % Unicode-math loads fontspec package, but default fonts are not selected by fontspec in this case.
        \fi
       }
}

%%%%%%%%%%%%  Hyperref %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[psdextra]{hyperref}
% authors should use hypersetup to set details, in root .tex file

\urlstyle{same} 		% this changes font for \url to the current text font
\RequirePackage{doi} 	% create macro for hyperlinking doi numbers

%% In case \DocumentMetadata was not loaded
\providecommand\hrefurl[2]{\href{#1}{#2}}

% pdfmanagement loads bookmarks package internally
\ifmit@pdfmanagement\else
    \RequirePackage{hyperxmp}
    \RequirePackage{bookmark}
\fi

% the user can alter these choices in the preamble, or by 
% using \AtBeginDocument{ \hypersetup{..} } in mydesign.tex 
\hypersetup{
    colorlinks=true,
 	pdfborder={0 0 0},
	bookmarksnumbered=true,
	bookmarksopen=true,
	bookmarksopenlevel=1,
	pdfpagelayout=SinglePage,
	pdfdisplaydoctitle=true,
	pdfstartview=Fit,
	pdfnewwindow=true,
%
	pdfcontactaddress={Massachusetts Institute of Technology, 77 Massachusetts Avenue},
    pdfcontactcity={Cambridge, MA},
    pdfcontactpostcode={02139-4307},
    pdfcontactcountry={USA},
    pdfcontacturl={https://dspace.mit.edu/handle/1721.1/7582},% DSPACE@MIT theses page
}
 		
%%%%%%%%%%%%  PDF bookmark strings  %%%%%%%%%%%%%%%%

%%%     By early 2024, \pdfstring removes all robust commands from bookmarks, so that such commands 
%%%     don't cause errors; the following pdfstringdisables serve to suppress warnings.

%% \bm may be useful in headings, but let's disable in the associated bookmarks
\pdfstringdefDisableCommands{%
    \def\bm#1#{\relax}%
}
%% Let's disable \( and \) in pdf bookmarks
\pdfstringdefDisableCommands{%
    \def\({\relax}%
    \def\){\relax}%
}
%%% Let's also make sure \NoCaseChange in section headings won't break pdf bookmarks
\pdfstringdefDisableCommands{%
    \let\NoCaseChange\relax%
}
%%% Let's just remove citations from pdf bookmarks
\pdfstringdefDisableCommands{%
    \def\cite{\@gobble}%
}
%%% Let's fix \eqref in pdf bookmarks
\pdfstringdefDisableCommands{%
    \def\eqref#1{(\ref{#1})}%
}
%%% Let's make sure footnotes in section headings don't break pdf bookmarks. (Note: \footnote, as redefined below, is protected)
% \patchcmd{\section}{\sectionmark}{\let\footnote\@gobble\sectionmark}{}{}% <== not needed unless you implement running headers
\pdfstringdefDisableCommands{%
  \def\footnote#1{}%
}

%%% Here's a more cumbersome removal of the warning for $ (math shift) in pdfbookmarks.
%%% Not implementing this by default, since novice authors may benefit from the warning. :-)
%%% 	see: https://tex.stackexchange.com/a/620360/119566
%\let\oldHyPsd@CatcodeWarning\HyPsd@CatcodeWarning
%\renewcommand{\HyPsd@CatcodeWarning}[1]{% 
%  \ifnum\pdfstrcmp{#1}{math shift}=0    % If 'math shift' is present, do nothing
%  \else                                 
%    \oldHyPsd@CatcodeWarning{#1}%       % else, keep usual warning.
%  \fi
%}

\ExplSyntaxOn
%\debug_on:n {all}

\prop_gput:Nnn \g_msg_module_type_prop { \ClassName } { Class }

%%%%%%%%%%  Commas between successive footnotes %%%

\cs_new:Npn   \__mitthesis_NoteComma:n { \peek_meaning:NT \footnote {\textsuperscript{\mdseries,}} }
\cs_new_eq:NN \__savefootnote \footnote
\cs_gset_protected:Npn \footnote #1    { \__savefootnote{#1}\__mitthesis_NoteComma:n } 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  MACROS FOR HANDLING TITLE AND ABSTRACT PAGES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{
	\providecommand{\textls}[2][]{#2}% in case microtype is not loaded
}

%%%%%%%%%%  Degree Date Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\tl_new:N \g__dd_month_tl	
\tl_new:N \g__dd_year_tl
%\cs_generate_variant:Nn \str_casefold:n {e} % not def'd until 2022/10/16, omit for backward compatibility
\cs_generate_variant:Nn \tl_gremove_all:Nn {No}
\cs_new_protected:Nn \__dd_setdates:nn {
	\tl_gset:Nn \g__dd_month_tl {#1}
	\tl_gset:Nn \g__dd_year_tl  {#2}
	\tl_gremove_all:No \g__dd_month_tl { \space }
	\tl_gremove_all:No \g__dd_year_tl { \space }
 	\str_case_e:nnF 
%		{ \str_casefold:e { \tl_to_str:N  \g__dd_month_tl } } % not def'd until 2022/10/16
		{ \str_lowercase:f { \tl_to_str:N  \g__dd_month_tl } }
	 	{ {february}{} {may}{} {june}{} {september}{}}
		{ \msg_error:nnn { \ClassName } { wrong_month } {#1} } 
}
\msg_new:nnnn { \ClassName } { wrong_month } {The\ degree\ month\ must\ be\ one\ of\ February,\ May,\ June,\ or\ September.} {You\ cannot\ use\ #1\ as\ the\ degree\ month.}

\NewDocumentCommand\DegreeDate{mm}{%   {month}{year}	
	\__dd_setdates:nn {#1}{#2}
	\cs_new:Npn \DegreeMonth { \text_titlecase_first:n { \text_lowercase:n \g__dd_month_tl } }
	\cs_new:Npn \DegreeYear  { \text_expand:n { \g__dd_year_tl  } }% edited 2024/06/24
}
\msg_new:nnnn { \ClassName } { no_degree_date } {Missing\ degree\ date!}{
			You\ MUST\ issue\ the\ \DegreeDate{month}{year}\ command\ between\ \string\begin{document}\ and\ \string\maketitle.}
		
\NewDocumentCommand\ThesisDate{m}{
	\tl_if_exist:NTF \g_dd_thesisdate_tl { \g_dd_thesisdate_tl } { \__dd_thesisdate:n {#1} }% will use only value given first
}
\cs_new_protected:Nn \__dd_thesisdate:n {
	\tl_new:N  \g_dd_thesisdate_tl
	\tl_gset:Nx \g_dd_thesisdate_tl { \tl_trim_spaces:n {#1} }
}

% If for some reason you don't want a warning when you supply the wrong month
\NewDocumentCommand\SuppressMonthError{}
  {
  	\msg_redirect_name:nnn { \ClassName } { wrong_month } { none }
  }

%%%%%%%%%%  End Degree Date Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Author Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\seq_new:N \g_author_name_seq
\seq_new:N \g_author_department_seq
\seq_new:N \g_author_prevdegree_seq
\seq_new:N \g_author_secondprevdegree_seq
\seq_new:N \g_author_thirdprevdegree_seq
\seq_new:N \g_author_fourthprevdegree_seq
\int_gzero_new:N \g_author_authorcnt_int

\NewDocumentCommand\Author{mm O{}O{}O{}O{} }
 {
 	\tl_if_blank:nTF{#1}{
		\msg_error:nn { \ClassName } { blank_author }
		}{
		  \__author_data_add:nnnnnn { #1 } { #2 } { #3 } { #4 } { #5 } { #6 }
		}
	\tl_if_blank:nT{#2}{\msg_error:nn {\ClassName} {blank_author_dep}}
 }
\cs_new_protected:Nn \__author_data_add:nnnnnn
 {
	\int_gincr:N \g_author_authorcnt_int
	\seq_gput_right:cx  { g_author_name_seq }        { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:cx  { g_author_department_seq }  { \tl_trim_spaces:n {#2} }
	\seq_gput_right:cx  { g_author_prevdegree_seq }  { \tl_trim_spaces:n {#3} }
	\seq_gput_right:cx  { g_author_secondprevdegree_seq } { \tl_trim_spaces:n {#4} }
	\seq_gput_right:cx  { g_author_thirdprevdegree_seq }  { \tl_trim_spaces:n {#5} }
	\seq_gput_right:cx  { g_author_fourthprevdegree_seq } { \tl_trim_spaces:n {#6} }
 }
\msg_new:nnnn { \ClassName } { blank_author } {Missing\ author\ name,\ check\ for\ blank\ in\ \Author\ command.}{%
			You\ MUST\ provide\ an\ author\ name\ using\ the\ \Author{name}{department}\ command.}
\msg_new:nnnn { \ClassName } { blank_author_dep } {Missing\ author\ department,\ check\ for\ blank\ in\ \Author\ command.}{%
			You\ MUST\ provide\ the\ author's\ department\ using\ the\ \Author{name}{department}\ command.}

\NewExpandableDocumentCommand\CopyrightAuthor{}{
	\tl_if_exist:NTF \g__author_ca_tl
		{ \g__author_ca_tl }
		{ \__author_copyrightauthor: \g__author_ca_tl }
}

\cs_if_exist:NTF \cs_gset:Npe % 2024/10/05, for backward compatibility
	{}
	{ \cs_generate_variant:Nn \cs_gset:Npn {Npe} }
\cs_new_protected:Nn \__author_copyrightauthor: {
	\tl_new:N       \g__author_ca_tl
	\int_zero_new:N \l__author_autcrcnt_int
	\int_incr:N     \l__author_autcrcnt_int
    \tl_gset:Nx     \g__author_ca_tl  { \seq_item:cn { g_author_name_seq } { \l__author_autcrcnt_int } }
	\int_incr:N     \l__author_autcrcnt_int
	\int_while_do:nNnn { \l__author_autcrcnt_int } < { \g_author_authorcnt_int }
		{
			\tl_gput_right:Nx \g__author_ca_tl {,~\seq_item:cn { g_author_name_seq } { \l__author_autcrcnt_int } }
			\int_incr:N \l__author_autcrcnt_int   
		}
	\int_compare:nNnT { \l__author_autcrcnt_int } = { \g_author_authorcnt_int } {
  	    \tl_gput_right:Nx \g__author_ca_tl {~and~\seq_item:cn { g_author_name_seq } { \l__author_autcrcnt_int } }
	}
	\tl_set:Nn \l_tmpa_tl {\tl_item:Nn \g__author_ca_tl {-1} }% get last token
 	\str_case_e:nnT 
		{ \l_tmpa_tl  }
	 	{ {.}{} }
		{ \__copyright_remove_period:N { \g__author_ca_tl } }% remove last token if it is a period 
	\__author_pdfcopyrightauthor:
	\cs_gset:Npe \@author { \tl_use:N \g__author_ca_tl }% 2024/08/06
}
\cs_new:Nn \__copyright_remove_period:N
	{
		\tl_gset:Nx #1 { \tl_range:Nnn #1 { 1 } { \tl_count:N #1 - 1 } }
	}
\cs_new_protected:Nn \__author_pdfcopyrightauthor: {
	\tl_new:N       \g__author_pdfca_tl
	\int_set:Nn     \l_tmpa_int {1}
    \tl_gset:Nx     \g__author_pdfca_tl  { { \seq_item:cn { g_author_name_seq } { \l_tmpa_int } } }
	\int_until_do:nNnn { \l_tmpa_int } = { \g_author_authorcnt_int }
		{
			\int_incr:N \l_tmpa_int   
			\tl_gput_right:Nx \g__author_pdfca_tl {;\ { \seq_item:cn { g_author_name_seq } { \l_tmpa_int } } }
			% changed comma to semicolon for consistency with Dublin Core metadata format, 2024/08/30
		}
}

\tl_new:N   \g__author_namesize_tl
\tl_gset:Nn \g__author_namesize_tl { \large }
\cs_new:Nn \__author_block: {
	\int_zero_new:N \l__author_authorno_int
	\int_incr:N     \l__author_authorno_int
	\int_compare:nNnTF { \g_author_authorcnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_author }
	}	
	{by\par
	\int_until_do:nNnn { \l__author_authorno_int } = { \g_author_authorcnt_int } {
		{ \g__author_namesize_tl \seq_item:cn { g_author_name_seq } { \l__author_authorno_int } } \par
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_prevdegree_seq } { \l__author_authorno_int} }
		\tl_if_empty:NF \l_tmpa_tl { \normalsize \l_tmpa_tl }% no linebreak or par for empty items
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_secondprevdegree_seq } { \l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl  }
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_thirdprevdegree_seq } { \l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl  }
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_fourthprevdegree_seq } { \l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl  }
		\par and\par
		\int_incr:N \l__author_authorno_int
	}
		{ \g__author_namesize_tl \seq_item:cn { g_author_name_seq } { \l__author_authorno_int } } \par
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_prevdegree_seq } { \l__author_authorno_int} }
		\tl_if_empty:NF \l_tmpa_tl { \normalsize \l_tmpa_tl }% no linebreak or par for empty items
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_secondprevdegree_seq } { \l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl }
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_thirdprevdegree_seq } { \l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl  }
		\tl_set:Nx \l_tmpa_tl { \seq_item:cn { g_author_fourthprevdegree_seq } {\l__author_authorno_int} } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl  }
    	\par 
    }
}
\msg_new:nnnn { \ClassName } { no_author }
		{ Missing\ author!\ You\ must\ issue\ the\ \Author{name}{department}\ command. }{
		You\ MUST\ issue\ the\ \Author{name}{department}\ command\ after\ \string\begin{document}\ and\ before\ \string\maketitle. }
\NewDocumentCommand\AuthorNameSize{m}{
		\tl_gset:Nn \g__author_namesize_tl {#1}
}


\cs_new:Nn \__author_abstractblock: {
	\int_zero_new:N \l__author_authorno_int
	\int_incr:N     \l__author_authorno_int
	\int_compare:nNnTF { \g_author_authorcnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_author }
		}	
		{by\par
		\int_until_do:nNnn { \l__author_authorno_int } = { \g_author_authorcnt_int } {
			\seq_item:cn { g_author_name_seq } { \l__author_authorno_int }
			\par and\par
			\int_incr:N \l__author_authorno_int
		}%
		\seq_item:cn { g_author_name_seq } { \l__author_authorno_int } 
    }%
}

%%%%%%%%%%  End Author Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Supervisor Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\seq_new:N \g_supervisor_name_seq
\seq_new:N \g_supervisor_title_seq
\int_gzero_new:N \g_supervisor_supervisorcnt_int

\NewDocumentCommand\Supervisor{mm}{
	\tl_if_blank:nTF{#1}{
		\msg_error:nn { \ClassName } { blank_supervisor }
		}{
		\__supervisor_data_add:nn {#1} {#2}
	}
	\tl_if_blank:nT{#2}{\msg_error:nn { \ClassName } { blank_supervisor_title } }
}
\msg_new:nnnn { \ClassName } { blank_supervisor }
		{ Missing\ supervisor\ name, check\ for\ blank\ in\ \Supervisor{name}{title}\ command.}{
			You\ MUST\ provide\ the\ supervisor's\ name\ using\ the\ \Supervisor{name}{title}\ command.}
\msg_new:nnnn { \ClassName } { blank_supervisor_title }
		{ Missing\ supervisor\ title, check\ for\ blank\ in\ \Supervisor{name}{title}\ command. }{
			You\ MUST\ provide\ the\ supervisor's\ title\ using\ the\ \Supervisor{name}{title}\ command.}

\cs_new_protected:Nn \__supervisor_data_add:nn
 {
	\int_gincr:N \g_supervisor_supervisorcnt_int
	\seq_gput_right:cx  { g_supervisor_name_seq }  { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:cx  { g_supervisor_title_seq } { \tl_trim_spaces:n {#2} }
 }

\tl_new:N   \g_titlepage_supervisor_designation_tl
\tl_new:N   \g_abstract_supervisor_designation_tl
\tl_gset:Nn \g_titlepage_supervisor_designation_tl {Thesis~Supervisor} 
\tl_gset:Nn \g_abstract_supervisor_designation_tl  {Thesis~supervisor}% style from MIT Libraries

% If for some reason you need to change "Thesis Supervisor" to a different string (say, "Doctoral Advisor").
% This construction removes leading and trailing spaces and lowercases the string.
\NewDocumentCommand\SupervisorDesignation{ m } { 
		\tl_gset:Nn \g_titlepage_supervisor_designation_tl 
				{ \cs_if_exist:NTF \text_titlecase_all:n % not def'd until 2023/07/08
					{ \text_titlecase_all:n { \text_lowercase:n { \tl_trim_spaces:n {#1} } } }
					{ \tl_trim_spaces:n {#1} }
				}
		\tl_gset:Nn \g_abstract_supervisor_designation_tl  
				{ \text_titlecase_first:n { \text_lowercase:n { \tl_trim_spaces:n {#1} } } }
		}
		
\cs_new:Nn \__supervisor_abstractblock: {
	\int_zero_new:N \l__supervisor_supervisorno_int
	\int_incr:N     \l__supervisor_supervisorno_int
	\setlength{\parindent}{0pt}
	\par\bigskip
	\int_compare:nNnTF { \g_supervisor_supervisorcnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_supervisor }
		}	
		{\int_until_do:nNnn { \l__supervisor_supervisorno_int } = { \g_supervisor_supervisorcnt_int } {
			\g_abstract_supervisor_designation_tl  :\space 
			\seq_item:cn { g_supervisor_name_seq } { \l__supervisor_supervisorno_int }\par
			Title:\space              \seq_item:cn { g_supervisor_title_seq } { \l__supervisor_supervisorno_int }\par\medskip
			\int_incr:N \l__supervisor_supervisorno_int
		}
			\g_abstract_supervisor_designation_tl  :\space  
			\seq_item:cn { g_supervisor_name_seq } { \l__supervisor_supervisorno_int }\newline % 2025/1/15: drop \par
			Title:\space  \seq_item:cn { g_supervisor_title_seq } { \l__supervisor_supervisorno_int }\ignorespaces
    }
}
\msg_new:nnnn { \ClassName } { no_supervisor }
		{ Missing\ supervisor!\ You\ must\ issue\ the\ \Supervisor{name}{title}\ command. }{
		You\ MUST\ issue\ the\ \Supervisor{name}{title}\ command\ after\ \string\begin{document}\ and\ before\ \string\maketitle. }


%%%%%%%%%%  End Supervisor Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Acceptor Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\seq_new:N \g_acceptor_name_seq
\seq_new:N \g_acceptor_department_seq
\seq_new:N \g_acceptor_title_seq
\int_gzero_new:N \g_acceptor_acceptorcnt_int

\bool_new:N \g__acceptor_title_tf_bool
\bool_gset_false:N \g__acceptor_title_tf_bool

\NewDocumentCommand\Acceptor{mmm}{
	\tl_if_blank:nTF{#1}{
		\msg_error:nn { \ClassName } { blank_acceptor }
		}{
		\__acceptor_data_add:nnn {#1} {#2} {#3}
	}
	\tl_if_blank:nT{#2}{\msg_error:nn {\ClassName} {blank_acceptor_dep}}
	\tl_if_blank:nTF{#3}{
		\bool_gset_true:N \g__acceptor_title_tf_bool
		\msg_warning:nn { \ClassName } { blank_acceptor_title }}{}
}
\msg_new:nnnn { \ClassName } { blank_acceptor }
		{ Missing\ acceptor\ name, check\ for\ blank\ in\ \Acceptor{name}{department}{title}\ command.}{
			You\ MUST\ provide\ the\ acceptor's\ name\ using\ the\ \Acceptor{name}{department}{title}\ command.}
\msg_new:nnnn { \ClassName } { blank_acceptor_dep }
		{ Missing\ acceptor\ department,\ check\ for\ blank\ in\ \Acceptor{name}{department}{title}\ command. }{
			You\ MUST\ provide\ the\ acceptor's\ department\ using\ the\ \Acceptor{name}{department}{title}\ command.}
\msg_new:nnn { \ClassName } { blank_acceptor_title }
		{ Missing\ acceptor\ title\ (blank\ in\ \Acceptor{name}{department}{title}\ command).\space Perhaps\ you\ are\ trying\ to\ save\ vertical\ space?\space  
			You\ can\ put\ the\ acceptor\ title\ into\ department\ field\ instead.\space For\ consistency,\ I\ will\ omit\ titles\ of\ ALL\ acceptors.}

\cs_new_protected:Nn \__acceptor_data_add:nnn
 {
	\int_gincr:N \g_acceptor_acceptorcnt_int
	\seq_gput_right:cx  { g_acceptor_name_seq }       { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:cx  { g_acceptor_department_seq } { \tl_trim_spaces:n {#2} }
	\seq_gput_right:cx  { g_acceptor_title_seq }      { \tl_trim_spaces:n {#3} }
 }

%%%%%%%%%%  End Acceptor Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Degree Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% extensive edits 2024/06/25

\seq_new:N \g_degree_name_seq
\seq_new:N \g_degree_department_seq
\int_gzero_new:N \g_degree_degreecnt_int
\int_gzero_new:N \g_degree_deptcnt_int

\NewDocumentCommand\Degree{mm}
 {
    \int_compare:nNnTF { \g_degree_deptcnt_int } = {0} {
    	\tl_if_blank:nTF {#1} {
    		\msg_error:nn { \ClassName } { no_degree_name }
    		}{
    		  \__degree_data_add:nn { #1 } { #2 } 
			  \int_gincr:N \g_degree_degreecnt_int
    		}
    	\tl_if_blank:nT {#2} {
    		\msg_error:nn { \ClassName } { no_degree_dep }
    		}{
			\int_gincr:N \g_degree_deptcnt_int
			}
    }{
    	\tl_if_blank:nTF {#1} {
    		\msg_warning:nn { \ClassName } { blank_degree }
    		}{
			\__degree_data_add:nn { #1 } { #2 }
			\int_gincr:N \g_degree_degreecnt_int
			}
    	\tl_if_blank:nTF {#2} {
    		\msg_warning:nn { \ClassName } { blank_degree_dep }
    		}{
			\int_gincr:N \g_degree_deptcnt_int 
			\tl_if_blank:nT {#1} {  % in case department is blank
				\__degree_data_add:nn { #1 } { #2 }
				}
    		}
    }
 }

\cs_new_protected:Nn \__degree_data_add:nn
 {
	\seq_gput_right:cx  { g_degree_name_seq }        { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:cx  { g_degree_department_seq }  { \tl_trim_spaces:n {#2} }
 }
\msg_new:nnnn { \ClassName } { no_degree_name } {Missing\ degree\ name,\ check\ for\ blank\ in\ \Degree\ command.} 
			{You\ MUST\ provide\ at\ least\ one\ degree\ name\ using\ the\ \Degree{name}{department}\ command.}
\msg_new:nnnn { \ClassName } { no_degree_dep } {Missing\ degree\ department\ for\ Degree\ command.}
			{You\ MUST\ provide\ at\ least\ one\ department\ name\ using\ the\ \Degree{name}{department}\ command.}
\msg_new:nnnn { \ClassName } { blank_degree } {Missing\ degree\ name\ in\ second\ Degree\ command.\ Will\ treat\ as\ two\ departments\ issuing\ one\ degree.}{}
\msg_new:nnnn { \ClassName } { blank_degree_dep } {Missing\ degree\ department\ in\ second\ \ Degree\ command.\ Will\ treat\ as\ one\ department\ issuing\ two\ degrees.}{}
		
\int_zero_new:N \l__degree_degreeno_int
\int_zero_new:N \l__degree_departmentno_int

\cs_new:Nn \__degree_block: {
	\int_compare:nNnTF { \g_degree_degreecnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_degree }
	}	
	\int_zero_new:N \l__degree_degreeno_int
	\int_incr:N     \l__degree_degreeno_int
	\int_zero_new:N \l__degree_departmentno_int
	\int_incr:N     \l__degree_departmentno_int
	\cs_new:Nx \__degree_prevdept: {\seq_item:cn { g_degree_department_seq } { \l__degree_departmentno_int } }
	\cs_new:Nn \__degree_currdept: {}
%	\mbox {Submitted\ to\ the\ } \mbox {\__degree_prevdept:} 
	{Submitted\ to\ the\ \__degree_prevdept:} 
	\int_until_do:nNnn { \l__degree_departmentno_int } = { \g_degree_deptcnt_int } {
		\int_incr:N      \l__degree_departmentno_int
		\cs_set:Nx \__degree_currdept: {\seq_item:cn { g_degree_department_seq } { \l__degree_departmentno_int } }
		\mbox {\ and}\linebreak
		\mbox {the\ \__degree_currdept: }
	}
    \linebreak \mbox {in\ partial\ fulfillment\ of\ the\ requirements\ for\ the\ 
		\int_compare:nNnTF { \g_degree_degreecnt_int } > {1} {degrees} {degree}
	\ of}
	\par
	\int_until_do:nNnn { \l__degree_degreeno_int } = { \g_degree_degreecnt_int } {
    	\textls[60]{\text_uppercase:n {\seq_item:cn { g_degree_name_seq } { \l__degree_degreeno_int }}}\par and\par
		\int_incr:N     \l__degree_degreeno_int
		}
    \textls[60]{\text_uppercase:n {\seq_item:cn { g_degree_name_seq } { \l__degree_degreeno_int }}}\par
}
\msg_new:nnnn { \ClassName } { no_degree }
		{ Missing\ degree!\ You\ must\ issue\ the\ \Degree{name}{department}\ command. }{
		You\ MUST\ issue\ the\ \Degree{name}{department}\ command\ after\ \string\begin{document}\ and\ before\ \string\maketitle.\  You\ do\ want\ the\ degree,\ don't\ you?}


\cs_new:Nn \__degree_abstractblock: {
	\int_set:Nn  \l__degree_degreeno_int {1}
	\int_set:Nn  \l__degree_departmentno_int {1}
	\cs_set:Nx \__degree_prevdept: {\seq_item:cn { g_degree_department_seq } { \l__degree_departmentno_int } }
	\cs_set:Nn \__degree_currdept: {}
%	\mbox {Submitted\ to\ the\ }\mbox {\__degree_prevdept:} % changed 2024/4/20
	{Submitted\ to\ the\ \__degree_prevdept:}
	\int_until_do:nNnn { \l__degree_departmentno_int } = { \g_degree_deptcnt_int } {
		\int_incr:N      \l__degree_departmentno_int
		\cs_set:Nx \__degree_currdept: {\seq_item:cn { g_degree_department_seq } { \l__degree_departmentno_int } }
		\mbox {\ and}\linebreak
		\mbox {the\ \__degree_currdept: }
	}
    \linebreak \mbox{on\ \g_dd_thesisdate_tl\ in\ partial\ fulfillment\ of\ the\ requirements\ for\ the\ 
		\int_compare:nNnTF { \g_degree_degreecnt_int } > {1} {degrees} {degree}
	\ of}
	\skip_vertical:n { 6pt plus 2pt minus 2pt }
	\int_until_do:nNnn { \l__degree_degreeno_int } = { \g_degree_degreecnt_int } {
    	\textls[60]{\text_uppercase:n {\seq_item:cn { g_degree_name_seq } { \l__degree_degreeno_int }}}\par and\par
		\int_incr:N     \l__degree_degreeno_int
		}
    \textls[60]{\text_uppercase:n {\seq_item:cn { g_degree_name_seq } { \l__degree_degreeno_int }}}
    \skip_vertical:n { 6pt plus 2pt minus 2pt }
}

%%%%%%%%%%  End Degree Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Signature Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand\SignatureBlockSize{m}{
	\__signature_sigsize:n {#1}
}
\tl_new:N \g__signature_sigsize_tl
\cs_new_protected:Nn \__signature_sigsize:n 
  {
	\tl_gset:Nf \g__signature_sigsize_tl { \tl_trim_spaces:n {#1} }
	\token_case_meaning:NnF \g__signature_sigsize_tl
	{ 
		\normalsize {} \small {} \footnotesize{} \scriptsize{} \tiny{}
	} {
		\msg_error:nn { \ClassName } { weird_sigsize }
	}
  }

\cs_new:Nn \__signature_block: {
	\int_compare:nNnT { \g_supervisor_supervisorcnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_supervisor }% this message is def'd in Abstract supervisor block
	}	
	\int_compare:nNnT { \g_acceptor_acceptorcnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_acceptor }
	}	
	\tl_if_exist:NF \g_dd_thesisdate_tl { 
		\msg_error:nn { \ClassName } { no_thesis_date }
	}
	\int_gzero_new:N \g__signature_autno_int
	\int_gzero_new:N \g__signature_supno_int
	\int_gzero_new:N \g__signature_accno_int
    \g__signature_sigsize_tl
    \dim_set:Nn \topsep {0pt}
    \dim_set:Nn \partopsep {0pt}
    %\begin{tabbing}
    %\hspace{1.35in} \= \hspace{1in} \kill 
    %%% replaced eight \> by &; eliminate tabbing, 2025/1/15
    \noindent
    \begin{tabular}{@{}ll@{}}
	\int_do_while:nNnn { \g__signature_autno_int } < { \g_author_authorcnt_int } {
		\int_gincr:N  \g__signature_autno_int
		Authored\ by: & \seq_item:cn { g_author_name_seq } { \g__signature_autno_int } \\  
		& \seq_item:cn { g_author_department_seq } { \g__signature_autno_int } \\
		& \g_dd_thesisdate_tl \\[1em]
	}
	\int_do_while:nNnn { \g__signature_supno_int } < { \g_supervisor_supervisorcnt_int } {
		\int_gincr:N  \g__signature_supno_int
		Certified\ by: & \seq_item:cn { g_supervisor_name_seq } { \g__signature_supno_int } \\
		& \seq_item:cn { g_supervisor_title_seq } { \g__signature_supno_int },\ 
			\g_titlepage_supervisor_designation_tl \\[1em]
	}
	\int_compare:nNnF { \g_acceptor_acceptorcnt_int } = {0} {
    	\int_do_while:nNnn { \g__signature_accno_int } < { \g_acceptor_acceptorcnt_int } {
    		\int_gincr:N  \g__signature_accno_int
    		Accepted\ by: & \seq_item:cn { g_acceptor_name_seq } { \g__signature_accno_int } \\
    		& \seq_item:cn { g_acceptor_department_seq } { \g__signature_accno_int }
    			\bool_if:NF \g__acceptor_title_tf_bool
    			{
    				\\
    				& \seq_item:cn { g_acceptor_title_seq } { \g__signature_accno_int }
    			}
			\int_compare:nNnTF { \g__signature_accno_int } = { \g_acceptor_acceptorcnt_int } 
			{ \\ }{ \\[1em]}
     	}
	}
	%\end{tabbing}
	\end{tabular}
}
\msg_new:nnnn { \ClassName } { weird_sigsize }
		{ \SignatureBlockSize\ expects\ a\ font-sizing\ command,\ such\ as\ \small,\ \footnotesize,\ etc.}{You\ used\ a\ weird\ input\ value\ here.\ If\ you\ did\ so\ deliberately,\ try\ continuing.}	
\msg_new:nnnn { \ClassName } { no_acceptor }
		{ Missing\ acceptor!\ You\ must\ issue\ the\ \Acceptor{name}{department}{title}\ command. }{
		You\ MUST\ issue\ the\ \Acceptor{name}{department}{title}\ command\ after\ \string\begin{document}\ and\ before\ \string\maketitle.}
\msg_new:nnnn { \ClassName } { no_thesis_date }
		{ Missing\ thesis\ date!\ You\ must\ issue\ the\ \ThesisDate{Date\ thesis\ is\ submitted}\ command.}{
		You\ MUST\ issue\ the\ \ThesisDate{Date thesis is submitted}\ command\ after\ \string\begin{document}\ and\ before\ \string\maketitle.}

% If for some reason you don't want a warning when you omit \Acceptor
\NewDocumentCommand\SuppressAcceptorError{}
  {
  	\msg_redirect_name:nnn { \ClassName } { no_acceptor } { none }
  }

%%%%%%%%%%  End Signature Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Copyright Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Directly add the xmp property that shows work is copyrighted. See l3pdfmeta.pdf. 
% This is not automatic with \DocumentMetadata. "True" must be capitalized.
%
\cs_if_exist:NT \pdfmeta_xmp_add:n {\pdfmeta_xmp_add:n{<xmpRights:Marked>True</xmpRights:Marked>}}

\tl_new:N \g_copyright_ccname_tl
\tl_new:N \g_copyright_cclicensetext_tl
\tl_new:N \g_copyright_copyrightlicencse_tl
\tl_new:N \g_copyright_pdfrightstext_tl
\tl_new:N \g__copyright_crwords_tl_
\tl_new:N \g__copyright_mitpermissionlast_tl

\tl_new:N \g_copyright_mitpermission_tl
\tl_gset:Nn \g__copyright_mitpermissionlast_tl {to\ MIT\ a\ nonexclusive,\ worldwide,\ irrevocable,\ royalty-free\ license\ to\ exercise\ any\ and\ all\ rights\ under\ copyright,\ including\ to\ reproduce,\ preserve,\ distribute\ and\ publicly\ display\ copies\ of\ the\ thesis,\ or\ release\ the\  thesis\ under\ an\ open-access\ license.}

\bool_new:N \g__cclicense_tf_bool
\bool_gset_false:N \g__cclicense_tf_bool

\NewDocumentCommand\CClicense{mm}{
	\__copyright_licensedata:nn {#1}{#2}
}
\cs_new_protected:Nn \__copyright_licensedata:nn 
  {
	\tl_gset:Nf \g_copyright_cclicensetext_tl {\hrefurl{ \tl_trim_spaces:n {#2} }{ \tl_trim_spaces:n {#1} } }% #1 - text, #2 - url  
	\tl_gset:Nx \g_copyright_ccname_tl        { \tl_trim_spaces:n {#1} } 
	\bool_gset_true:N \g__cclicense_tf_bool
	\cs_if_exist:NT \pdfmeta_xmp_add:n {
			\pdfmeta_xmp_add:n {<xmpRights:WebStatement>#2</xmpRights:WebStatement>}
	}
	\cs_if_exist:NTF \msg_note:nnn % command was added to expl3 2021/05/18
	  {
		\msg_note:nnn { \ClassName } { cclicense} {#1}
	  }
	  {
		\msg_log:nnn  { \ClassName } { cclicense} {#1}
	  } 
  }
\msg_new:nnn { \ClassName } { cclicense } { Using\ Creative\ Commons\ License\ #1.}


%%%%%%%%%%  End Copyright Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% In case tagging is not loaded, 2025/01/17
\cs_if_exist:NF \tag_struct_begin:n
	{ 
	  \cs_new:Npn \tag_struct_begin:n #1 { \scan_stop: } 
	  \cs_new:Nn  \tag_struct_end:       { \scan_stop: } 
	}

%%%%%%%%%%  Title page Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RenewDocumentCommand{\title}{m}
	{
		\__mitthesis_title:n { #1 }
		\cs_gset:Npe \@title { \tl_use:N \g_mitthesis_title_tl } % 2024/08/06
		\hypersetup{
			pdftitle={{\g_mitthesis_title_tl}},% extra braces protect commas that may be in title tl.
		}
	}
%
\tl_new:N \g_mitthesis_title_tl
%
\cs_new_protected:Nn \__mitthesis_title:n
	{
		\tl_gset:Nn \g_mitthesis_title_tl { \tl_trim_spaces:n {#1} }
	}

\tl_new:N \g_titlepage_institution_name_tl
\tl_gset:Nn \g_titlepage_institution_name_tl {Massachusetts\ Institute\ of\ Technology} 
\cs_new:Npn \Institution #1 { \tl_gset:Nn \g_titlepage_institution_name_tl {\tl_trim_spaces:n #1} }


%%%%%%% Adjust vertical skips between the major blocks of the title page

\bool_new:N \g_titlepage_squashglue_bool
\cs_new_protected:Nn \__titlepage_bottomskip: {
	\if_bool:N \g_titlepage_squashglue_bool 
		{ 	\skip_vertical:n { 0pt plus 1filll  } }
	\else:
		{   \skip_vertical:n { 0pt plus 12fill } }
	\fi:
}
\NewDocumentCommand\Squash{}{ \bool_set_true:N \g_titlepage_squashglue_bool }% Squashes all glue from bottom upward

\bool_new:N \g_titlepage_tighten_bool
\cs_new_protected:Nn \__titlepage_blockskip:nn {
	\if_bool:N \g_titlepage_tighten_bool 
		{ 	\skip_vertical:n { 6pt plus #2fill    } }
	\else:
		{   \skip_vertical:n { #1pt plus #2fill } }
	\fi:
}
\NewDocumentCommand\Tighten{}{ \bool_set_true:N \g_titlepage_tighten_bool }% Reduces 12pt and 18pt skips to 6pt

%%%%%%%%%%%%

\RenewDocumentCommand\maketitle{s}{
	\cs_if_exist:NTF \DegreeMonth { \scan_stop: } { \msg_error:nn { \ClassName } { no_degree_date } }% msg def'd in degree-date section
%	
	\bool_if:NTF \g__cclicense_tf_bool { 
		\tl_gset:Nn \g_copyright_copyrightlicencse_tl 
			{This\ work\ is\ licensed\ under\ a\ \mbox{\g_copyright_cclicensetext_tl}\ license.\par\g_copyright_mitpermission_tl}
		\tl_gset:Nn \g_copyright_pdfrightstext_tl 	 
			{This\ work\ is\ licensed\ under\ a\ \g_copyright_ccname_tl\ license.\space \g_copyright_mitpermission_tl}
	}{
		\tl_gset:Nn \g_copyright_copyrightlicencse_tl 
			{All\ rights\ reserved. \par\g_copyright_mitpermission_tl}
		\tl_gset:Nn \g_copyright_pdfrightstext_tl 	 
			{All\ rights\ reserved.\space \g_copyright_mitpermission_tl}
   }
   \int_compare:nNnTF {\g_author_authorcnt_int} > {1} 
   		{   
			\tl_gset:Nn \g__copyright_crwords_tl_ {The\ authors\ hereby\ grant} 
		}
		{
			\tl_gset:Nn \g__copyright_crwords_tl_ {The\ author\ hereby\ grants} 
		}
    \IfBooleanTF{#1}{
	    \tl_gset:Nn \g_copyright_mitpermission_tl {\scan_stop:}
    }{
	    \tl_gset:Nn \g_copyright_mitpermission_tl {\g__copyright_crwords_tl_\ \g__copyright_mitpermissionlast_tl}
    }
% 
	\clearpage
	\thispagestyle{empty}
	\tag_struct_begin:n {tag=Sect, title=Titlepage}
	\vbox_to_ht:nn { \vsize }% to prevent signature block from breaking across page
		{
			{\centering
                \setlength{\parskip}{7.5pt plus 1pt minus 1pt}% edited all vertical space on this page 2023/10/25
                \setlength{\parindent}{0pt}\pdfbookmark[0]{Title\ page}{titlepage}
                {
                	\tag_struct_begin:n{tag=Title, title=Title}
                    \Large\textbf{\g_mitthesis_title_tl}
                    %\phantomsection\addcontentsline{toc}{chapter}{Title\ page}
                    \par
                    \tag_struct_end:
                }
    			\__titlepage_blockskip:nn {12}{1.5}
				\tag_struct_begin:n {tag=Div, title=Author}
                \__author_block:
    			\tag_struct_end:
				\__titlepage_blockskip:nn {12}{1.5}
                \tag_struct_begin:n {tag=Div, title=Degree} 
                \__degree_block:
                at~the\par
                \textls[60]{\text_uppercase:n { \g_titlepage_institution_name_tl }}\par
                \DegreeMonth\ \DegreeYear\par
                \tag_struct_end:
    			\__titlepage_blockskip:nn {12}{2}
				\tag_struct_begin:n {tag=Div, title=Copyright}
                \copyright\space\DegreeYear\space\CopyrightAuthor\@.\c_space_token \g_copyright_copyrightlicencse_tl % \@. in case name ends with III, IV, V,...
				\par % required to center \g_copyrightlicense_tl text.
				\tag_struct_end:
			}
			\__titlepage_blockskip:nn {18}{2}
            \tag_struct_begin:n{tag=Div, title=Signatures}
            \__signature_block:
			\tag_struct_end:
			\__titlepage_bottomskip:
		}
		\tag_struct_end: % end section
		\hypersetup{
    		pdfcopyright={Copyright\ \DegreeYear\ by\ \CopyrightAuthor.\space \g_copyright_pdfrightstext_tl},
    		pdfauthor={\g__author_pdfca_tl},
    		pdfcaptionwriter = {\g__author_pdfca_tl},
    	}
	\cleardoublepage
}

%%%%%%%%%%  End title page module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  Abstract page Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% to change abstract name  (e.g., to "Summary"), follow either approach in your preamble:
%	\RenewExpandableDocumentCommand\abstractname{}{Summary}
%	\renewcommand\abstractname{Summary}

\RenewDocumentEnvironment{abstract}{+b}{
	\newpage
    \tag_struct_begin:n {tag=Sect, title=Abstract~page}
    {\centering
    	\tag_struct_begin:n{tag=Div, title=Abstract~title}
        \pdfbookmark[0]{Abstract}{abstract}
        {\large{\textbf{\g_mitthesis_title_tl}}
        %\phantomsection\addcontentsline{toc}{chapter}{\abstractname}
        \par
        \tag_struct_end:}
        \setlength{\parskip}{0.5\baselineskip plus 2pt minus 2pt}
        \tag_struct_begin:n {tag=Div, title=Abstract~author}
        \__author_abstractblock:
        \par\tag_struct_end: % \par is necessary to end the structure, 2025/01/17
        \tag_struct_begin:n {tag=Div, title=Abstract~degree}
        \__degree_abstractblock:
        \tag_struct_end:
	}
    \skip_vertical:n {2\baselineskip}
    \tag_struct_begin:n{tag=Div, title-o=\abstractname}
    \noindent
	\textbf{ \text_uppercase:n {\abstractname} }
	\skip_vertical:n { 0.5em }
	#1
	\par\tag_struct_end:
	\tl_if_blank:nT {#1} { MISSING\ ABSTRACT!  \msg_error:nn { \ClassName } { missing_abstract } }
}{
	\tag_struct_begin:n {tag=Div, title-o=\g_abstract_supervisor_designation_tl }
    \__supervisor_abstractblock:
    \tag_struct_end: % end div
	\tag_struct_end: % end section
	\cleardoublepage\ignorespacesafterend
}
\msg_new:nnnn { \ClassName } { missing_abstract } {Missing\ Abstract!! } { No\ file\ was\ input\ for\ the\ abstract.\  You\ need\ to\ do\ \string\input{abstract.tex}.}

%%%%%%%%%%  End abstract page Module  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\debug_off:n {all}
\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% End title and abstract page codes  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%  A nomenclature environment  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecommand{\nomname}{Nomenclature}  
\newlength\nomenwidth
\newlength\savitemsep

% nomenclature entries
\NewDocumentCommand\entry{m m}{%
    \item[#1\hfill]#2%
    \@itempenalty=-\@lowpenalty
}
% nomenclature subheadings 
\NewDocumentCommand\EntryHeading{m}{%
	\itemsep3\p@ plus 1\p@ minus 1\p@
    \goodbreak\item[\itshape#1\hfill]\mbox{}% mbox added for tagged pdf 2023/10/11
    \setlength{\itemsep}{\savitemsep}\@itempenalty=1000
}
%
%   Increase first optional argument to > 2em if wide entries cause undesired misalignment of columns. 
%   Second optional argument can be used to rename the environment, e.g., to List of Symbols.
%   Third optional argument selects section-level or chapter-level style for the nomenclature list.
%   Fourth option argument selects the style of the toc entry (by default, same as #3); the values
%		frontmatter or backmatter can be used when nomenclature is located with front or back matter. 2025/01/17
\NewDocumentEnvironment{nomenclature}{O{2em} O{\nomname} O{section} O{#3}}{%
    \setlength\columnsep{2em} 
    \setlength{\nomenwidth}{#1}
    \MakeLinkTarget*{nomenclature}\csname #3\endcsname *{#2}\addcontentsline{toc}{#4}{#2}
    \raggedright
    \begin{list}{}{%
         \setlength{\itemsep}{0pt}%
         \setlength{\parsep}{\itemsep}%
         \setlength{\labelsep}{1em}%
         \setlength{\labelwidth}{\nomenwidth}%
         \setlength{\leftmargin}{\labelwidth}%
         \addtolength{\leftmargin}{\labelsep}%
		 \setlength{\savitemsep}{\itemsep}%
    }%
}{\end{list}\ignorespacesafterend}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
%%
%% End of file `mitthesis.cls'.
