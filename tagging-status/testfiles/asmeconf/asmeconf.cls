% !TEX encoding = UTF-8 Unicode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  This file provides the asmeconf LaTeX class for formatting conference papers according to 
%%  ASME conference requirements as represented on ASME's conference web pages in 2025.
%%
%%  This file's version and date:
	\def\versionno{1.40}
	\def\versiondate{2025/01/29\space}
%%
%%  Author: John H. Lienhard, V
%%          Department of Mechanical Engineering
%%          Massachusetts Institute of Technology
%%          Cambridge, MA 02139-4307 USA
%%
%%  This LaTeX template was designed to approach the following aims:
%%
%%          1. Match ASME's current layout and font specifications
%%          2. With amseconf.bst, match ASME's reference formats including DOI & URL (replaces asmems4.bst)
%%          3. Provide hyperref compatibility for hyperlinks, pdf bookmarks, and metadata
%%          4. Set author names in either the traditional grid or the more recent inline style
%%          5. Support citations, footnotes, and bold face, sans serif math in section headings
%%			6. Provide line numbers for editing and review
%%			7. Support balancing length of columns on last page
%%			8. Provide copyright footer for federal employees and contractors
%%			9. Support archival PDF/A standards
%%		   10. Enable various math and text features from the newtxmath and newtxtext packages
%%		   11. Support inclusion of passages in languages other than English
%%
%%  This class is compatible with either pdfLaTeX or LuaLaTeX. Fontspec will load automatically with LuaLaTeX,
%%  but the class does not support unicode-math. To use LuaLaTeX without fontspec, call the [nofontspec] option.
%%
%%	Use an up-to-date LaTeX distribution: for pdfLaTeX, TeX Live 2020 or later; for LuaLaTeX, TeX Live 2021 or later.
%%  A complete LaTeX installation is also recommended: asmeconf loads ~30 packages, in addition to LaTeX core packages.
%%	All packages required by the class are in TeXLive and CTAN (https://ctan.org/). 
%%
%%  Commands for entering conference headers and author names are specific to this class.
%%  See asmeconf-template.tex for details.
%%
%%  The class defines abstract (with keywords), abstract* (no keywords), and nomenclature environments. 
%%  The latter has an optional argument to control the space between the entries and the definitions.
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{asmeconf}[\versiondate ASME Conference Paper LaTeX Template (JHL)]

\LoadClass[twoside,10pt]{article}% twocolumn is initiated in \MakeTitle
% Even/odd page layout is not used in ASME's specs, although the papers are printed in two-sided format.

\RequirePackage{iftex}[2019/11/07]% provides \ifpdftex (many) & \ifluatex (once)
\RequirePackage{ifthen}% ifthenelse (many) & \whiledo (once)
\RequirePackage{etoolbox}% using patchcmd in 4 or 5 places

\ExplSyntaxOn
  \str_const:Nn \ClassName {asmeconf}
\ExplSyntaxOff

%%%%%%%%%%%%%  Compatibility codes for older distributions  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% these will be dropped as time goes by ... 

\providecommand\IfFormatAtLeastTF{\@ifl@t@r\fmtversion}%  compare version to date; \If... added to latex 2020/10/01
\providecommand\IfPackageAtLeastTF{\@ifpackagelater}%     compare version to date; \If... added to latex 2020/10/01
\providecommand\IfPDFManagementActiveTF{\@secondoftwo}%   \If... added to latex 2021/07/23
\providecommand\IfPackageLoadedTF{\@ifpackageloaded}%     \If...added to latex 2021/11/15
\providecommand\ClassNoteNoLine[2]{\typeout{^^JClass Note #1: #2.^^J}}%  log & terminal note... added to latex 2021/11/15

\IfFormatAtLeastTF{2020/10/01}{\relax}{%
	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion.  Formats dated 2020/10/01 or later are recommended for the asmejour class. Older formats and packages may generate errors or fail entirely!}{Please UPDATE your LaTeX distribution to obtain best results. TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  You can try to click past the errors for now.}%
}

% check whether pdfmanagement (\DocumentMetadata) has been loaded (else fall back to hyperxmp and bookmark packages after loading hyperref)
\newif\ifasme@pdfmanagement
\IfPDFManagementActiveTF{
	\asme@pdfmanagementtrue 
}{
	\asme@pdfmanagementfalse
	\ClassWarningNoLine{\ClassName}{pdfmanagement is not active. Will load hyperxmp and bookmark packages instead}
}

% If latex release is pre 2022/06, need to load textcase package
\ifx\AddToNoCaseChangeList\@undefined % updated 2022/07/03, see https://github.com/John02139/asmeconf/issues/5 
	\RequirePackage{textcase} %% Allows uppercase titles and captions without errors from math and citations
	\typeout{Asmeconf is loading textcase package.}
\else
	\NewCommandCopy{\MakeTextUppercase}{\MakeUppercase}% keep using \MakeTextUppercase for backward compatibility
\fi

% Allow pre 2021/11/15 formats to see the graphicx alt key without causing an error
\IfFormatAtLeastTF{2021/11/15}{
	\relax
}{ 
	\AtBeginDocument{
		\IfPackageLoadedTF{graphicx}{\define@key{Gin}{alt}{}}{\relax}
	}
}

% Enable pre-2020/10 formats to access essential macros later moved into LaTeX kernel
\ifdefined\NewDocumentCommand\else
  \RequirePackage{xparse}% enable older installations to access features in LaTeX kernel since 2020/10/01; but need at least 2018/04...
\fi

% Provide pre-2020/10 installations with basic unicode character mappings 
\IfFormatAtLeastTF{2020/10/01}{\relax}{%
\ifpdftex
	\pdfgentounicode=1  			    %% enable CMaps; was moved into the latex kernel Oct 2020
	\input glyphtounicode.tex 		    %% lists of mappings; was moved into the latex kernel Oct 2020
\fi
}

\IfPackageAtLeastTF{iftex}{2019/11/07}{\relax}{%
    \ClassError{\ClassName}{Package iftex is too old. Go to \string https://ctan.org and download an up-to-date version.}{%
    Your latex installation does not have an up-to-date version of the package iftex. You can get it at CTAN: \string https://ctan.org.}
}

\IfFormatAtLeastTF{2018/04/01}{\relax}{\RequirePackage[utf8]{inputenc}} 

% another legacy package, fnpos, is loaded if footmisc package is older than 2022/02/05 (near line 1070)

%%%%%%%%%%%%%% Options for the class %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
   family=\ClassName,
   prefix=asmeconf@,
   setkeys=\kvsetkeys,
}

%%% set key [colorlinks] to have colored hyperlinks, rather than black links (use a key with new pdfmanagement, 2021/12/01)
\define@key{\ClassName}{colorlinks}[colorlinks]{%
   \PassOptionsToPackage{#1}{hyperref}%
}

%% Option for caption text not to use boldface type [unboldcaption]
\DeclareBoolOption{unboldcaption}

%% Option to obtain line numbers [lineno] 
\DeclareBoolOption{lineno}

%% Option to balance column height on last page [balance] 
\DeclareBoolOption{balance}

%% Option to convert inline author data to a grid of authors
\DeclareBoolOption{grid}

%% Option for copyright notice if all authors are government employees [govt]
\DeclareBoolOption{nofoot}

%% Option for copyright notice if all authors are government employees [govt]
\DeclareBoolOption{govt}

%% Option for copyright notice if some (not all) authors are government employees [govtsome]
\DeclareBoolOption{govtsome}

%% Option for government contractor copyright notice [contractor]
\DeclareBoolOption{contractor}

%% Option NOT to use fontspec package under luaLaTeX [nofontspec]
\DeclareBoolOption{nofontspec}

%% Option to patch caption package for tagged pdf [captionpatch].  Experimental, 2025/01/26
\DeclareBoolOption{captionpatch}

%%% Use these switches to load other alphabets for Cyrillic, Greek, Japanese, and Vietnamese text
\newif\ifac@cyrillic\ac@cyrillicfalse
\newif\ifac@greek\ac@greekfalse
\newif\ifac@japanese\ac@japanesefalse
\newif\ifac@vietnamese\ac@vietnamesefalse
\newif\ifac@mainset\ac@mainsetfalse

\providecommand\ac@TtwoA{}
\providecommand\ac@LGR{}
\providecommand\ac@Tfive{}

%%% Test whether main language is from a group that use the Cyrillic alphabet
\NewDocumentCommand\@FindCyr{>{\SplitList{;}}m}{\ProcessList{#1}{\@FlagCyr}}
\providecommand{\ac@main}{\relax}
\NewDocumentCommand\@FlagCyr{m}{%
	\ifthenelse{\equal{#1}{\ac@main}}{\ac@cyrillictrue\def\ac@TtwoA{T2A}}{\relax}% comparing strings
}

\define@key{\ClassName}{main}{% remove default 2024/07/26, to avoid conflict with subsequent logic
	  \PassOptionsToPackage{main=#1,#1}{babel}% added #1 resolves conflict of russianb.ldf & ukrainianb.ldf under "main=".
	  \ac@mainsettrue
	  \ifthenelse{\equal{#1}{english}}{%
			\ClassNoteNoLine{\ClassName}{Selecting #1 as the primary language}%
			\ifthenelse{\equal{#1}{greek}}{%
				\ac@greektrue
				\def\ac@LGR{LGR}%
			}{\relax}%
			\ifthenelse{\equal{#1}{vietnamese}}{%
				\ac@vietnamesetrue
				\def\ac@Tfive{T5}%
				\RequirePackage[vietnamese=nohyphenation]{hyphsubst}% Eliminates babel warning
			}{\relax}%				
			\def\ac@main{#1}%
			\@FindCyr{russian;belarusian;bulgarian;macedonian;serbianc;ukrainian}
	  }%
}
\define@key{\ClassName}{vietnamese}[]{%
	\RequirePackage[vietnamese=nohyphenation]{hyphsubst}% using key, not option, to allow loading package w/o babel warning.
	\PassOptionsToPackage{vietnamese.noencoding}{babel}% modified.noencoding suppresses unnecessary warning about inputenc
	\ac@vietnamesetrue
	\def\ac@Tfive{T5}%
}

\DeclareDefaultOption{}% suppress warnings about unused options
\ProcessKeyvalOptions{\ClassName}

%% if main language was not chosen explicitly, ensure default to English
\ifac@mainset\relax\else
	\PassOptionsToPackage{main=english}{babel}%
	\ClassInfo{\ClassName}{Selecting English as the primary language, since main= not set}%
\fi

%% Turn off these keys now that we're done with them
\def\@KeyFamily{\ClassName}
\NewDocumentCommand\ac@DisableOption{m}{%
  \DisableKeyvalOption[%
     action=ignore,%
     class=\ClassName%
  ]{#1}{\@KeyFamily}%
}
\NewDocumentCommand\@DisableKeys{>{\SplitList{;}}m}{\ProcessList{#1}{\ac@DisableOption}}

\@DisableKeys{colorlinks;unboldcaption;lineno;balance;grid;nofoot;govt;govtsome;contractor;nofontspec;captionpatch;main;vietnamese}


%%%%%%%%%  Various font-related options  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\SetupKeyvalOptions{
   family=acfonts,
   prefix=acfonts@,
   setkeys=\kvsetkeys,
}

%%% for mathalfa, we may now pass options in this format:  mathalfa=cal=euler, mathalfa=frak=boondox
\define@key{acfonts}{mathalfa}{%
  \PassOptionsToPackage{#1}{mathalfa}%
}

%% option for slightly larger small capitals font, via newtxtext
\DeclareOption{largesc}{%
	\ifpdftex
		\PassOptionsToPackage{largesc=true}{newtxtext}% largesc is a boolean key in newtxtext
	\else
		\ClassWarningNoLine{\ClassName}{largesc option is not available under luaLateX. It will be ignored}%
	\fi
}

%% Disable newtxtext osf option, which is not appropriate for documents in this class
\DeclareOption{osf}{%
	\PassOptionsToPackage{lining}{newtxtext}%
}

%% option to hyphenate the inconsolata typewriter font [hyphenate] and to issue a warning when that's done.
\DeclareOption{hyphenate}{%
	\ifac@fontspec
		\ClassWarningNoLine{\ClassName}{hyphenate option is not supported by fontspec. It will be ignored}%
	\else
		\PassOptionsToPackage{hyphenate}{inconsolata}% hyphenate is a key via xkeyval in inconsolata
		\ClassNoteNoLine{\ClassName}{Allowing hyphenation of typewriter font}%
	\fi
}
%% option for monospacing in inconsolata typewriter font [mono].
\def\MonoNotMono{WordSpace={1,1,1}}% rescaled tt font to match pdf, 2024/07/28
\DeclareOption{mono}{%
	\ifac@fontspec
		\def\MonoNotMono{WordSpace={1,0,0},PunctuationSpace={3}}% NB: these are the default WordSpace values. 20204/07/30
	\else
		\PassOptionsToPackage{mono}{inconsolata}% mono is a key via xkeyval in inconsolata
	\fi
}
%% option for unslashed zero in inconsolata typewriter font [var0].
\def\ssztwo{}% for Inconsolatazi4; default uses slashed zero, +ss02 uses regular zero
\DeclareOption{var0}{%
	\ifac@fontspec
		\def\ssztwo{+ss02}% stylistic alternate for regular zero
	\else
		\PassOptionsToPackage{var0}{inconsolata}% var0 is a key via xkeyval in inconsolata
	\fi
}

\ProcessKeyvalOptions{acfonts}%
\def\@KeyFamily{acfonts}
\@DisableKeys{mathalfa;largesc;osf;hyphenate;mono;var0}


%%%%%%%   PDF/A Compliance Options  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% new pdf management in LaTeX, with \DocumentMetaData{..}, is preferred to this approach.

\newif\ifac@setpdfa\ac@setpdfafalse
\newif\ifac@pdfaone\ac@pdfaonefalse

\ifasme@pdfmanagement\else
    
    \SetupKeyvalOptions{
       family=pdfaopt,
       prefix=pdafopt@,
       setkeys=\kvsetkeys,
    }
    \ifpdftex %% PDF/A compliance has only been configured for pdflatex
    %
    	%%% set key [pdfa] to activate pdf/a compliance (default is pdf/A-3u)
    	\define@key{pdfaopt}{pdf-a}[true]{%
    	  \IfFormatAtLeastTF{2018/12/01}{\relax}{%
    	  	 \ClassError{\ClassName}{Your LaTeX format is dated \fmtversion.  Formats dated 2018/12/01 or later are necessary for the [pdf-a] option. Older formats may generate errors}{Please UPDATE your LaTeX distribution to obtain best results. TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  Meanwhile, you can remove the [pdf-a] option and try again}%
    	  }
          \ac@setpdfatrue
          \PassOptionsToPackage{pdfa}{hyperref}
          \AtBeginDocument{\hypersetup{pdfapart=3,pdfaconformance=u}}% note: hyperref takes these options if hyperxmp is loaded
    	}
    	%%% to select part 1, 2 or 3 
    	\define@key{pdfaopt}{pdfapart}[3]{%
    	   \def\asmeconf@tempa{#1}
           \AtBeginDocument{\hypersetup{pdfapart=\asmeconf@tempa}}
    	   \ifthenelse{\equal{#1}{1}}{\ac@pdfaonetrue}{\relax}%
    	}
    	%%% to select conformance b or u.  NB: a is not possible with pdfLaTeX, and u is not possible with 1.
    	\ExplSyntaxOn
    	\define@key{pdfaopt}{pdfaconformance}[u]{%
    	   \str_set:Ne \l_tmp_str { \str_uppercase:n {#1} }
    %	   \typeout{\l_tmp_str}
           \AtBeginDocument{\hypersetup{pdfaconformance=\l_tmp_str}}
    	}
    	\ExplSyntaxOff
    \else
    	\define@key{pdfaopt}{pdf-a}[true]{%
           \ac@setpdfatrue
        }
    \fi
    
    \ProcessKeyvalOptions{pdfaopt}%
    
    %% Done with these keys, so we can now disable them
    \def\@KeyFamily{pdfaopt}
    \@DisableKeys{pdf-a;pdfapart;pdfaconformance}
\fi


%%%%%%%%%%%%  PDF/A compliance related  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifasme@pdfmanagement\else
    \ifpdftex 
    	\ifac@pdfaone
    		\pdfminorversion=4 % for pdf/a-1 need version 4, not 7
    	\else
      		\pdfminorversion=7 % this selection is not essential.
    	\fi
    \else
    	\ifluatex
    		\ifac@setpdfa\ClassWarningNoLine{\ClassName}{pdf-a option requires pdfLaTeX engine. Under LuaLaTeX, use %
    			\protect\DocumentMetadata{pdfstandard=A-3b} before \protect\documentclass[..]{asmeconf}}%
    		\fi
        	\directlua{
                if pdf.getminorversion() \string~= 7 then
                  if (status.pdf_gone and status.pdf_gone > 0)
                  or (status.pdf_ptr and status.pdf_ptr > 0) then
                    tex.error("PDF version cannot be changed anymore")
                  else
                    pdf.setminorversion(7)
                  end
                end
            }
    	\else 
      		\ClassError{\ClassName}{Please use either pdfLaTeX or LuaLaTeX}{This class has NOT been configured to support other engines, and the results will be unpredictable. Exit and rerun using either pdfLaTeX or LuaLaTeX.}%
    	\fi
    \fi
\fi


%%%%%%%%%%%%%   More Language options  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% option to use fontspec [fontspec] (for complex language-specific fonts)
\newif\ifac@fontspec\ac@fontspecfalse
\newif\iffontspecloaded\fontspecloadedfalse% so user can test in .tex file

\ifpdftex
	\ifasmeconf@nofontspec
		\ClassWarningNoLine{\ClassName}{The [nofontspec] option requires LuaLaTeX. It will be ignored under pdfLaTeX}%
	\fi
\else
	\ifasmeconf@nofontspec
		\ClassWarningNoLine{\ClassName}{The [nofontspec] option has been issued. LuaLaTeX will run without font support}%
	\else
    	\IfFormatAtLeastTF{2020/10/01}{%
    		\ac@fontspectrue
    		\fontspecloadedtrue
    	}{%
    	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion.  LaTeX installations dated 2020/10/01 or later are needed to run LuaLaTeX with the fontspec package. Fontspec will NOT be loaded. Language support will be minimal}{Please UPDATE your LaTeX distribution to obtain best results. TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  You may alternatively choose the [nofontspec] option.}%
    	}
	\fi
\fi

\DeclareOption{japanese}{% mainly to control loading of fontspec options
	\ifac@fontspec	
		\PassOptionsToPackage{japanese}{babel}%
		\ac@japanesetrue
	\else
		\ClassWarningNoLine{\ClassName}{[japanese] option is supported only under LuaLaTeX with fontspec. It will be ignored}%
	\fi
}

\DeclareOption{greek}{%
	\PassOptionsToPackage{greek}{babel}%
	\ac@greektrue
	\def\ac@LGR{LGR}%
}

%% Cyrillic languages
\NewDocumentCommand\@CyrOptions{>{\SplitList{;}}m}{\ProcessList{#1}{\@CyrOptSet}}
\NewDocumentCommand\@CyrOptSet{m}{%
	\DeclareOption{#1}{%
		\PassOptionsToPackage{#1}{babel}%
		\ac@cyrillictrue
		\def\ac@TtwoA{T2A}%
	}
}
\@CyrOptions{russian;belarusian;bulgarian;macedonian;serbianc;ukrainian}

% Several languages do not have .ldf files to load. Babel will call these on demand.
%
\DeclareOption{arabic}{\ClassError{\ClassName}{Do not specify "arabic" as a class option}{Instead, give the option [bidi=basic] and specify "arabic" when you call the language within your document.}}
%
\DeclareOption{bengali}{\ClassError{\ClassName}{Do not specify "bengali" as a class option}{Babel does not have an ldf file for Bengali. Instead, specify "bengali" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{chinese-simplified}{\ClassError{\ClassName}{Do not specify "chinese-simplified" as class option}{Babel does not have an ldf file for simplified Chinese. Instead, specify "chinese-simplified" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{chinese-traditional}{\ClassError{\ClassName}{Do not specify "chinese-traditional" as class option}{Babel does not have an ldf file for traditional Chinese. Instead, specify "chinese-traditional" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{chinese}{\ClassError{\ClassName}{Do not specify "chinese" as a class option}{Instead, specify either "chinese-simplified" or "chinese-traditional" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{hindi}{\ClassError{\ClassName}{Do not specify "hindi" as a class option}{Babel does not have an ldf file for Hindi. Instead, specify "hindi" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{korean}{\ClassError{\ClassName}{Do not specify "korean" as class option}{Babel does not have an ldf file for Korean. Instead, specify "korean"when you call the language within your document. No class option is needed.}}
%
\DeclareOption{marathi}{\ClassError{\ClassName}{Do not specify "marathi" as a class option}{Babel does not have an ldf file for Marathi. Instead, specify "marathi" when you call the language within your document. No class option is needed.}}
%
\DeclareOption{tamil}{\ClassError{\ClassName}{Do not specify "tamil" as a class option}{Babel does not have an ldf file for Tamil. Instead, specify "tamil" when you call the language within your document. No class option is needed.}}

%% Suppress warnings about unused global options
\DeclareOption*{}

\ProcessOptions \relax %% end of options section


%%%%%%%%%%%%%  Geometry, bibliography, graphics, colors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[letterpaper, left=0.5in, right=0.5in, top=0.5in, bottom = 1.in, footskip=0.5in, columnsep=0.38in]{geometry}
% conforms to ASME required margins
\setlength\parindent{0.25in}

\RequirePackage[sort&compress,numbers]{natbib} 
\setlength\bibsep{1pt plus 1pt minus 1pt}

\RequirePackage{graphicx} % removed obsolete options, 2023/11/19
\RequirePackage[dvipsnames,svgnames,x11names]{xcolor}


%%%%%%%%%%%%  Table related %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{booktabs}
\RequirePackage{array} 

\RequirePackage{dcolumn}% alignment on decimal places
% use d{x.y} to center on "." as in "12.234" 
\newcolumntype{d}[1]{D{.}{.}{#1}}
% NB: The above conflicts with babel's Spanish language option which makes "." an active character.
% Instead, to use "," as the decimal separator, choose columntype "," (as in "12,234")
\newcolumntype{,}[1]{D{,}{,}{#1}}


%%%%%%%%%  Caption related  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Needs to come before babel messes with the captions, to keep uppercase text. 2021/12/25

\RequirePackage[labelfont={sf,bf},hypcap=false]{caption}
\RequirePackage[list=true,hypcap=false]{subcaption}

%% This option is experimental and documented only here, 2025/01/26
%% 	 with this option asmeconf can validate as pdf 2.0/a-4f
%%   subfigures are not specifically addressed in this patch
%% 	 babel [spanish] option is NOT compatible with tagging !!
\ifasmeconf@captionpatch
%%  see github discussion of this patch by Ulrike Fischer
%% 	https://github.com/latex3/tagging-project/issues/720#issuecomment-2386568711
	\ExplSyntaxOn
	\IfPackageLoadedTF{tagpdf}{% this test may need to be removed once latex-lab moves to kernel code
        \RemoveFromHook{begindocument}[latex-lab-testphase-float]
        \socket_new_plug:nnn{tagsupport/parbox/before}{caption}
          {   
           \tagpdfparaOn %restart para tagging
           \tl_if_empty:NTF\@current@float@struct
            {     
             \tag_struct_begin:n{tag=Caption,firstkid}
            }
            {
             \tag_struct_begin:n{tag=Caption,parent=\@current@float@struct,firstkid}
            } 
          }
        \socket_new_plug:nnn{tagsupport/parbox/after}{caption}
          {
           \tag_struct_end:   
          }
        \l@addto@macro\caption@beginex@hook{%
          \tagpdfparaOff %leavevmode in parbox should not start paragraph structure
          \AssignSocketPlug{tagsupport/parbox/before}{caption}
          \AssignSocketPlug{tagsupport/parbox/after}{caption}}
	}{}
	\ExplSyntaxOff
\fi
 
\DeclareCaptionLabelFormat{uppercase}{\MakeTextUppercase{#1} #2}
\DeclareCaptionTextFormat{boldmath}{\mathversion{sansbold}#1}
\DeclareCaptionTextFormat{sansmath}{\mathversion{sans}#1}

\ifasmeconf@unboldcaption
	\captionsetup[figure]{labelformat=uppercase,labelfont={sf,bf,small},textfont={sf,md,small},textformat=sansmath,labelsep=colon}
	\captionsetup[table]{labelformat=uppercase,labelfont={sf,bf,small},textfont={sf,md,small},textformat=sansmath,labelsep=colon,skip=0.5\baselineskip}
\else
	\captionsetup[figure]{labelformat=uppercase,labelfont={sf,bf,small},textfont={sf,bf,small},textformat=boldmath,labelsep=colon}
	\captionsetup[table]{labelformat=uppercase,labelfont={sf,bf,small},textfont={sf,bf,small},textformat=boldmath,labelsep=colon,skip=0.5\baselineskip} %name=TABLE,
\fi

%% This construction avoids a failure of hyperref in relation to uppercase captions
%% Discussion: https://tex.stackexchange.com/questions/375695/maketextuppercase-inside-table-captions
\AtBeginDocument{
   \let\scaption\caption
   \renewcommand*{\caption}[2][\shortcaption]{\def\shortcaption{#2}\scaption[#1]{\MakeTextUppercase{#2}}}
}

%%%%%%%%%%%%  Font related  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{mathtools}% loads and extends amsmath

\ifpdftex
	% must load before babel
	\RequirePackage[\ac@TtwoA,\ac@LGR,\ac@Tfive,T1]{fontenc}
	% T2A - Cyrillic (w/o babel warning); LGR - Greek; T5 - Vietnamese; put T1 last 2022/03/10
\fi

\RequirePackage[]{babel} 

\ifpdftex
    \RequirePackage[helvratio=.91]{newtxtext}% rescaled 22/03/10
    \RequirePackage[varqu,varl,scale=1.05]{inconsolata}% sans typewriter font % rescaled 22/03/10
    \RequirePackage[]{newtxmath}
\else
    \ifac@fontspec
        \RequirePackage[varqu,varl]{inconsolata}  % typewriter font for math 
        \renewcommand\rmdefault{ntxtlf}           % roman font for math
		\RequirePackage[T1]{fontenc} 			  % qhv is not TU encoded, 2021/12/24
	        \DeclareFontFamily{T1}{\sfdefault}{}  % sf for math
	        \DeclareFontShape{T1}{\sfdefault}{m}{n}{<-> s*[0.94] ec-qhvr}{} %% see t1qhv.fd; 0.9-->0.94 2022/01/15
        \RequirePackage[]{newtxmath}			  % newtxmath still handles mathematics        
        \RequirePackage[no-math]{fontspec}
        \defaultfontfeatures{Ligatures=TeX,}
%        
	    \def\FontWarning{For luaLaTeX, you MUST have these OpenType fonts installed as system fonts on your computer: TeX Gyre Termes and TeX Gyre Heros (from \string http://www.gust.org.pl/projects/e-foundry/tex-gyre) and Inconsolatazi4 (\string https://ctan.org/tex-archive/fonts/inconsolata/opentype). If you DON'T have these fonts, you will see ERROR messages!}
%
	    \IfFontExistsTF{TeX Gyre Termes}{}{\ClassWarningNoLine{\ClassName}{\FontWarning} }
	    \IfFontExistsTF{texgyreheros}{}{   \ClassWarningNoLine{\ClassName}{\FontWarning} }
	    \IfFontExistsTF{Inconsolatazi4}{}{ \ClassWarningNoLine{\ClassName}{\FontWarning} }
%	    
		% The newtx package includes a modified version of TeXGyreTermes called TexGyreTermesX, which is loaded here.
		% Can fall back to TeXGyreTermes if desired, available at: http://www.gust.org.pl/projects/e-foundry/tex-gyre
        \setmainfont{TeXGyreTermesX}[
 			WordSpace = {1,1.6,1.2},%% This stretch matches newtxtext a little better; rescaled 2024/07/28
			PunctuationSpace = 1.332,%% match fontdimen7 to newtxtext, 2024/07/28
        	Extension = .otf,
        	UprightFont = *-Regular,
        	ItalicFont = *-Italic,
        	BoldFont = *-Bold,
        	BoldItalicFont = *-BoldItalic,
			Numbers = Lining,
			]
        \setsansfont{texgyreheros}[% Presumes these are system fonts! Available at: http://www.gust.org.pl/projects/e-foundry/tex-gyre
 			WordSpace = {1,1,1},% These spacings match newtxtext; rescaled to unity 2024/07/28
			Extension = .otf,
        	UprightFont = *-regular,
        	ItalicFont = *-italic,
        	BoldFont = *-bold,
        	BoldItalicFont = *-bolditalic,
			Numbers = Lining,
        	Scale=0.91,% same as for newtx; former value 0.9 too small 2022/01/15
			]        
       \setmonofont{Inconsolatazi4}[% This otf font ships with the LaTeX Inconsolata package (it's in TeX Live)
            Scale=1.05,% rescaled from 1, 22/03/10
            Extension = .otf,
            UprightFont = *-Regular,
            ItalicFont = *-Regular,% has no italic face
            BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
            RawFeature = {+ss01,\ssztwo,+ss03},
            \MonoNotMono,% match newtxtext if we enable wordspacing; note wordspace def'd in option above.
           ]          
%    
        % For many languages, using babel commands helps font loading. 
        % Switched Harbbuzz to OpenType throughout, 2024/07/28
        % Noto fonts are available at https://github.com/googlefonts
    	\def\Noto@scale{0.92}
	   	\def\Ara@scale{0.91}% For the serif font only
    	\def\NotoBan@scale{0.92}% 1.} should probably stay consistent within the Noto family.
    	\def\NotoDev@scale{0.92}% 1.} should probably stay consistent within the Noto family.
    	\def\NotoTam@scale{0.92}
		\def\Noto@color{Color=black}% 2024/07/28. Changed this diagnostic command to by-pass a bug in luatexja-fontspec.	
%
        \babelprovide[import, language=Default]{arabic}
        \babelfont [arabic]{rm}[Scale=\Ara@scale,
	 		 %Renderer=OpenType,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% don't use italic face, I am told
			 BoldFont = *-Bold,%
        	 BoldItalicFont = *-Bold,% don't use italic face, I am told
			 ]{Amiri}% NotoNaskhArabic}% Some readers prefer Amiri font
        \babelfont [arabic]{sf}[Scale=\Noto@scale,
	 		 %Renderer=OpenType,
             Extension =.ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% font has no italic face
			 BoldFont = *-SemiBold,% I'm told that legibility better than Bold
        	 BoldItalicFont = *-SemiBold,% font has no italic face
			 ]{NotoSansArabic}%DejaVuSans}%NotoKufiArabic}% .otf,%
        \babelfont [arabic]{tt}[%
	 		 %Renderer=OpenType,
             Extension =.ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-SemiBold,% I'm told that legibility is better than Bold
        	 BoldItalicFont = *-SemiBold,% has no italic face
			 ]{NotoSansArabic}%same as above!
        \providecommand\arabicabstractname{ملخص}% NB: utf-8
%
        \babelprovide[import,language=Default,script=Bangla]{bengali}
        \babelfont [bengali]{rm}[%
	 		 %Renderer=OpenType,
             Scale=\NotoBan@scale,% same as Devanagari
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
        ]{NotoSerifBengali}
        \babelfont [bengali]{sf}[%
	 		 %Renderer=OpenType,
             Scale=\NotoBan@scale,
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
        ]{NotoSansBengali}
        \babelfont [bengali]{tt}[
	 		 %Renderer=OpenType,
			 Scale=\NotoBan@scale,
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansBengali}		
%
        % Cyrillic languages
		\NewDocumentCommand\@LoadBabelCyr{>{\SplitList{;}}m}{\ProcessList{#1}{\@CyrillicBabel}}
		\NewDocumentCommand\@CyrillicBabel{m}{%
        	\babelprovide[import,language=Default,script=Cyrillic]{#1}
            \babelfont [#1]{rm}[%
            	Scale=\Noto@scale,
    			\Noto@color,
    			Extension = .ttf,
                UprightFont = *-Regular,
                ItalicFont = *-Italic,
                BoldFont = *-Bold, 
            	BoldItalicFont = *-BoldItalic,%
            ]{NotoSerif}
            \babelfont [#1]{sf}[%
            	Scale=\Noto@scale,
				\Noto@color,
   				Extension = .ttf,
                UprightFont = *-Regular,
                ItalicFont = *-Italic,
                BoldFont = *-Bold, 
            	BoldItalicFont = *-BoldItalic,%
			]{NotoSans}
            \babelfont [#1]{tt}[%
            	Scale=\Noto@scale,
				\Noto@color,
				Extension = .ttf,
				UprightFont = *-Regular,
    			ItalicFont = *-Regular,% has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
			]{NotoSansMono}
		}
		\@LoadBabelCyr{russian;belarusian;bulgarian;macedonian;serbian-cyrillic;ukrainian}% serbianc has no .ini under fontspec
		\setlocalecaption{serbian-cyrillic}{abstract}{Сажетак}% NB: utf-8
%
        % Devanagari languages
        \newfontscript{Devanagari}{deva}% OpenType has some problems in Hindi, see babel manual Sect. 1.13 (main issue is ra)
		\NewDocumentCommand\@LoadBabelDev{>{\SplitList{;}}m}{\ProcessList{#1}{\@DevBabel}}
		\NewDocumentCommand\@DevBabel{m}{%
        	\babelprovide[import,language=Default]{#1}
            \babelfont [#1]{rm}[%
%		 		 %Renderer=OpenType,% Marathi and Hindi may respond differently...
                 Scale=\NotoDev@scale,
                 \Noto@color,
                 Extension = .ttf,
    			 UprightFont = *-Regular,
    			 ItalicFont = *-Regular,% has no italic face
    			 BoldFont = *-Bold, 
            	 BoldItalicFont = *-Bold,% has no italic face
             ]{NotoSerifDevanagari}
            \babelfont [#1]{sf}[%
%		 		 %Renderer=OpenType,% % Marathi and Hindi may respond differently...
                 Scale=\NotoDev@scale,
                 \Noto@color,
                 Extension = .ttf,
    			 UprightFont = *-Regular,
    			 ItalicFont = *-Regular,% has no italic face
    			 BoldFont = *-Bold, 
            	 BoldItalicFont = *-Bold,% has no italic face
             ]{NotoSansDevanagari}
            \babelfont [#1]{tt}[
%		 		 %Renderer=OpenType,% % Marathi and Hindi may respond differently...
                 Scale=\NotoDev@scale,
                 \Noto@color,
                 Extension = .ttf,
    			 UprightFont = *-Regular,
    			 ItalicFont = *-Regular,% has no italic face
    			 BoldFont = *-Bold, 
            	 BoldItalicFont = *-Bold,% has no italic face
			 ]{NotoSansDevanagari}		
		}
		\@LoadBabelDev{hindi;marathi;kashmiri;nepali;sanskrit}
		% No .ldf files for these languages, but they do have .ini files. Nepali: no abstractname
%
		% Greek
		\babelprovide[import,language=Default]{greek}
        \babelfont [greek]{rm}[%
        	Scale=\Noto@scale,
			WordSpace={1.1},% increase word spacing slightly
			\Noto@color,
			Extension = .ttf,
            UprightFont = *-Regular,
            ItalicFont = *-Italic,
            BoldFont = *-Bold, 
        	BoldItalicFont = *-BoldItalic,%
		]{NotoSerif}
        \babelfont [greek]{sf}[%
        	Scale=\Noto@scale,
			WordSpace={1.1},% increase word spacing slightly
			\Noto@color,
			Extension = .ttf,
            UprightFont = *-Regular,
            ItalicFont = *-Italic,
            BoldFont = *-Bold, 
        	BoldItalicFont = *-BoldItalic,%
		]{NotoSans}
        \babelfont [greek]{tt}[%
            Scale=\Noto@scale,
			\Noto@color,
			Extension = .ttf,
			UprightFont = *-Regular,
    		ItalicFont = *-Regular,% has no italic face
    		BoldFont = *-Bold, 
            BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansMono}
%      
        % Japanese
        % luatexja-fontspec seems to want lc "color" now, rather than normal "Color", as before. Commenting out.
        % NB: luatexja-fontspec color breakage appears to be global.
        \ifac@japanese
            \def\Noto@color{}% by-pass bug in luatexja-fontspec, 2024/07/28.
        	\RequirePackage[no-math]{luatexja-fontspec}% japanese typesets *much* better with this loaded
            \setmainjfont{NotoSerifCJKjp}[%
            	Scale=\Noto@scale,
				\Noto@color,
%    			Extension = .otf,
    			UprightFont = *-Regular,
    			ItalicFont = *-Regular,% has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
			]
            \setsansjfont{NotoSansCJKjp}[%
            	Scale=\Noto@scale,
				\Noto@color,
%    			Extension = .ttc,
    			UprightFont = *-Regular,
    			ItalicFont = *-Regular,%  has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
			]
            \setmonojfont{NotoSansMonoCJKjp}[%
            	Scale=\Noto@scale,
				\Noto@color,	
    			UprightFont = *-Regular,
    			ItalicFont = *-Regular,%  has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
			]
            \ltjsetparameter{jacharrange={-1, -2, +3, -4, -5, +6, +7, +8}}% this prevents luatexja from breaking Russian and Greek.
            % see: https://tex.stackexchange.com/questions/222320/russian-in-document-with-japanese-as-main-language-lualatex-ltjsarticle
    		% Need at least one of the following to load the Japanese dictionary.
    		\babelfont [japanese]{rm}[%
    			Scale=\Noto@scale,
    			\Noto@color,
    			Extension = .otf,
    			UprightFont = *-Regular,
    			ItalicFont = *-Regular,% has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
    			]{NotoSerifCJKjp}% Scale estimated
        	\babelfont [japanese]{sf}[%
            	Scale=\Noto@scale,
    			\Noto@color,
 %   			Extension = .ttc,
    			UprightFont = *-Regular,
    			ItalicFont = *-Regular,%  has no italic face
    			BoldFont = *-Bold, 
            	BoldItalicFont = *-Bold,% has no italic face
			]{NotoSansCJKjp}
            \babelfont [japanese]{tt}[%
            	Scale=\Noto@scale,
				\Noto@color,
%				Extension = .ttc,
				UprightFont = *-Regular,
				ItalicFont = *-Regular,%  has no italic face
				BoldFont = *-Bold, 
        		BoldItalicFont = *-Bold,% has no italic face
			]{NotoSansMonoCJKjp}% renders same as Sans!
		\fi
		% Note: \japaneseabstractname is not defined if japanese is not called as a package option.
				
		% Korean
		\babelprovide[import,language=Default]{korean}
        \babelfont [korean]{rm}[%
        	Scale=\Noto@scale,
			\Noto@color,
			Extension = .otf,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
        ]{NotoSerifCJKkr}
        \babelfont [korean]{sf}[%
        	Scale=\Noto@scale,
			\Noto@color,
			Extension = .ttc,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansCJK}
        \babelfont [korean]{tt}[%
        	Scale=\Noto@scale,
			\Noto@color,
%			Extension = .ttc,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansMonoCJKkr}
        \renewcommand\koreanabstractname{초록}% NB: utf-8

		% Simplified Chinese
		\babelprovide[import,language=Default]{chinese-simplified}
        \babelfont [chinese-simplified]{rm}[%
        	Scale=\Noto@scale,
        	\Noto@color,
        	Extension = .otf,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSerifCJKsc}
        \babelfont [chinese-simplified]{sf}[%
        	Scale=\Noto@scale,
			\Noto@color,
			Extension = .ttc,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansCJK}
        \babelfont [chinese-simplified]{tt}[%
        	Scale=\Noto@scale,
			\Noto@color,
%			Extension = .ttc,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansMonoCJKsc}
%
		% Traditional Chinese (includes characters for Cantonese also)
		\babelprovide[import,language=Default]{chinese-traditional}
        \babelfont [chinese-traditional]{rm}[% fixed 2024/07/28
        	Scale=\Noto@scale,
        	\Noto@color,
        	Extension = .otf,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSerifCJKtc}
        \babelfont [chinese-traditional]{sf}[%
        	Scale=\Noto@scale,
			\Noto@color,
			Extension = .ttc,
			UprightFont = *-Regular,
			ItalicFont = *-Regular,%  has no italic face
			BoldFont = *-Bold, 
        	BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansCJK}
        \babelfont [chinese-traditional]{tt}[Scale=\Noto@scale,\Noto@color]{NotoSansMonoCJKtc}
%
        \babelprovide[import,language=Default]{tamil}
        \babelfont [tamil]{rm}[%
	 		 %Renderer=OpenType,
             Scale=\NotoTam@scale,
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
        ]{NotoSerifTamil}
        \babelfont [tamil]{sf}[%
	 		 %Renderer=OpenType,
             Scale=\NotoTam@scale,
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
        ]{NotoSansTamil}
        \babelfont [tamil]{tt}[
	 		 %Renderer=OpenType,
			 Scale=\NotoTam@scale,
             \Noto@color,
             Extension = .ttf,
			 UprightFont = *-Regular,
			 ItalicFont = *-Regular,% has no italic face
			 BoldFont = *-Bold, 
        	 BoldItalicFont = *-Bold,% has no italic face
		]{NotoSansTamil}		
%
	    \babelprovide[import, captions/abstract = Muhtasari, language = Default]{swahili}
%	
   \else % use lualatex without support for system fonts (easier set-up and still enables luacode for numerics)
    	 % dropped newtxtext completely, 2024/01/19
		\renewcommand*\rmdefault{ntxtlf}          % roman font for math
		\RequirePackage[T1]{fontenc} 			  % qhv and zi4 are not TU encoded, 2021/12/24
			\DeclareFontFamily{T1}{\sfdefault}{}  % sf for math
	    	\DeclareFontShape{T1}{\sfdefault}{m}{n}{<-> s*[0.94] ec-qhvr}{} %% see t1qhv.fd; 0.9-->0.94 2022/01/15
	    	\DeclareFontShape{T1}{\sfdefault}{b}{n}{<-> s*[0.94] ec-qhvb}{} %% see t1qhv.fd; 0.9-->0.94 2022/01/15
	    	\DeclareFontShape{T1}{\sfdefault}{bx}{n}{<-> s*[0.94] ec-qhvb}{} %% see t1qhv.fd; 0.9-->0.94 2022/01/15
	    	\DeclareFontFamily{T1}{zi4}{}% typewriter (Inconsolata)
	    	\DeclareFontShape{T1}{zi4}{m}{n}{<-> s*[1.05] t1-zi4r-5}{}% with options varl and var qu
	    	\DeclareFontShape{T1}{zi4}{b}{n}{<-> s*[1.05] t1-zi4b-5}{} 
	    	\DeclareFontShape{T1}{zi4}{bx}{n}{<-> s*[1.05] t1-zi4b-5}{} 
		\RequirePackage[]{newtxmath} % options will be as passed from newtx
		\providecommand*{\DeclareFontFamilySubstitution}[3]{\relax}% folks with old latex formats will get a different typewriter font...
		\AtBeginDocument{%
			\DeclareFontFamilySubstitution{T1}{\ttdefault}{zi4}
		}
   \fi
\fi

\RequirePackage[]{mathalfa}% load optional fonts for Calligraphy, Script, Fraktur. Key format: mathalfa=cal=euler (etc.)
\RequirePackage{bm}%   		 load after all math to give further access to bold math


% To free \eqref from the normal font (e.g., for use in section headings or captions). Revised 2024/07/28
\renewcommand{\eqref}[1]{\textup{\hbox{\m@th{(\ignorespaces\ref{#1}\unskip\@@italiccorr)}}}}
%
% amsmath def:  \newcommand{\eqref}[1]{\textup{\tagform@{\ref{#1}}}}
%				\def\tagform@#1{\maketag@@@{(\ignorespaces#1\unskip\@@italiccorr)}}
%				\def\maketag@@@#1{\hbox{\m@th\normalfont#1}}


% The article class calls \sloppy in two-column mode (\tolerance 9999, \emergencystretch 3em)
% The following adjustments affect line breaking; the values below are intended to produce
% fewer lines with large spaces, without creating the problems of using \fussy in two-column mode.
\tolerance 2500
\emergencystretch 3em 

\RequirePackage{hologo}% Access various LaTeX logos if needed. Dropped metalogo, 2024/08/09.

%% font size selection  
%% ASME's specs differ slightly from latex standard article-10 class 

\renewcommand\LARGE{\@setfontsize\LARGE{16}{19.2}}              %{18}{21.6}}  updated 2019/7/7 to match new ASME spec.  
                                                                % ...default is 17.28/22 ... used for paper#
\renewcommand\large{\@setfontsize\large{11}{13.6}}              % default is 12/14 ... used for headings

%\renewcommand\Large{\@setfontsize\Large{14.4}{18}}             % same as default
%\renewcommand\normalsize{\@setfontsize\normalsize{10}{12}}     % same as default
%\renewcommand\small{\@setfontsize\small{9}{11}}                % same as default
%\renewcommand\footnotesize{\@setfontsize\footnotesize{8}{9.5}} % same as default


%% This provides sans-serif italic and sans-serif bold italic math.
%% These fonts are for use in the figure captions and section headings. 
%% Use \mathbf{..}, \mathversion{bold}, or \bm{..} elsewhere.
\DeclareMathVersion{sansbold}
\SetSymbolFont{letters}{sansbold}{OML}{ntxsfmi}{b}{it}
\SetSymbolFont{lettersA}{sansbold}{U}{ntxsfmia}{b}{it}
\IfFormatAtLeastTF{2016/01/05}{%
	\SetSymbolFont{symbols}{sansbold}{LMS}{ntxsy}{b}{n}
	}{\relax}
\SetSymbolFont{largesymbols}{sansbold}{LMX}{ntxexx}{b}{n}%  added 25 Jan 2021
\SetSymbolFont{largesymbolsTXA}{sansbold}{U}{ntxexa}{b}{n}% added 25 Jan 2021
\SetSymbolFont{operators}{sansbold}{\encodingdefault}{\sfdefault}{\bfdefault}{n}
\SetMathAlphabet{\mathsf}{sansbold}{\encodingdefault}{\sfdefault}{b}{n}% changed from it, 2021/01/31: \mathsf is upright.

%% Added 2023/10/19
\DeclareMathVersion{sans}
\SetSymbolFont{letters}{sans}{OML}{ntxsfmi}{m}{it}
\SetSymbolFont{lettersA}{sans}{U}{ntxsfmia}{m}{it}
\IfFormatAtLeastTF{2016/01/05}{%
	\SetSymbolFont{symbols}{sans}{LMS}{ntxsy}{m}{n}
	}{\relax}
\SetSymbolFont{largesymbols}{sans}{LMX}{ntxexx}{m}{n}
\SetSymbolFont{largesymbolsTXA}{sans}{U}{ntxexa}{m}{n}
\SetSymbolFont{operators}{sans}{\encodingdefault}{\sfdefault}{\rmdefault}{n}
\SetMathAlphabet{\mathsf}{sans}{\encodingdefault}{\sfdefault}{m}{n}% \mathsf is upright.


%% Nice solution from DPC to prevent aux file errors (due to active characters from babel) when switching from pdflatex to lualatex.  Disabled, 2024/07/28
%\ifx\directlua\undefined
%	\AtBeginDocument{\immediate\write\@auxout{\detokenize{%
%	 \ifx\directlua\undefined\else\endinput\fi}}}
%\fi


%%%%%%%%  Footers and Footnotes  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\AtBeginDocument{\edef\@EncodingMain{\encodingdefault}}
\NewDocumentCommand\@SetFont{}{\fontencoding\@EncodingMain\selectfont}

\fancyfoot{}
\fancyhead{}
\fancyfoot[CE,CO]{\@SetFont\thepage}% force encoding so that passages in some languages won't switch footer font from the main font.
\fancyfoot[RO,RE]{\@SetFont Copyright~\textcopyright~\the\year\ by ASME}
\renewcommand{\headrulewidth}{0pt} 
\renewcommand{\footrulewidth}{0pt}

\ifasmeconf@govt
	\newgeometry{left=0.5in, right=0.5in, top=0.5in, bottom = 1.in, footskip = 0.3in, columnsep = 0.38in}
	\fancyfoot[RO,RE]{}
	\fancyfoot[CE,CO]{\@SetFont\thepage\\[1ex]\small This material is declared a work of the U.\ S.~Government and is not subject to copyright protection in the United States.\\Approved for public release; distribution is unlimited.}
\fi

\ifasmeconf@contractor
	\newgeometry{left=0.5in, right=0.5in, top=0.5in, bottom = 1.in, footskip = 0.3in, columnsep = 0.38in}
	\fancyfoot[RO,RE]{}
	\fancyfoot[CE,CO]{\@SetFont\thepage\\[1ex]\footnotesize The United States Government retains, and by accepting the article for publication, the publisher acknowledges that the United States Government retains, a non-exclusive, paid-up, irrevocable, worldwide license to publish or reproduce the published form of this work, or allow others to do so, for United States Government purposes.}
\fi

\ifasmeconf@govtsome
	\newgeometry{left=0.5in, right=0.5in, top=0.5in, bottom = 1.in, footskip = 0.3in, columnsep = 0.38in}
	\fancyfoot[RO,RE]{}
	\fancyfoot[CE,CO]{\@SetFont\thepage\\[1ex]\small This work was authored in part by a U.\ S.\ Government employee in the scope of his/her employment. ASME disclaims all interest in the U.\ S.\ Government's contribution.}
\fi

\ifasmeconf@nofoot
		\fancyfoot[RO,RE]{}
\fi

%%%%%% Footnotes %%%%%%%

\RequirePackage{footmisc}%
\IfPackageAtLeastTF{footmisc}{2022/02/05}{
	 	\PassOptionsToPackage{belowfloats}{footmisc}%
	}{	\RequirePackage{fnpos}% this package is not loaded if footmisc is up to date.
		\makeFNbottom
		\makeFNbelow
	}%
\setlength\footnotemargin{2ex}% reduce indentation of footnotes, from footmisc
\setlength{\skip\footins}{\baselineskip}% <=== per ASME, 1 extra line

\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width 0.5in height 0.4pt
  \kern 2pt
}
    
%% include a comma for sequential footnotes. 2024/01/18
\ExplSyntaxOn
	\cs_new:Npn   \__asmeconf_NoteComma:n { \peek_meaning:NT \footnote { \textsuperscript{\mdseries,} } }
	\cs_new_eq:NN \__asmeconf_savefootnote \footnote
	\cs_gset_protected:Npn \footnote #1    { \__asmeconf_savefootnote{#1} \__asmeconf_NoteComma:n } 
\ExplSyntaxOff


%%%%%%%%%  Section headings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ASME specifies 10 pt headings

%% This approach is intended to avoid breaking tagging code, 2025/01/29
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {12pt \@plus 4pt \@minus 2pt}%
                                   {1pt \@plus 2pt \@minus 2pt}%
                                   {\mathversion{sansbold}\bfseries\sffamily\raggedright\MakeUppercase}}
\renewcommand\subsection{\@startsection {subsection}{1}{\z@}%
                                   {12pt \@plus 4pt \@minus 2pt}%
                                   {1pt \@plus 1pt \@minus 1pt}%
                                   {\mathversion{sansbold}\normalsize\bfseries\sffamily\raggedright}}
\renewcommand\subsubsection{\@startsection {subsubsection}{1}{\parindent}%
                                   {6pt \@plus 3pt \@minus 2pt}%
                                   {-0.5em}%
                                   {\mathversion{sansbold}\bfseries\normalsize\sffamily}}
\patchcmd{\thesection}{\@arabic\c@section}{\@arabic\c@section}{}{}
\patchcmd{\thesubsection}{\thesection.\@arabic\c@subsection}{\@arabic\c@section.\@arabic\c@subsection}{}{}
\patchcmd{\@seccntformat}{\quad}{.\hspace{0.5em}}{}{}
\patchcmd{\@ssect}{\relax #5}{\relax #5.}{}{}% only \subsubsection* will follow this path
\let\paragraph\subsubsection

\renewcommand{\appendix}{
    \par
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \gdef\thesection{\@Alph\c@section}
    \gdef\thesubsection{\@Alph\c@section.\@arabic\c@subsection}
    \pretocmd{\section}{\gdef\@seccntformat##1{\appendixname\ \csname the##1\endcsname.\hspace{0.5em}}}{}{}
    \let\savhangfrom\@hangfrom
    \pretocmd{\section}{\gdef\@hangfrom{\relax}}{}{}
    \pretocmd{\subsection}{\gdef\@seccntformat##1{\csname the##1\endcsname.\hspace{0.5em}}}{}{}
    \pretocmd{\subsection}{\gdef\@hangfrom{\savhangfrom}}{}{}
    \patchcmd{\@kernel@tag@hangfrom}{\hangindent \wd\@tempboxa\noindent}{\noindent}{}{}
}
%% still need to zero out \hangfrom in appendix \section when tagging is active. 


%%%%%%%%%%  Hyperref, bookmarks, and PDF/A  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifpdftex
    %%% to assist with unicode glyph mapping, following M. Sharpe's recommendation in the newtx documentation. 
    %%% as of 2024/07/28, these are still necessary with \DocumentMetadata{pdfstandard=A-3u}. Note: glyphtounicode-cmex.tex is now in latex-lab.
    \InputIfFileExists{glyphtounicode-cmr.tex}{}{} 	%% additional mappings
    \InputIfFileExists{glyphtounicode-ntx.tex}{}{} 	%% additional mappings
    
    \ifac@setpdfa
    %% new pdf management in LaTeX, with \DocumentMetaData{..}, is preferred to this *legacy* approach.
        \ifasme@pdfmanagement
        	\ClassInfo{\ClassName}{pdfmanagement is defined. Class file will not load a color profile}
        \else
        	\ClassInfo{\ClassName}{NOTE: pdfmanagement not defined. Class file will load a color profile}%
            %%% a fairly generic RGB color profile, aimed at on-screen rendering (not print production)
            	\immediate\pdfobj stream attr{/N 3} file{sRGB.icc}
            	\pdfcatalog{%
            	   /OutputIntents [
            	    <<
            	      /Type /OutputIntent
            	      /S /GTS_PDFA1
            	      /DestOutputProfile \the\pdflastobj\space 0 R
            	      /OutputConditionIdentifier (sRGB)
            	      /Info (sRGB)
            	    >>
            	   ]
            	 }%
        \fi
    \fi
\fi

\RequirePackage[psdextra]{hyperref} % recent kernel transition suggests providing most hyperref options via \hypersetup, 
									% but setting psdextra here (for additional math support in bookmarks) 2021/12/01
\hypersetup{%
	pdfborder={0 0 0},% 
	bookmarksnumbered=true,%
	bookmarksopen=true,
	bookmarksopenlevel=1,%
	linkcolor=blue, %
	citecolor=blue, % 
	urlcolor=blue,  %
	filecolor=red,  % added 2021/12/02, to make certain broken links more apparent
	pdfnewwindow=true,%
	pdfpagelayout=SinglePage, %TwoPageRight,% changed this 2020/12/08
	pdfdisplaydoctitle=true%
%	colorlinks=true,% <=== set true to get colored type, but do so via package options in .tex file
}
	
\urlstyle{same}     		  % don't switch to typewriter font for urls
\RequirePackage{doi}          % supports the nasty characters in some doi's
\renewcommand{\doitext}{DOI } % change to this from default value, {doi:}, per ASME specification

\providecommand*{\toclevel@subfigure}{1}% <== to address unknown bookmark level of subfigure. 2021/12/24

\ifasme@pdfmanagement
	\ClassInfo{asmejour}{pdfmanagement is defined. Class file will not load hyperxmp and bookmark packages}
\else
	\providecommand\hrefurl[2]{\href{#1}{#2}}% to address certain issues around URL recognition with new pdf management code, 2021/12/02
    \RequirePackage{bookmark}% improves handling of pdf bookmarks
    \RequirePackage{hyperxmp}% improve transfer of metadata to pdf 
    
    % Patch bug in hyperxmp, unless a more recent version is used.
    \ifdefined\hyxmp@no@bad@parts% \hyxmp@no@bad@parts is not def'd in TeX Live 2019 or older
        \IfPackageAtLeastTF{hyperxmp}{2022/10/15}{% v5.11 or later
            \relax
        	}{%
            \newcount\hypxmp@tempcnt
            \define@key{Hyp}{pdfapart}{%
              \afterassignment\hyxmp@no@bad@parts\hypxmp@tempcnt=0#1\relax
              \hyxmp@pdfstringdef\@pdfapart{\the\hypxmp@tempcnt}%
            }
        }
    \fi
\fi

%%% ==> recent development of \pdfstring removes all robust commands from bookmarks, so that
%%%     by early 2024, errors are not present; these commands serve to still suppress warnings, however.

%% Since \bm may be useful in headings, this fix will reduce frequency with which
%%    alternate pdfstrings must be given in revised section command as \section[pdfstring]{texstring}
\pdfstringdefDisableCommands{%
    \def\bm#1#{\relax}%
}

% Let's disable \( and \) in pdf bookmarks, 2020/02/28
\pdfstringdefDisableCommands{%
    \def\({\relax}%
    \def\){\relax}%
}

% Let's also make sure \NoCaseChange in section headings won't break pdf bookmarks
\pdfstringdefDisableCommands{%
      \let\NoCaseChange\relax%
}

% Let's just remove citations from pdf bookmarks
\pdfstringdefDisableCommands{%
    \def\cite{\@gobble}%
}

%% Ensure that tag color does not follow \eqref into bookmarks, 2020/02/28
\pdfstringdefDisableCommands{%
    \def\eqref#1{(\ref*{#1})}% \ref* is from hyperref
}

% Let's make sure footnotes in section headings don't break pdf bookmarks.
% Revised footnote command above is already robust
\pdfstringdefDisableCommands{%
  \def\footnote#1{}%
}


%% Let's also add \footnote to the \TextUppercase exception list, so that footnote text won't be capitalized
%% if given in section headings. Ditto for \eqref
%
\ifx\AddToNoCaseChangeList\@undefined % updated 2022/07/03, see https://github.com/John02139/asmeconf/issues/5 
	\patchcmd{\@uclcnotmath}{\@nonchangecase\ref}{\@nonchangecase\ref\@nonchangecase\footnote}{\typeout{Asmeconf patched textcase nonchangecase to include footnote.}}{}
	\patchcmd{\@uclcnotmath}{\@nonchangecase\ref}{\@nonchangecase\ref\@nonchangecase\eqref}{\typeout{Asmeconf patched textcase nonchangecase to include eqref.}}{} %% corrected 2020/01/24
\else
    \AddToNoCaseChangeList{\eqref \footnote}
\fi

%%% There should be no errors for section headings with \(, \), \cite, \ref, \eqref, \label, \footnote, \NoCaseChange, or \bm 


%%%%%%%%%%%%%  Line numbering and balancing columns on last page  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Adjustments when lineno option is used
\ifasmeconf@lineno%
    \RequirePackage[switch,mathlines]{lineno}    
    \renewcommand{\linenumberfont}{\normalfont\footnotesize\color{red}} 
    \AtBeginDocument{\linenumbers}
    \ifasmeconf@balance
		\ClassWarningNoLine{\ClassName}{Package lineno loaded, so final column balancing will be disabled}%
	\fi
	%%% Patch to allow line numbering in AMS math environments.
	%%% This patch is for lineno versions earlier than v5.2 [2023/05/19]. As of mid-2023, the lineno package
	%%% 	has been corrected to account for the AMS math environments.  Retaining for backward compatibility.
	%%% postdisplaypenalty adjusted to avoid extra line number at end, see: https://tex.stackexchange.com/a/461192/ 
	\IfPackageAtLeastTF{lineno}{2023/05/19}{\relax}{
    	\NewDocumentCommand{\ac@losepostpenalty}{}{\patchcmd{\linenomathWithnumbers}{\advance\postdisplaypenalty\linenopenalty}{}{}{}}
    	%
        \NewDocumentCommand{\ac@FixAMSMath}{m}{%
        	\AtBeginEnvironment{#1}{\ac@losepostpenalty\linenomath}%
        	\AtEndEnvironment{#1}{\endlinenomath}%
        	\AtBeginEnvironment{#1*}{\ac@losepostpenalty\linenomath}%
        	\AtEndEnvironment{#1*}{\endlinenomath}%
        }
    	%
    	\NewDocumentCommand{\ac@FixAll}{>{\SplitList{;}}m}{\ProcessList{#1}{\ac@FixAMSMath}}
    	%
    	\ac@FixAll{align;alignat;gather;flalign;multline}
	}
\else
    \ProvideDocumentEnvironment{linenomath}{}{}{}%
    \ifasmeconf@balance
    	\RequirePackage{flushend}%    flushend package is NOT compatible with lineno
    	\AtEndDocument{\flushcolsend}%
		\ClassNoteNoLine{\ClassName}{Calling flushend package to balance column height on last page}%
    \fi%
\fi
\providecommand{\@LN@col}[1]{\relax}% Enable dropping lineno option without trashing .aux file
\providecommand{\@LN}[2]{\relax}


%%%%%%%%%%%%%  Define special environments  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExplSyntaxOn
%% In case tagging is not loaded, 2025/01/26
\cs_if_exist:NF \tag_struct_begin:n
	{ 
	  \cs_new:Npn \tag_struct_begin:n #1 { \scan_stop: } 
	  \cs_new:Nn  \tag_struct_end:       { \scan_stop: } 
	  \cs_new:Nn  \tagpdfparaOff         { \scan_stop: }
	  \cs_new:Nn  \tagpdfparaOn          { \scan_stop: }
	}
\ExplSyntaxOff

%%%%%% Introduce some special section and other names %%%%%%%%%%%

\providecommand{\nomname}{Nomenclature}  
\providecommand{\keywordname}{Keywords}
\providecommand{\appendicesname}{APPENDICES}
\providecommand{\JAwords}{Joint first authors}
\providecommand{\CAwords}{Corresponding author}

%%   Abstract environment  %%%%%%%%%%%%%%%%%%
%%   \keywords command should be given someplace before the \end{abstract} command.

\providecommand{\@keywords}{\relax}

% \ifblank is from etoolbox
\NewDocumentCommand{\keywords}{m}{%
	\ifblank{#1}{\def\@keywords{\relax}}{
	    \long\def\@keywords{\par\smallskip\noindent{\bfseries\sffamily \keywordname: #1}}%
	}
}

\ExplSyntaxOn
\DeclareDocumentEnvironment{abstract}{+b}{% Overwrites existing abstract environment
%    \tag_struct_begin:n{tag=Sect, title-o=\abstractname}
	\section*{\abstractname}\itshape
	#1
	}
	{
		\upshape\@keywords 
%		\par\tag_struct_end:n
		\ignorespacesafterend
	}
\NewDocumentEnvironment{abstract*}{}{% Abstract with no keywords (same as using empty \keywords{} with first abstract)
%    \tag_struct_begin:n{tag=Sect, title-o=\abstractname}
	\section*{\abstractname}\itshape
	}
	{
%	\par\tag_struct_end:n
	\ignorespacesafterend
	}
\ExplSyntaxOff

%%   Nomenclature environment  %%%%%%%%%%%%%%%%%%
%%

\newlength\nomenwidth
\newlength\savitemsep

\NewDocumentCommand\entry{m m}{% simplified greatly 2024/01/18
             \item[#1\hfill]#2%
             \@itempenalty=-\@lowpenalty
}

%% A separate command command for nomenclature subheadings 
\NewDocumentCommand\EntryHeading{m}{%
	\itemsep3\p@ plus 1\p@ minus 1\p@
    \goodbreak\item[\itshape#1\hfill]\mbox{}%
    \setlength{\itemsep}{\savitemsep}\@itempenalty=1000
}

%%   Increase first optional argument to a dimension > 2em if wide entries cause undesired misalignment of columns. 
%%   Second optional argument can be used to rename the environment, e.g., to List of Symbols.
\ExplSyntaxOn
\NewDocumentEnvironment{nomenclature}{O{2em} O{\nomname}}{%
 %       \tag_struct_begin:n{tag=Sect, title-o=\nomname}
		\setlength{\columnsep}{2em} 
        \setlength{\nomenwidth}{#1}
        \section*{#2}
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
}{\end{list}
%  \tag_struct_end:
  \ignorespacesafterend
}
\ExplSyntaxOff

%%%%%%%%%%%%%%%%%  Headers and Title  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand\ConfName{m}{\long\gdef\@ConfName{#1}}
\providecommand\@ConfName{\hbox{ }}

\NewDocumentCommand\ConfAcronym{m}{\gdef\@ConfAcronym{#1}}
\providecommand\@ConfAcronym{\hbox{ }}

\NewDocumentCommand\ConfDate{m}{\gdef\@ConfDate{#1,\space}}
\providecommand\@ConfDate{\space}

\NewDocumentCommand\ConfCity{m}{\gdef\@ConfCity{#1}}
\providecommand\@ConfCity{\hbox{ }}

\NewDocumentCommand\PaperNo{m}{\gdef\@PaperNo{#1}}
\providecommand\@PaperNo{\protect\phantom{NO.}}

\NewDocumentCommand\PaperTitle{m}{%
	\gdef\@PaperTitle{#1}%
	\gdef\@title{#1}% added 2024/07/28
}
\providecommand\@PaperTitle{\hbox{ }}

\ExplSyntaxOn
\NewDocumentCommand\@HeaderTitle{}{%
	\tag_struct_begin:n{tag=Div, title=Conference~information}
	{\bfseries\sffamily
	\parbox{\linewidth}{%
		\raggedleft
		\@ConfName\par%
		\MakeTextUppercase{\@ConfAcronym}\par
		\@ConfDate\@ConfCity
    }%
    \par\tag_struct_end:
	\vspace*{2\baselineskip}
	\tag_struct_begin:n{tag=Div, title=Paper~number}
	\parbox{\linewidth}{\raggedleft\LARGE
		\MakeTextUppercase{\@PaperNo}%
    }%
    \par\tag_struct_end:
	\vspace*{3\baselineskip}
	\tag_struct_begin:n{tag=Title}
	\parbox{\linewidth}{\mathversion{sansbold}\centering{\large
		\MakeTextUppercase{\@PaperTitle}\par}}%%% <=== extra \par to make font leading stick. See adjustment in \MakeTitle
    \tag_struct_end:
    }%
}
\ExplSyntaxOff

%%%%%%%%%%%   Author and affiliation block  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inline author style resets the footnote mark; save the definitions so we can restore them later
\let\savethefootnote\thefootnote
\let\savemakefnmark\@makefnmark

%% Flag for joint first authors (two or more)
\newif\ifac@JA\ac@JAfalse

\NewDocumentCommand{\JointFirstAuthor}{}{%
	\global\ac@JAtrue%
  	$\bm{^\dagger}$%
}
%% Flag for corresponding author (expecting just one, but if two enter both email addresses and flag both authors)
\newif\ifac@CA\ac@CAfalse

\NewDocumentCommand\CorrespondingAuthor{>{\TrimSpaces} m}{% Revised 2020/12/29 (make CA email mandatory but possibly empty); edit 2025/01/27
   \global\ac@CAtrue%
   \IfBlankTF{#1}{%
         \gdef\@CAsep{\relax}%
         \gdef\@CAemail{\relax}%
         }{%
         \gdef\@CAsep{:\space}%
         \gdef\@CAemail{#1}%
   }%
   $\bm{^\ast}$\ignorespaces % \ignorespaces is ignored due to code for commas in successive footnotes, below.
}

%%%% option to use the traditional grid layout of authors or the inline style

\ifasmeconf@grid
	\ClassNoteNoLine{\ClassName}{Selected option for a grid of author blocks}%
    
    %%%%%%%%%%%%%%%%%%%%  Gridded author layout  %%%%%%%%%%%%%%%%%%%%%%%%%
	%%
	%% converted to expl3 18 August 2024

	\ExplSyntaxOn

    %% Allows for up to fifteen author blocks.
    \coffin_new:N \g__asmeconf_authorblock_coffin
    \coffin_new:N \g__asmeconf_firstrowauthorblock_coffin
    \coffin_new:N \g__asmeconf_secondrowauthorblock_coffin
    \coffin_new:N \g__asmeconf_thirdrowauthorblock_coffin
    \coffin_new:N \g__asmeconf_fourthrowauthorblock_coffin
    \coffin_new:N \g__asmeconf_fifthrowauthorblock_coffin

	\dim_new:N    \g__asmeconf_coffinsep_dim 
	\dim_gset:Nn  \g__asmeconf_coffinsep_dim { 0.03\textwidth }

	\dim_new:N    \g__asmeconf_authorblockwidth_dim 
	\dim_gset:Nn  \g__asmeconf_authorblockwidth_dim { 0.3\textwidth }

	\seq_new:N    \g__asmeconf_author_seq
	\seq_new:N    \g__asmeconf_authoraffil_seq
	\seq_new:N    \g__asmeconf_affiliation_seq


    \int_gzero_new:N  \g__asmeconf_authorcnt_int
    
    \NewDocumentCommand\SetAuthors{>{\SplitList{,}}m}{
    	\ProcessList{#1}{ \__asmeconf_author:n }
		}
	\cs_new_protected:Nn \__asmeconf_author:n
     {
    	\int_gincr:N        \g__asmeconf_authorcnt_int
    	\tl_if_empty:nT {#1} { 
			\msg_warning:nn { \ClassName } { missingauthor } 
    	}
		\seq_gput_right:Nn  \g__asmeconf_author_seq      {#1}
		\__asmeconf_stripaffilnumber:n { #1 }
		\seq_gput_right:Nn  \g__asmeconf_affiliation_seq { \c_empty_tl } % clear sequence for later use	
		\seq_gput_right:NV  \g__asmeconf_authoraffil_seq { \int_use:N \g__affiltagno_int }	
	 }
	\msg_new:nnn { \ClassName } { missingauthor } { Missing~author~name,~check~for~extra~comma~in~\SetAuthors! }

	%% The following captures the affiliation tag number from the \SetAuthors command.
	%% It would be simpler to replace \affil{#} by an additional _argument_ in \SetAuthors; 
	%%    however, legacy syntax seem pretty locked in...
    \int_gzero_new:N \g__affiltagno_int
    \cs_new_protected:Nn \__asmeconf_stripaffilnumber:n
      {
	    \int_zero_new:N \l__asmeconf_affil_flag_int
        \tl_set:Nn \l_tmpa_tl { #1 }
        \tl_map_inline:Nn \l_tmpa_tl
          {
          \int_if_zero:nTF { \l__asmeconf_affil_flag_int } 
            {
            \tl_if_eq:nnT { ##1 } { \affil } { \int_incr:N \l__asmeconf_affil_flag_int  }
            }{
              \tl_map_break:n { 
                \tl_if_empty:nTF { ##1 }
                { 
                \msg_error:nn { \ClassName } { missingaffilno } 
                }{
                  	\int_gset:Nn \g__affiltagno_int { ##1 } \int_set:Nn \l__asmeconf_affil_flag_int {0} 
                }
              }
            }
          }
      }
    \NewDocumentCommand\affil{m}{}
	\msg_new:nnn { \ClassName } { missingaffilno } { Missing~number~in~\affil~tag! }
      
    \NewDocumentCommand\SetAffiliation{mm}{
    	\__asmeconf_affiliation:nn {#1}{#2}
		}
	\cs_new_protected:Nn \__asmeconf_affiliation:nn
    	{
 		\seq_gset_item:Nnn  \g__asmeconf_affiliation_seq {#1} {#2}
    	}
    
    \NewDocumentCommand\@SetAuthorBlock{}{%
    	\int_zero_new:N \l__asmeconf_authorno_int
		\int_zero_new:N \l__asmeconf_authoraffilno_int
	    \tl_clear:N     \l_tmpa_tl
		\int_while_do:nNnn { \l__asmeconf_authorno_int } < { \g__asmeconf_authorcnt_int } { % starting with authorno = 0 ensures we reach authorcnt with +1
			\int_incr:N \l__asmeconf_authorno_int
            \centering\vcoffin_gset:Nnn \g__asmeconf_authorblock_coffin { \dim_use:N \g__asmeconf_authorblockwidth_dim } {
            	\sffamily
            	\textbf{ \seq_item:Nn \g__asmeconf_author_seq { \l__asmeconf_authorno_int }} \\
					\int_set:Nn \l__asmeconf_authoraffilno_int { \seq_item:Nn  \g__asmeconf_authoraffil_seq  { \l__asmeconf_authorno_int } }
					\tl_set:Nn  \l_tmpa_tl { \seq_item:Nn \g__asmeconf_affiliation_seq { \l__asmeconf_authoraffilno_int } }  
					\tl_if_empty:NTF \l_tmpa_tl
						{ \msg_warning:nnV { \ClassName } { missingaffiliation } { \l__asmeconf_authorno_int } 
						}{
						\l_tmpa_tl
						}
        			\par
			}
			\int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 1 } {
				\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { r } { t } 
					\g__asmeconf_authorblock_coffin { l } { t } { 0pt} { 0pt } 
				}
				{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 2 }  {
					\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { r } { t } 
						\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                	}
                 	{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 3 }  {
						\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { r } { t } 
							\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                  		}
            			{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 4 } {
            				\coffin_gjoin:NnnNnnnn \g__asmeconf_secondrowauthorblock_coffin { r } { t } 
            					\g__asmeconf_authorblock_coffin { l } { t } { 0pt} { 0pt } 
            				}
            				{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 5 } {
            					\coffin_gjoin:NnnNnnnn \g__asmeconf_secondrowauthorblock_coffin { r } { t } 
            						\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
            					}
            					{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 6 } {
            						\coffin_gjoin:NnnNnnnn \g__asmeconf_secondrowauthorblock_coffin { r } { t } 
            							\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
            						}
                        			{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 7 } {
                        				\coffin_gjoin:NnnNnnnn \g__asmeconf_thirdrowauthorblock_coffin { r } { t } 
                        					\g__asmeconf_authorblock_coffin { l } { t } { 0pt} { 0pt } 
                        				}
                        				{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 8 } {
                        					\coffin_gjoin:NnnNnnnn \g__asmeconf_thirdrowauthorblock_coffin { r } { t } 
                        						\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                        					}
                        					{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 9 } {
                        						\coffin_gjoin:NnnNnnnn \g__asmeconf_thirdrowauthorblock_coffin { r } { t } 
                        							\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                        						}
                                				{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 10 } {
                                					\coffin_gjoin:NnnNnnnn \g__asmeconf_fourthrowauthorblock_coffin { r } { t } 
                                						\g__asmeconf_authorblock_coffin { l } { t } { 0pt} { 0pt } 
                                					}
                                					{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 11 } {
                                						\coffin_gjoin:NnnNnnnn \g__asmeconf_fourthrowauthorblock_coffin { r } { t } 
                                							\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                                						}
                                						{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 12 } {
                                							\coffin_gjoin:NnnNnnnn \g__asmeconf_fourthrowauthorblock_coffin { r } { t } 
                                								\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                                							}
                                                			{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 13 } {
                                                				\coffin_gjoin:NnnNnnnn \g__asmeconf_fifthrowauthorblock_coffin { r } { t } 
                                                					\g__asmeconf_authorblock_coffin { l } { t } { 0pt} { 0pt } 
                                                				}
                                                				{ \int_compare:nNnTF { \l__asmeconf_authorno_int } =  { 14 } {
                                                					\coffin_gjoin:NnnNnnnn \g__asmeconf_fifthrowauthorblock_coffin { r } { t } 
                                                						\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                                                					}
                                                					{ \int_compare:nNnT { \l__asmeconf_authorno_int } =  { 15 } {
                                                						\coffin_gjoin:NnnNnnnn \g__asmeconf_fifthrowauthorblock_coffin { r } { t } 
                                                							\g__asmeconf_authorblock_coffin { l } { t } { \dim_use:N \g__asmeconf_coffinsep_dim } { 0pt } 
                                                					}
                                                				}
                                                			}
                                						}
                                					}
                        						}
                        					}
										}
            						}
            					}
							}
						}
					}
				}
			}
			\int_compare:nNnT { \l__asmeconf_authorno_int } >  { 15 } {
				\msg_error:nn { \ClassName } { toomanyforgrid }
    		}
    	}% end loop
	}
	\msg_new:nnnn { \ClassName } { missingaffiliation } { Missing~affiliation~for~author~no.~#1! } {#1}
	\msg_new:nnnn { \ClassName } { toomanyforgrid }     { The~class~is~programmed~for~a~maximum~of~15~author~blocks.} 
			{ For~authors~at~the~same~institution,\ you~may~put~more~than~one~name~above~a~single~address.\ 
			Else~use~the~in-line~author~style,\ not~the~[grid]~option.} 

    % backward compatibility 
    \cs_if_exist:NF \tl_set:Ne  { \cs_generate_variant:Nn \tl_set:Nn {Ne} }

    \NewDocumentCommand\@ConstructAuthorBlock{}{%
     	\int_compare:nNnT { \g__asmeconf_authorcnt_int } >  { 3 } {
   			\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { hc } { b } \g__asmeconf_secondrowauthorblock_coffin { hc } { t } { 0pt } { -1.5\baselineskip } 
        }
     	\int_compare:nNnT { \g__asmeconf_authorcnt_int } >  { 6 } {
   			\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { hc } { b } \g__asmeconf_thirdrowauthorblock_coffin { hc } { t } { 0pt } { -1.5\baselineskip } 
        }
     	\int_compare:nNnT { \g__asmeconf_authorcnt_int } >  { 9 } {
   			\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { hc } { b } \g__asmeconf_fourthrowauthorblock_coffin { hc } { t } { 0pt } { -1.5\baselineskip } 
        }
     	\int_compare:nNnT { \g__asmeconf_authorcnt_int } >  { 12 } {
   			\coffin_gjoin:NnnNnnnn \g__asmeconf_firstrowauthorblock_coffin { hc } { b } \g__asmeconf_fifthrowauthorblock_coffin { hc } { t } { 0pt } { -1.5\baselineskip } 
        }
		\coffin_typeset:Nnnnn \g__asmeconf_firstrowauthorblock_coffin { l }{ t }{ 0pt }{ 0pt }
        \__asmeconf_concataut:
        \cs_gset:Npn \@author { \tl_use:N \g_asmeconf_authors_tl }
    }
    
    % build comma-separated list of author names
 	\tl_new:N     \g_asmeconf_authors_tl
 	\tl_gset:Nn   \g_asmeconf_authors_tl \c_empty_tl
    \cs_new_protected:Nn \__asmeconf_concataut: { 
    	\int_set:Nn  \l_tmpa_int {1}
		\tl_clear:N \l_tmpb_tl 
	    \int_do_until:nNnn { \l_tmpa_int } > { \g__asmeconf_authorcnt_int }
    		{
			    \tl_set:Ne  \l_tmpb_tl { \seq_item:NV \g__asmeconf_author_seq \l_tmpa_int }
            	\regex_replace_all:nnN  { \cA\~ } {\ } \l_tmpb_tl % replace ~ by space in author list
            	\tl_replace_all:Nnn \l_tmpb_tl { \affil } { \use_none:n  }
            	\tl_remove_all:Nn   \l_tmpb_tl { \JointFirstAuthor }
            	\tl_replace_all:Nnn \l_tmpb_tl { \CorrespondingAuthor } { \use_none:n }
        		\int_compare:nNnT   { \l_tmpa_int } < { \g__asmeconf_authorcnt_int } {
            		\tl_put_right:Nn \l_tmpb_tl { ,~ }
        		}
			    \tl_gput_right:NV  \g_asmeconf_authors_tl \l_tmpb_tl
				\int_incr:N  \l_tmpa_int  
    		}
			%\iow_term:e { Authors:~ \tl_use:N \g_asmeconf_authors_tl } % diagnostic only		
    }

    \ExplSyntaxOff 
   
%%% otherwise use the new compact layout of authors
\else
	%%%%%%%%%%%%%%%%%%%%%%   New author layout (inline)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%
	%% converted to expl3, 17 August 2024; revised 27 January 2025
    
    \ExplSyntaxOn 

    \coffin_new:N \g__asmeconf_authorblock_coffin
    \coffin_new:N \g__asmeconf_affiliationblock_coffin
    \coffin_new:N \g__asmeconf_affiliationsblock_coffin

    \cs_if_exist:NF \cs_gset:Npe  { \cs_generate_variant:Nn \cs_gset:Npn {Npe} }     
	\tl_new:N \asmeconf_authors_tl
    \NewDocumentCommand\SetAuthors{m}{
		\tl_gset:Nn \g_asmeconf_formattedauthors_tl 
         {
	         \centering\sffamily\bfseries #1
	     }
	         \__asmeconf_striptokens:n {#1}
	  		 \cs_gset:Npe \@author { \tl_use:N \g_asmeconf_authors_tl }% set \@author = list of authors, 2024/07/31
    }

    %% strip \affil{..}, \JointFirstAuthor, \CorrespondingAuthor{...} from argument
    \cs_new_protected:Nn  \__asmeconf_striptokens:n { 
        \tl_set:Nn \l_tmpa_tl {#1}
		\regex_replace_all:nnN  { \cA\~ } {\ } \l_tmpa_tl % replace ~ by space in author list
    	\tl_remove_all:Nn   \l_tmpa_tl { \JointFirstAuthor }
		\tl_replace_all:Nnn \l_tmpa_tl { \affil } { \use_none:n }
		\tl_replace_all:Nnn \l_tmpa_tl { \CorrespondingAuthor } { \use_none:n }
        \tl_new:N   \g_asmeconf_authors_tl	
		\tl_gset:NV \g_asmeconf_authors_tl \l_tmpa_tl % 2024/08/18 e -> V
	%	\iow_term:e { \tl_use:N \g_asmeconf_authors_tl }% diagnostic only
    }   
    
    \def\@makefnmark{\hbox{\@textsuperscript{\sffamily\@thefnmark}}}%
    \seq_gclear_new:N \g__asmeconf_affiliations_seq
    \NewDocumentCommand\SetAffiliation{mm}{%
       \ifblank{#1}{
       		\seq_gput_right:Nn \g__asmeconf_affiliations_seq { \centering\sffamily \tl_trim_spaces:n{ #2 } }%
		}{
		    \seq_gput_right:Nn \g__asmeconf_affiliations_seq { \footnotemark[#1]\centering\sffamily \tl_trim_spaces:n{ #2 } }%
    	}
	}
            
	%%% Affiliation mark
    \NewDocumentCommand{\affil}{>{\TrimSpaces} m}{%
    	\ifblank{#1}{%
			\ClassWarning{\ClassName}{Empty affiliation tag}%
			\@gobble% addresses modification for commas
        }{\bfseries\footnotemark[#1]}%
    }
          
 	%%% to deal with sequential notes as, e.g., "1,*", or "1,2,*" %%%%%%%%%%
    \cs_new:Npn   \__asmeconf_OtherNoteComma:n { 
    	\peek_remove_spaces:n { % added 2025/01/27
    		\peek_meaning:NTF \affil 
				{ \textsuperscript{\mdseries,} }
				{ \peek_meaning:NTF \CorrespondingAuthor 
							{ \textsuperscript{\mdseries,} } 
    						{ \peek_meaning:NT \JointFirstAuthor { \textsuperscript{\mdseries,} } }
			}
		}
	}
    \cs_new_eq:NN \__asmeconf_saveAF \affil
    \cs_gset_protected:Npn \affil #1               { \__asmeconf_saveAF{#1} \__asmeconf_OtherNoteComma:n } 
    \cs_new_eq:NN \__asmeconf_saveCA \CorrespondingAuthor
    \cs_gset_protected:Npn \CorrespondingAuthor #1 { \__asmeconf_saveCA{#1} \__asmeconf_OtherNoteComma:n  } 
    \cs_new_eq:NN \__asmeconf_saveJA \JointFirstAuthor
    \cs_gset_protected:Npn \JointFirstAuthor       { \__asmeconf_saveJA     \__asmeconf_OtherNoteComma:n }  

	%%% 
	%% next construct author/affiliation coffin 
	\int_zero_new:N   \g_asmeconf_count_affil_int
    \NewDocumentCommand\@SetAuthorBlock{}{%
    \leavevmode
    \tagpdfparaOff % this pair of tagpdf macros may change over time, 2025/01/28
       \vcoffin_gset:Nnn \g__asmeconf_authorblock_coffin {\textwidth} % switched to vcoffin 2024/10/16 to accommodate tagging
       		{ \tl_use:N \g_asmeconf_formattedauthors_tl }
		\seq_remove_duplicates:N \g__asmeconf_affiliations_seq
		\int_gset:Nn \g_asmeconf_count_affil_int {\seq_count:N \g__asmeconf_affiliations_seq}
		\int_zero_new:N  \l__asmeconf_affilno_int
		\int_until_do:nNnn { \l__asmeconf_affilno_int } > { \g_asmeconf_count_affil_int } {
	        \vcoffin_set:Nnn \g__asmeconf_affiliationblock_coffin { \textwidth } {
	        	\seq_item:Nn \g__asmeconf_affiliations_seq { \l__asmeconf_affilno_int }
        	}
        \coffin_gjoin:NnnNnnnn \g__asmeconf_affiliationsblock_coffin { hc } { b } \g__asmeconf_affiliationblock_coffin {hc } { t } { 0pt} { -1pt }
        \int_incr:N \l__asmeconf_affilno_int
		}
       \coffin_gjoin:NnnNnnnn \g__asmeconf_authorblock_coffin { hc } { b } \g__asmeconf_affiliationsblock_coffin {hc } { t } { 0pt} { -\baselineskip } 
       \coffin_typeset:Nnnnn  \g__asmeconf_authorblock_coffin { l }{ T }{ 0pt }{ 0pt }
	\tagpdfparaOn\par
    }
    \ExplSyntaxOff
\fi % end if...else for grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Make the title and author section
\ExplSyntaxOn
\NewDocumentCommand\MakeTitlePage{}{%
    \twocolumn[
      	  \@HeaderTitle 
          \vspace*{2\baselineskip}
	      \par\tag_struct_begin:n{tag=Div, title=Author~and~affilation}
          \ifasmeconf@grid
             \@SetAuthorBlock\@ConstructAuthorBlock
          \else
             \@SetAuthorBlock
          \fi
          \vspace*{3\baselineskip} 
    ]
    \let\@makefnmark\savemakefnmark% restore footnote mark font
    \renewcommand*{\thefootnote}{\fnsymbol{footnote}}
    \ifac@JA
        \footnotetext[2]{\JAwords}
    \fi
    \ifac@CA
        \footnotetext[1]{\CAwords\@CAsep\@CAemail}
    \fi
    \par\tag_struct_end:
    \let\thefootnote\savethefootnote% restore footnote symbol
}
\ExplSyntaxOff

%%%%%%%%%%

%% Provide compatibility with titling commands from standard LaTeX article class
\RenewDocumentCommand{\maketitle}{}{\MakeTitlePage}
\RenewDocumentCommand{\title}{}{\PaperTitle}

\RenewDocumentCommand{\thanks}{m}{\relax}% disabling this standard command (inconsistent with this format)

%% \versionfootnote produces an unmarked footnote about the version date, to replace "date"
%% This tool is for editing and should not be used in the final draft

%% This form provides working hyperlink, but it throws warning; also, \gdef -->\def. 2021/12/09
%\NewDocumentCommand\versionfootnote{m}{\def\@thefnmark{}\@footnotetext{#1}}

%% A hyperlink in this footnote will not function, since NoHyper is used to suppress 'missing anchor' warning
\NewDocumentCommand\versionfootnote{m}{\def\@thefnmark{}\begin{NoHyper}\@footnotetext{#1}\end{NoHyper}}

\RenewDocumentCommand{\date}{m}{\versionfootnote{#1}}% if one wants to use \date this same way; fixed bug 2021/01/14


%%%%%%%%%%%%%%  Sans serif upright greek and sans mathversion  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Provide sans-serif *upright* Greek letters, following a suggestion by Michael Sharpe (March 2019).
%% Following Sharpe's newtxsf implementation of the STIX fonts, under the LaTeX Project Public License.
%% (Note that \mathversion{sansbold} provides sans-serif *italic* Greek letters.) Various edits 2021/01/25

\DeclareSymbolFont{lettersAB}{U}{ntxsfmia}{m}{it}
\SetSymbolFont{lettersAB}{normal}{U}{ntxsfmia}{m}{it}
\SetSymbolFont{lettersAB}{bold}{U}{ntxsfmia}{b}{it}
\SetSymbolFont{lettersAB}{sansbold}{U}{ntxsfmia}{b}{it}% added 2021/01/25, to get this bold in captions, etc.
\DeclareFontSubstitution{U}{ntxsfmia}{m}{it}

\DeclareMathSymbol{\sfGamma}{\mathalpha}{lettersAB}{0}% adjust to avoid overwriting newtxmath commands, 2021/01/25
\DeclareMathSymbol{\sfDelta}{\mathalpha}{lettersAB}{1}
\DeclareMathSymbol{\sfTheta}{\mathalpha}{lettersAB}{2}
\DeclareMathSymbol{\sfLambda}{\mathalpha}{lettersAB}{3}
\DeclareMathSymbol{\sfXi}{\mathalpha}{lettersAB}{4}
\DeclareMathSymbol{\sfPi}{\mathalpha}{lettersAB}{5}

\DeclareMathSymbol{\sfSigma}{\mathalpha}{lettersAB}{6}
\DeclareMathSymbol{\sfUpsilon}{\mathalpha}{lettersAB}{7}
\DeclareMathSymbol{\sfPhi}{\mathalpha}{lettersAB}{8}
\DeclareMathSymbol{\sfPsi}{\mathalpha}{lettersAB}{9}
\DeclareMathSymbol{\sfOmega}{\mathalpha}{lettersAB}{10}

\DeclareMathSymbol{\sfalpha}{\mathalpha}{lettersAB}{11}
\DeclareMathSymbol{\sfbeta}{\mathalpha}{lettersAB}{12}
\DeclareMathSymbol{\sfgamma}{\mathalpha}{lettersAB}{13}
\DeclareMathSymbol{\sfdelta}{\mathalpha}{lettersAB}{14}
\DeclareMathSymbol{\sfepsilon}{\mathalpha}{lettersAB}{15}

\DeclareMathSymbol{\sfzeta}{\mathalpha}{lettersAB}{16}
\DeclareMathSymbol{\sfeta}{\mathalpha}{lettersAB}{17}
\DeclareMathSymbol{\sftheta}{\mathalpha}{lettersAB}{18}
\DeclareMathSymbol{\sfiota}{\mathalpha}{lettersAB}{19}
\DeclareMathSymbol{\sfkappa}{\mathalpha}{lettersAB}{20}

\DeclareMathSymbol{\sflambda}{\mathalpha}{lettersAB}{21}
\DeclareMathSymbol{\sfmu}{\mathalpha}{lettersAB}{22}
\DeclareMathSymbol{\sfnu}{\mathalpha}{lettersAB}{23}
\DeclareMathSymbol{\sfxi}{\mathalpha}{lettersAB}{24}
\DeclareMathSymbol{\sfpi}{\mathalpha}{lettersAB}{25}

\DeclareMathSymbol{\sfrho}{\mathalpha}{lettersAB}{26}
\DeclareMathSymbol{\sfsigma}{\mathalpha}{lettersAB}{27}
\DeclareMathSymbol{\sftau}{\mathalpha}{lettersAB}{28}
\DeclareMathSymbol{\sfupsilon}{\mathalpha}{lettersAB}{29}
\DeclareMathSymbol{\sfphi}{\mathalpha}{lettersAB}{30}

\DeclareMathSymbol{\sfchi}{\mathalpha}{lettersAB}{31}
\DeclareMathSymbol{\sfpsi}{\mathalpha}{lettersAB}{32}
\DeclareMathSymbol{\sfomega}{\mathalpha}{lettersAB}{33}
\DeclareMathSymbol{\sfvarepsilon}{\mathalpha}{lettersAB}{34}
\DeclareMathSymbol{\sfvartheta}{\mathalpha}{lettersAB}{35}

\DeclareMathSymbol{\sfvarpi}{\mathord}{lettersAB}{36}% added these 2021/01/25
\DeclareMathSymbol{\sfvarrho}{\mathord}{lettersAB}{37}
\DeclareMathSymbol{\sfvarsigma}{\mathord}{lettersAB}{38}
\DeclareMathSymbol{\sfvarphi}{\mathord}{lettersAB}{39}
\DeclareMathSymbol{\sfitvarkappa}{\mathalpha}{lettersAB}{40}
\DeclareMathSymbol{\sfvarkappa}{\mathalpha}{lettersAB}{40}
\DeclareMathSymbol{\sfitnabla}{\mathalpha}{lettersAB}{42}
\DeclareMathSymbol{\sfnabla}{\mathalpha}{lettersAB}{43}
\DeclareMathSymbol{\sfhslash}{\mathalpha}{lettersAB}{52}% this is not upright
\DeclareMathSymbol{\sfhbar}{\mathalpha}{lettersAB}{53}%   this is not upright

\DeclareMathAccent{\grave}{\mathord}{lettersAB}{254}% added these after bug report 2021/01/24
\DeclareMathAccent{\acute}{\mathord}{lettersAB}{255}
\DeclareMathAccent{\check}{\mathord}{lettersAB}{186}
\DeclareMathAccent{\breve}{\mathord}{lettersAB}{187}
\DeclareMathAccent{\bar}{\mathord}{lettersAB}{221}
\DeclareMathAccent{\mathring}{\mathord}{lettersAB}{222}
\DeclareMathAccent{\hat}{\mathord}{lettersAB}{223}
\DeclareMathAccent{\dot}{\mathord}{lettersAB}{224}
\DeclareMathAccent{\tilde}{\mathord}{lettersAB}{219}

%%% sans math version, potential value with PGFPlots, e.g., not for use in main text. 2021/01/25 %%%
\DeclareMathVersion{sans}
\SetSymbolFont{letters}{sans}{OML}{ntxsfmi}{m}{it}
\SetSymbolFont{lettersA}{sans}{U}{ntxsfmia}{m}{it}
\SetSymbolFont{lettersAB}{sans}{U}{ntxsfmia}{m}{it}
\IfFormatAtLeastTF{2016/01/05}{%
	\SetSymbolFont{symbols}{sans}{LMS}{ntxsy}{m}{n}
	}{\relax}
\SetSymbolFont{largesymbols}{sans}{LMX}{ntxexx}{m}{n}
\SetSymbolFont{largesymbolsTXA}{sans}{U}{ntxexa}{m}{n}
\SetSymbolFont{operators}{sans}{\encodingdefault}{\sfdefault}{m}{n}
\SetMathAlphabet{\mathsf}{sans}{\encodingdefault}{\sfdefault}{m}{n}% make upright 2021/01/31.

%%%%%%%%%%%%%%%%%%  Times-like fonts for specific languages  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifpdftex % Under lualatex, babel has problems with the following approach, which assumes that fontspec has not been loaded.
          % Recommend not to choose the [nofontspec] option.
	% Several modifications made in response to newtx v1.71, 2022/03/14
	\ifac@vietnamese
%
	\IfFormatAtLeastTF{2020/02/02}{\relax}{%
	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion. LaTeX distributions 2020 are necessary to use the fonts of the [vietnamese] option with pdflatex}{Please UPDATE your LaTeX distribution: TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  Alternatively, delete the class option [vietnamese].}%
	}
%
		\AtBeginDocument{%
			\let\babel@aux\@gobbletwo % eliminate warnings about missing .fd. Brute force approach, revisit later. 2022/03/14
			\DeclareFontFamilySubstitution{T5}{\rmdefault}{qtm}  % new in 02/20/2020 format of LaTeX!  Need to test.
			\DeclareFontFamilySubstitution{T5}{\ttdefault}{qcr}
		}
		% Vietnamese is in T5 encoding, can use Tex Gyre Termes font (qtm); 
    	% qhv = Heros (helvetica). We get the right font w/o loading this.        	
    	% qcr = Cursor (monospaced) is poor match to inconsolata; qhv (the sf font) matches better, but isn't monospaced.
%
    	% From TeX Gyre Termes and Cursor .fd files by B. Jackowski and J. M. Nowacki, released under the GUST license
        \begingroup
        \nfss@catcodes
%        
        \def\qtm@scale{s*[0.97]}
        \DeclareFontFamily{T5}{qtm}{}% not adjusting wordspacing
        \DeclareFontShape{T5}{qtm}{b}{sc}{<-> \qtm@scale t5-qtmb-sc}{}
        \DeclareFontShape{T5}{qtm}{b}{n}{<-> \qtm@scale t5-qtmb}{}
        \DeclareFontShape{T5}{qtm}{b}{scit}{<-> \qtm@scale t5-qtmbi-sc}{}
        \DeclareFontShape{T5}{qtm}{b}{it}{<-> \qtm@scale t5-qtmbi}{}
        \DeclareFontShape{T5}{qtm}{m}{sc}{<-> \qtm@scale t5-qtmr-sc}{}
        \DeclareFontShape{T5}{qtm}{m}{n}{<-> \qtm@scale t5-qtmr}{}
        \DeclareFontShape{T5}{qtm}{m}{scit}{<-> \qtm@scale t5-qtmri-sc}{}
        \DeclareFontShape{T5}{qtm}{m}{it}{<-> \qtm@scale t5-qtmri}{}
        \DeclareFontShape{T5}{qtm}{bx}{sc}{<->ssub * qtm/b/sc}{}
        \DeclareFontShape{T5}{qtm}{bx}{n}{<->ssub * qtm/b/n}{}
        \DeclareFontShape{T5}{qtm}{bx}{scit}{<->ssub * qtm/b/scit}{}
        \DeclareFontShape{T5}{qtm}{bx}{it}{<->ssub * qtm/b/it}{}
        \DeclareFontShape{T5}{qtm}{b}{sl}{<->sub * qtm/b/it}{}
        \DeclareFontShape{T5}{qtm}{m}{sl}{<->sub * qtm/m/it}{}
        \DeclareFontShape{T5}{qtm}{b}{scsl}{<->sub * qtm/b/scit}{}
        \DeclareFontShape{T5}{qtm}{m}{scsl}{<->sub * qtm/m/scit}{}
%                
        \def\qcr@scale{s*[0.95]}
        \DeclareFontFamily{T5}{qcr}{}% not adjusting wordspacing
        \DeclareFontShape{T5}{qcr}{b}{sc}{<-> \qcr@scale t5-qcrb-sc}{}
        \DeclareFontShape{T5}{qcr}{b}{n}{<-> \qcr@scale t5-qcrb}{}
        \DeclareFontShape{T5}{qcr}{b}{scit}{<-> \qcr@scale t5-qcrbi-sc}{}
        \DeclareFontShape{T5}{qcr}{b}{it}{<-> \qcr@scale t5-qcrbi}{}
        \DeclareFontShape{T5}{qcr}{m}{sc}{<-> \qcr@scale t5-qcrr-sc}{}
        \DeclareFontShape{T5}{qcr}{m}{n}{<-> \qcr@scale t5-qcrr}{}
        \DeclareFontShape{T5}{qcr}{m}{scit}{<-> \qcr@scale t5-qcrri-sc}{}
        \DeclareFontShape{T5}{qcr}{m}{it}{<-> \qcr@scale t5-qcrri}{}
        \DeclareFontShape{T5}{qcr}{bx}{sc}{<->ssub * qcr/b/sc}{}
        \DeclareFontShape{T5}{qcr}{bx}{n}{<->ssub * qcr/b/n}{}
        \DeclareFontShape{T5}{qcr}{bx}{scit}{<->ssub * qcr/b/scit}{}
        \DeclareFontShape{T5}{qcr}{bx}{it}{<->ssub * qcr/b/it}{}
        \DeclareFontShape{T5}{qcr}{b}{sl}{<->sub * qcr/b/it}{}
        \DeclareFontShape{T5}{qcr}{m}{sl}{<->sub * qcr/m/it}{}
        \DeclareFontShape{T5}{qcr}{b}{scsl}{<->sub * qcr/b/scit}{}
        \DeclareFontShape{T5}{qcr}{m}{scsl}{<->sub * qcr/m/scit}{}
    	\endgroup
    \fi

    \ifac@greek
%
	\IfFormatAtLeastTF{2020/02/02}{\relax}{%
	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion. LaTeX distributions 2020 are necessary to use the fonts of the [greek] option with pdflatex}{Please UPDATE your LaTeX distribution: TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  Alternatively, delete the class option [greek].}%
	}
%
    	\AtBeginDocument{%
			\let\babel@aux\@gobbletwo % eliminate warnings about missing .fd. Brute force approach, revisit later. 2022/03/14
    		\DeclareFontFamilySubstitution{LGR}{\familydefault}{artemisia} % scale these
    		\DeclareFontFamilySubstitution{LGR}{\sfdefault}{maksf}%kerkis
    		\DeclareFontFamilySubstitution{LGR}{\ttdefault}{DejaVuSansMono-TLF}
    	}	
%        %% Based on Artemisia fd files by A. Tsolomitis and ideas from substitutefont package by G. Milde, both LaTeX Public License.
        \begingroup
        \nfss@catcodes
%        
        \def\artemisiasc@scaled{s*[0.95]}
        \def\artemisia@scaled{s*[0.93]}
        \DeclareFontFamily{LGR}{artemisia}{%
        	\fontdimen2\font=.25em
    		\fontdimen3\font=.2em
    		\fontdimen4\font=.1em
    		}% adjusted word spacing to match newtxtext... this is tighter.
        \DeclareFontShape{LGR}{artemisia}{m}{n}{<->  \artemisia@scaled gartemisiarg6a}{}
        \DeclareFontShape{LGR}{artemisia}{m}{it}{<-> \artemisia@scaled gartemisiai6a}{}
        \DeclareFontShape{LGR}{artemisia}{b}{n}{<->  \artemisia@scaled gartemisiab6a}{}
        \DeclareFontShape{LGR}{artemisia}{b}{it}{<-> \artemisia@scaled gartemisiabi6a}{}
        \DeclareFontShape{LGR}{artemisia}{m}{sl}{<-> \artemisia@scaled gartemisiao6a}{}
        \DeclareFontShape{LGR}{artemisia}{b}{sl}{<-> \artemisia@scaled gartemisiabo6a}{}
        \DeclareFontShape{LGR}{artemisia}{m}{sc}{<-> \artemisiasc@scaled gartemisiasc6a}{}
        \DeclareFontShape{LGR}{artemisia}{m}{sco}{<->\artemisiasc@scaled gartemisiasco6a}{}
%        
        %% nextx names oblique sc as both scit and scsl. ("largesc" option of newtx is different font, not a scaling.) 
        \DeclareFontShape{LGR}{artemisia}{m}{scsl}{<->\artemisiasc@scaled gartemisiasco6a}{}% sco
        \DeclareFontShape{LGR}{artemisia}{m}{scit}{<->\artemisiasc@scaled gartemisiasco6a}{}% sco
%        
        \DeclareFontShape{LGR}{artemisia}{bx}{n}{<-> \artemisia@scaled gartemisiab6a}{}
        \DeclareFontShape{LGR}{artemisia}{bx}{it}{<->\artemisia@scaled gartemisiabi6a}{}
        \DeclareFontShape{LGR}{artemisia}{bx}{sl}{<->\artemisia@scaled gartemisiabo6a}{}
%        
%        % Sans Serif Greek font Kerkis
%        % Based on Kerkis fd file, by Antonis Tsolomitis, under the LaTeX Project Public License
        \def\kerkissf@scaled{s*[0.95]}
        \DeclareFontFamily{LGR}{maksf}{}% not adjusting wordspacing
        \DeclareFontShape{LGR}{maksf}{m}{n}{<-> \kerkissf@scaled gksf7t}{}
        \DeclareFontShape{LGR}{maksf}{m}{it}{<->\kerkissf@scaled gksfi7t}{}  
        \DeclareFontShape{LGR}{maksf}{m}{sl}{<->\kerkissf@scaled gksfi7t}{}
        \DeclareFontShape{LGR}{maksf}{m}{sc}{<->\kerkissf@scaled gksfsc7t}{}
        \DeclareFontShape{LGR}{maksf}{b}{n}{ <->\kerkissf@scaled gksfb7t}{}  
        \DeclareFontShape{LGR}{maksf}{b}{it}{<->\kerkissf@scaled gksfbi7t}{}
        \DeclareFontShape{LGR}{maksf}{b}{sl}{<->\kerkissf@scaled gksfbi7t}{}  
%        
        \DeclareFontShape{LGR}{maksf}{bx}{n}{  <-> \kerkissf@scaled gksfb7t}{}
        \DeclareFontShape{LGR}{maksf}{bx}{it}{ <-> \kerkissf@scaled gksfbi7t}{}
        \DeclareFontShape{LGR}{maksf}{bx}{sl}{ <-> \kerkissf@scaled gksfbi7t}{}
%    
%        %% Greek monospaced font, DejaVuSansMono
%        %% Based on DejaVu fd files by Pavel Farar, under the LaTeX Project Public License
        \def\DejaVuSansMono@@scale{s*[0.85]}%
        \DeclareFontFamily{LGR}{DejaVuSansMono-TLF}{}% not adjusting wordspacing
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{b}{it}{<-> \DejaVuSansMono@@scale DejaVuSansMono-BoldOblique-tlf-lgr}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{b}{n}{ <-> \DejaVuSansMono@@scale DejaVuSansMono-Bold-tlf-lgr}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{m}{it}{<-> \DejaVuSansMono@@scale DejaVuSansMono-Oblique-tlf-lgr}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{m}{n}{ <-> \DejaVuSansMono@@scale DejaVuSansMono-tlf-lgr}{}
        
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{m}{sl}{<-> \DejaVuSansMono@@scale DejaVuSansMono-TLF/m/it}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{b}{sl}{<-> \DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
        
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{bx}{sl}{<->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{bx}{it}{<->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
        \DeclareFontShape{LGR}{DejaVuSansMono-TLF}{bx}{n}{ <->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/n}{}
%
    	\endgroup
    \fi

    \ifac@cyrillic
%
	\IfFormatAtLeastTF{2020/02/02}{\relax}{%
	\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion. LaTeX distributions 2020 are necessary to use the fonts of the cyrillic language option with pdflatex, e.g., [russian]}{Please UPDATE your LaTeX distribution: TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.  Alternatively, delete the class option calling a cyrillic-alphabet language.}%
	}
%
	\AtBeginDocument{%
		\let\babel@aux\@gobbletwo % eliminate warnings about missing .fd. Brute force approach, revisit later. 2022/03/14
		\DeclareFontFamilySubstitution{T2A}{\familydefault}{PTSerif-TLF}
		\DeclareFontFamilySubstitution{T2A}{\sfdefault}{PTSans-TLF}
%		\DeclareFontFamilySubstitution{T2A}{\ttdefault}{DejaVuSansMono-TLF} % if one prefers an SF monospace font
		\DeclareFontFamilySubstitution{T2A}{\ttdefault}{PTMono} 
	}
       %% Paratype fonts for cyrillic, maintained by Pavel Farar, under Latex Project Public License
        \begingroup
        \nfss@catcodes
%        
        \def\PTSerif@@scale{s*[0.95]}% had had 0.94...
        \DeclareFontFamily{T2A}{PTSerif-TLF}{}% not adjusting wordspacing, since it matches newtxtext as is
        \DeclareFontShape{T2A}{PTSerif-TLF}{m}{n}{ <->\PTSerif@@scale PTSerif-Regular-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{m}{it}{<->\PTSerif@@scale PTSerif-Italic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{b}{n}{ <->\PTSerif@@scale PTSerif-Bold-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{b}{it}{<->\PTSerif@@scale PTSerif-BoldItalic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{m}{ui}{<->\PTSerif@@scale PTSerif-UprightItalic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{m}{sl}{<->\PTSerif@@scale PTSerif-Slanted-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{b}{ui}{<->\PTSerif@@scale PTSerif-BoldUprightItalic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{b}{sl}{<->\PTSerif@@scale PTSerif-BoldSlanted-tlf-t2a}{}
%        
        \DeclareFontShape{T2A}{PTSerif-TLF}{bx}{n}{<->ssub * PTSerif-TLF/b/n}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{bx}{it}{<->ssub * PTSerif-TLF/b/it}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{bx}{ui}{<->ssub * PTSerif-TLF/b/ui}{}
        \DeclareFontShape{T2A}{PTSerif-TLF}{bx}{sl}{<->ssub * PTSerif-TLF/b/sl}{}
%        
        \def\PTSans@@scale{s*[0.94]}%
        \DeclareFontFamily{T2A}{PTSans-TLF}{}% not adjusting wordspacing
        \DeclareFontShape{T2A}{PTSans-TLF}{b}{it}{<->\PTSans@@scale PTSans-BoldItalic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{b}{n}{<-> \PTSans@@scale PTSans-Bold-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{m}{it}{<->\PTSans@@scale PTSans-Italic-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{m}{n}{<-> \PTSans@@scale PTSans-Regular-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{c}{n}{<-> \PTSans@@scale PTSans-Narrow-tlf-t2a}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{bc}{n}{<->\PTSans@@scale PTSans-NarrowBold-tlf-t2a}{}
%        
        \DeclareFontShape{T2A}{PTSans-TLF}{m}{sl}{<->ssub * PTSans-TLF/m/it}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{b}{sl}{<->ssub * PTSans-TLF/b/it}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{bx}{sl}{<->ssub * PTSans-TLF/b/it}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{bx}{it}{<->ssub * PTSans-TLF/b/it}{}
        \DeclareFontShape{T2A}{PTSans-TLF}{bx}{n}{<->ssub * PTSans-TLF/b/n}{}
%
%        %% the tt cyrillic is slightly larger than the latin characters.    
         \def\PTMono@@scale{s*[0.92]}%
         \DeclareFontFamily{T2A}{PTMono}{}% not adjusting wordspacing
         \DeclareFontShape{T2A}{PTMono}{m}{n}{<-> \PTMono@@scale PTMono-Regular-tlf-t2a}{}
         \DeclareFontShape{T2A}{PTMono}{b}{n}{<-> \PTMono@@scale PTMono-Bold-tlf-t2a}{}
         \DeclareFontShape{T2A}{PTMono}{m}{sl}{<->\PTMono@@scale PTMono-Slanted-tlf-t2a}{}
         \DeclareFontShape{T2A}{PTMono}{b}{sl}{<->\PTMono@@scale PTMono-BoldSlanted-tlf-t2a}{}
         \DeclareFontShape{T2A}{PTMono}{m}{it}{<->\PTMono@@scale PTMono-Slanted-tlf-t2a}{}
         \DeclareFontShape{T2A}{PTMono}{b}{it}{<->\PTMono@@scale PTMono-BoldSlanted-tlf-t2a}{}
        
         \DeclareFontShape{T2A}{PTMono}{bx}{n}{<->ssub * PTMono-TLF/b/n}{}
         \DeclareFontShape{T2A}{PTMono}{bx}{sl}{<->ssub * PTMono-TLF/b/sl}{}
%
        \def\DejaVuSansMono@@scale{s*[0.85]}%
        \DeclareFontFamily{T2A}{DejaVuSansMono-TLF}{}% not adjusting wordspacing
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{b}{it}{<-> \DejaVuSansMono@@scale DejaVuSansMono-BoldOblique-tlf-t2a}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{b}{n}{ <-> \DejaVuSansMono@@scale DejaVuSansMono-Bold-tlf-t2a}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{m}{it}{<-> \DejaVuSansMono@@scale DejaVuSansMono-Oblique-tlf-t2a}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{m}{n}{ <-> \DejaVuSansMono@@scale DejaVuSansMono-tlf-t2a}{}
%        
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{m}{sl}{<-> \DejaVuSansMono@@scale DejaVuSansMono-TLF/m/it}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{b}{sl}{<-> \DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
%        
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{bx}{sl}{<->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{bx}{it}{<->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/it}{}
        \DeclareFontShape{T2A}{DejaVuSansMono-TLF}{bx}{n}{ <->\DejaVuSansMono@@scale DejaVuSansMono-TLF/b/n}{}
%   
        \endgroup 
    \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
%%
%% End of file `asmeconf.cls'.

