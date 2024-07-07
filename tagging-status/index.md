---
title: LaTeX package/class tagging status
---
<style>
td.supported {background-color: #DDFFDD;font-weight:bold;}
td.partially-supported {background-color: #FFFFDD;font-weight:bold;}
td.no-support {background-color: #FFDDDD;font-weight:bold;}
td.date {white-space: nowrap;font-size:90%;}
</style>
<script src="sorttable.js"></script>

# Tagging Status of LaTeX Packages and Classes

This file shows the status of LaTeX [Packages](#packages) and [Classes](#classes)
with respect to PDF tagging.

The values in the *Status* column have the following meaning:

- `supported` This package or class works without any issues when tagging is enabled. If there are problems, please open an issue in [the tagging-project repo](https://github.com/latex3/tagging-project/issues).
- `partially-supported` The package or class is currently partially supported, e.g., some parts may not work yet, but with some restrictions it can already be used. See comments for details.
- `currently-incompatible` The package or class is currently incompatible with the tagging code, but we expect it to be updated eventually. 
- `no-support` This package or class or class is incompatible with the tagging code and we do *not* believe that it will ever be supported.
- `unknown` The status of this package or class is not known, because there aren't reliable tests yet. Help with testing to determine the real status is very much appreciated.


To add or edit the entries, please make a pull request to change the YAML file
[tagging-status.yml](https://github.com/latex3/tagging-project/blob/main/_data/tagging-status.yml).

If you encounter a problem with a package or class for which there is no issue in the [issue tracker](https://github.com/latex3/tagging-project/issues) yet, please add an issue in the tracker first (including a small example what goes wrong) or start a discussion  in the [discussion view](https://github.com/latex3/tagging-project/discussions) if that seems more appropriate. Later on it can still be added to the tables.


## Packages

{%- assign packages = site.data.tagging-status | where: "type", "package" -%}
{% include_relative status-table.md %}


## Classes

{%- assign packages = site.data.tagging-status | where: "type", "class" -%}
{% include_relative status-table.md %}


----


## References

{% for r in site.data.references %}
<p id="ref{{r.number}}"><span>{{r.number}}. </span> <a href="{{r.url}}"><span>{{r.authors}}.</span> <span>{{r.title}}</span></a></p>
{% endfor %}



