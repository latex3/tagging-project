module = "tagging-project-examples"

test_order = {'structure_test'}
includetests = {'*'}
checkengines = {'luatex', 'pdftex'}
checkconfig = {
  'build',
  'config-broken',
  'config-unknown',
}
checkruns = 3
-- excludetests = {'shapepar-01', 'warpcol-01', 'footnpag-02'}

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
          output_file:write(string.format('<run-error err="%q" />', err))
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
      local outfile_subdir=name:gsub("-%d.*","")
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
