---
title: LaTeX package/class tagging status
---
<style>
td.compatible {background-color: #DDFFDD55;font-weight:bold;}
td.partially-compatible {background-color: #FFFFDD55;font-weight:bold;}
td.no-support {background-color: #FFDDDD55;font-weight:bold;}
td.currently-incompatible {font-weight:bold;}
td.unknown {background-color: #FFEE9955;font-weight:bold;}
td.date {white-space: nowrap;font-size:90%;}
.markdown-body table tr { vertical-align: baseline;}
.markdown-body table thead tr { border-bottom: solid thick black;}
.markdown-body table p { margin-bottom: 0pt;}
</style>
<script src="sorttable.js"></script>



# Tagging Status of LaTeX Packages and Classes

{% assign t-s = "" | split: "" %}
{% for p in site.data.tagging-status %}
{% if p.priority < 5
or p.status == 'compatible'
or p.status == 'no-support'
%}
{% assign t-s = t-s | push: p %}
{% endif %}
{% endfor %}

This file shows the status of **{{t-s | size }}** LaTeX [Packages](#packages) and [Classes](#classes)
with respect to PDF tagging. `phase-III` is generally needed and not explicitly shown.

The values in the *Status* column have the following meaning:

- `compatible` This package or class works without any issues when tagging is enabled. If there are problems, please open an issue in [the tagging-project repo](https://github.com/latex3/tagging-project/issues). (**{{t-s | where: "status", "compatible" | size }}** entries across all tables)
- `partially-compatible` The package or class is currently partially compatible, e.g., some parts may not work yet, but with some restrictions it can already be used. See comments for details. (**{{t-s | where: "status", "partially-compatible" | size }}** entries across all tables)
- `currently-incompatible` The package or class is currently incompatible with the tagging code, but we expect it to be updated eventually. (**{{t-s | where: "status", "currently-incompatible" | size }}** entries across all tables)
- `no-support` This package or class or class is incompatible with the tagging code and we do *not* believe that it will ever be supported. (**{{t-s | where: "status", "no-support" | size }}** entries across all tables)
- `unknown` The status of this package or class is not known, because there aren't reliable tests yet. Help with testing to determine the real status is very much appreciated. (**{{t-s | where: "status", "unknown" | size }}** entries across all tables)

To use packages or classes together with the tagging code it is (nearly) always necessary to load at least `phase-III`of the tagging code, i.e., `testphase=phase-III` in `\DocumentMetadata`. To save space in the tables, this is not explicitly mentioned below. However, if a package or class requires other settings there is an explicit remark in the comments column, e.g., `Tagging support: phase-III, table` which means you have to specify `testphase={phase-III,table}`. If `package` is mentioned at this point it means that the package itself provides the necessary tagging support and not one of the modules in `latex-lab`.


To add or edit the entries in the tables, please make a pull request to change the YAML file
[tagging-status.yml](https://github.com/latex3/tagging-project/blob/main/_data/tagging-status.yml).

If you encounter a problem with a package or class for which there is no issue in the [issue tracker](https://github.com/latex3/tagging-project/issues) yet, please add an issue in the tracker first (including a small example what goes wrong) or start a discussion  in the [discussion view](https://github.com/latex3/tagging-project/discussions) if that seems more appropriate. Later on it can still be added to the tables.


## Packages

{% assign xpackages = t-s | where: "type", "package" %}
{% assign xpc = xpackages | where: "status", "compatible" %}
{% assign xpp = xpackages | where: "status", "partially-compatible" %}
{% assign xpi = xpackages | where: "status", "currently-incompatible" %}
{% assign xpn = xpackages | where: "status", "no-support" %}
{% assign xpu = xpackages | where: "status", "unknown" %}

Statistics: The table currently holds **{{xpackages | size }}** packages out of which
**{{xpc| size }}**  are fully `compatible`,
**{{xpp | size }}** `partially-compatible`,
**{{xpi | size }}** `currently-incompatible`, and
**{{xpn | size }}** have  `no-support`.
The status for the remaining **{{xpu | size }}** packages is `unknown`.

{% assign packages = xpc | concat: xpp | concat: xpi | concat: xpn | concat: xpu %}

{% include_relative status-table.md %}


## Classes


{% assign xpackages = t-s | where: "type", "class" %}
{% assign xpc = xpackages | where: "status", "compatible" %}
{% assign xpp = xpackages | where: "status", "partially-compatible" %}
{% assign xpi = xpackages | where: "status", "currently-incompatible" %}
{% assign xpn = xpackages | where: "status", "no-support" %}
{% assign xpu = xpackages | where: "status", "unknown" %}

Statistics: The table currently holds **{{xpackages | size }}** classes out of which
**{{xpc| size }}**  are fully `compatible`,
**{{xpp | size }}** `partially-compatible`,
**{{xpi | size }}** `currently-incompatible`, and
**{{xpn | size }}** have  `no-support`.
The status for the remaining **{{xpu | size }}** classes is `unknown`.

{% assign packages = xpc | concat: xpp | concat: xpi | concat: xpn | concat: xpu %}

{% include_relative status-table.md %}


----


## References

{% for r in site.data.references %}
<p id="ref{{r.number}}"><span>{{r.number}}. </span> <a href="{{r.url}}"><span>{{r.authors}}.</span> <span>{{r.title}}</span></a></p>
{% endfor %}

