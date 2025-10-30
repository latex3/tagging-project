module = "tagging-project-examples"

test_order = {'structure_test'}
includetests = {'*'}
checkengines = {'luatex', 'pdftex'}
checkconfigs = {
  'config-compatible',
  'config-compatible-luatex',
  'config-partial',
  'config-partial-luatex',
  'config-incompatible',
  'config-incompatible-luatex',
  'config-unchecked',
  'config-unchecked-luatex'
}
checkruns = 4

installfiles       = installfiles       or {"*.ltx","*.sty","*.cls","*.bib",
                                            "*.eps","*eps-converted-to.pdf",
                                            "*svg-tex.pdf","*.pdf_tex","*.ods",
                                            "*.png","*.svg","*.mf"}


local pdf_structure do
  local output_handle
  local env = setmetatable({
    os = setmetatable({
      exit = error,
    }, {__index = os}),
    print = function(...)
      local tostring = tostring
      for i, arg in ipairs{...} do
        if i ~= 1 then output_handle:write'\t' end
        output_handle:write(tostring(arg))
      end
      output_handle:write'\n'
    end,
  }, {__index = _ENV})
  -- package
  local mod = loadfile(kpse.find_file('show-pdf-tags', 'lua'), 't', env)
  function pdf_structure(target, ...)
    env.arg = {[0] = 'show-pdf-tags', ...}
    output_handle = target
    local success, err = pcall(mod)
    output_handle = nil
    return success, err
  end
end

local bundleunpack = bundleunpack
function _ENV.bundleunpack(sourcedirs, sources)
  bundleunpack(sourcedirs, sources)

  cp('**', testfiledir, unpackdir)
end

test_types = {
  structure_test = {
    test = ".tex",
    reference = ".struct.xml",
    generated = ".pdf",
    rewrite = function(source, normalized, engine, errorcode)
      local output_file = assert(io.open(normalized, 'w'))
      if errorcode[1] == 0 then
        local success, err = pdf_structure(output_file, '--xml', source)
        if not success then
          output_file:write(string.format('<run-error err=%q />\n', err:gsub(".*: ","")))
        end
      else
        output_file:write(string.format('<run-error code="%i" />', errorcode[1]))
      end
      assert(output_file:close())
    end,
  },
}

-- copy saved reference file back to subdir if suitably named.
function tagging_save(names)
  do
    local errorlevel = checkinit()
    if errorlevel ~= 0 then
      return errorlevel
    end
  end
  local engines
  if options["engine"] then
    engines = checkengines -- sanitized by check_engines()
  else
    engines = {stdengine}
  end
  if names == nil then
    print("Arguments are required for the save command")
    return 1
  end
  for _,name in pairs(names) do
    local test_filename, kind = testexists(name)
    if not test_filename then
      print('Test "' .. name .. '" not found')
      return 1
    end
    local test_type = test_types[kind]
    if test_type.expectation and locate({unpackdir, testfiledir}, {name .. test_type.expectation}) then
      print("Saved " .. test_type.test .. " file would override a "
        .. test_type.expectation .. " file of the same name")
      return 1
    end
    for _,engine in pairs(engines) do
      local testengine = engine == stdengine and "" or ("." .. engine)
      local out_file = name .. testengine .. test_type.reference
      local gen_file = name .. "." .. engine .. test_type.generated
      local outfile_subdir=name:gsub("-%d.*",""):gsub("-bibtex",""):gsub("-biber",""):gsub("-tasks","")
      print("Creating and copying " .. out_file)
      runtest(name, engine, false, test_type.test, test_type)
      ren(testdir, gen_file, out_file)
      if name == outfile_subdir then
        cp(out_file, testdir, testfiledir)
      else
        cp(out_file, testdir, testfiledir .. "/" .. outfile_subdir)
      end
      if fileexists(unpackdir .. "/" .. test_type.reference) then
        print("Saved " .. test_type.reference
          .. " file overrides unpacked version of the same name")
        return 1
      end
    end
  end
  return 0
end

-- associate with the commandline l3build save option
target_list.save.func=tagging_save

