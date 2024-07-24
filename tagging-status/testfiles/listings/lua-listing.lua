local kpse = kpse or require 'kpse'

kpse.set_program('luatex')

return kpse.in_name_ok(arg[1])