-- Execute allowed commands as specified in `% tasks: ` comments.
-- shell command separator and redirects are not allowed
function find_tasks(name)
  local f = io.open(testdir .. "/" .. name .. ".tex", "r")
  for line in f:lines() do
    task = line:match"^%% *tasks: (.*)$"
    if task then
      if
        (task:match("^bibtex") or task:match("^biber") or task:match("^makeindex") or task:match("^mf") or task:match("^mpost"))
        and
        not(task:match("[;&<>]"))
      then
        runcmd(task:gsub("%%",name).."",testdir)
      else
        error("Unsafe task detected: " .. task)
      end
    end
  end
end

-- Extra processing after the first run
-- run biber if test name includes -biber
-- run bibtex if test name includes -bibtex
-- run (sanitised) commands from `% task:` comments if test name includes -tasks
-- run lualatex if the test is listed in the mathtests table
function runtest_tasks(name,run)
  if run == 1 then
   if mathtests[name] then
     runcmd("lualatex"  .. " " .. name,testdir) -- generate MathML
   end
   if name:match("-tasks") then
     find_tasks(name)
   else
     if name:match("-biber") then
       runcmd(biberexe .. " " .. name,testdir)
     end
     if name:match("-bibtex") then
       runcmd(bibtexexe .. " " .. name,testdir)
     end
   end
 end
 return ""
end

-- list of extensions to keep between runs (should check if all these are still needed)
auxfiles = {"*.aux", "*.lof", "*.lot", "*.toc","*.bbl","*.bcf"}

-- list of tests including math and requiring a lualatex run to generate MathML.
mathtests = {
["acro-01"]=true,
["acro-02"]=true,
["algorithmic-01"]=true,
["aligned-overset-01"]=true,
["amsrefs-04"]=true,
["bigints-01"]=true,
["bracealign-01"]=true,
["braket-01"]=true,
["derivative-01"]=true,
["diffcoeff-01"]=true,
["extarrows-01"]=true,
["fouridx-01"]=true,
["interval-01"]=true,
["leftidx-01"]=true,
["leftindex-01"]=true,
["mitthesis-01"]=true,
["mleftright-01"]=true,
["noitcrul-01"]=true,
["numerica-01"]=true,
["relsize-01"]=true,
["scalerel-01"]=true,
["stackrel-01"]=true,
["abraces-01-BAD"]=true,
["autoaligne-01-BAD"]=true,
["autoaligne-02-BAD"]=true,
["autobreak-01"]=true,
["cancel-01"]=true,
["esvect-01"]=true,
["exam-01-BAD"]=true,
["nicefrac-01"]=true,
["oubraces-01"]=true,
["systeme-01-BAD"]=true,
["thmtools-01-BAD"]=true,
["tikz-cd-01"]=true,
["amsmath-01-tagged"]=true,
["amsthm-03"]=true,
["centernot-01-BAD"]=true,
["chemarr-01"]=true,
["cleveref-02"]=true,
["cmll-01"]=true,
["colonequals-01"]=true,
["delimset-01"]=true,
["dotlessi-01"]=true,
["enumext-05-BAD"]=true,
["enumext-06"]=true,
["eqnlines-01-af"]=true,
["eqnlines-01-se"]=true,
["esint-01"]=true,
["extpfeil-01"]=true,
["fge-01"]=true,
["gensymb-01"]=true,
["hvlogos-01"]=true,
["keytheorems-01"]=true,
["letterswitharrows-01"]=true,
["mathalpha-01"]=true,
["mathbbol-01"]=true,
["mathdots-01"]=true,
["mathtools-01"]=true,
["mathtools-02"]=true,
["mathtools-03"]=true,
["mathtools-04-BAD"]=true,
["mathtools-05"]=true,
["mathtools-08"]=true,
["mathtools-09"]=true,
["mathtools-11-BAD"]=true,
["mathtools-12-BAD"]=true,
["mattens-01"]=true,
["old-arrows-01"]=true,
["slashed-01"]=true,
["spalign-01"]=true,
["tensind-01"]=true,
["tensor-01"]=true,
["turnstile-01"]=true,
["underoverlap-01"]=true,
["xfrac-01"]=true,
["youngtab-01"]=true,
["libertinus-otf-01-BAD"]=true,
}