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


{% assign t-s = site.data.tagging-status %}

This file shows the status of **{{t-s | size }}** LaTeX [Packages](#packages) and [Classes](#classes)
with respect to PDF tagging. `phase-III` is generally needed and not explicitly shown.

This is the full list of data in the [YAML file](https://github.com/latex3/tagging-project/blob/main/_data/tagging-status.yml).
Revert to the [display of main properties](./).

The values in the *Status* column have the following meaning:

- `compatible` This package or class works without any issues when tagging is enabled. If there are problems, please open an issue in [the tagging-project repo](https://github.com/latex3/tagging-project/issues). (**{{t-s | where: "status", "compatible" | size }}** entries)
- `partially-compatible` The package or class is currently partially compatible, e.g., some parts may not work yet, but with some restrictions it can already be used. See comments for details. (**{{t-s | where: "status", "partially-compatible" | size }}** entries)
- `currently-incompatible` The package or class is currently incompatible with the tagging code, but we expect it to be updated eventually. (**{{t-s | where: "status", "currently-incompatible" | size }}** entries)
- `no-support` This package or class or class is incompatible with the tagging code and we do *not* believe that it will ever be supported. (**{{t-s | where: "status", "no-support" | size }}** entries)
- `unknown` The status of this package or class is not known, because there aren't reliable tests yet. Help with testing to determine the real status is very much appreciated. (**{{t-s | where: "status", "unknown" | size }}** entries)


Click on the column headings to sort the table by the chosen column.


<table class="sortable" style="display:table   ;width:100%;position:absolute; left:0">
<thead>
<tr>
<th>Type</th>
<th>Name</th>
<th>Status</th>
<th>TLC3</th>
<th>ArXiv %</th>
<th>Priority</th>
<th>Comments</th>
<th>Relevant issue(s)</th>
<th>Tasks</th>
<th>Last updated</th>
</tr>
</thead>
<tbody>
{%- for p in t-s -%}
<tr id="{{p.name}}">
<td>{{p.type}}</td>
<td class="{{p.status}}"><a href="https://ctan.org/pkg/
{%- if p.ctan-pkg -%}{{p.ctan-pkg}}{%- else -%}{{p.name}}{%- endif -%}
">{{p.name}}</a></td>
<td class="{{p.status}}"  sorttable_customkey="
{%- if p.status == "partially-compatible" %}compatible-partial{% else %}{{p.status}}{% endif -%}
">{{p.status}}</td>
<td>{% if p.included-in contains "tlc3" %}TLC3{% endif %}</td>
<td>
{%- if p.included-in contains "arxiv10" %}10{% endif -%}
{%- if p.included-in contains "arxiv5" %} 5{% endif -%}
{%- if p.included-in contains "arxiv1" %} 1{% endif -%}
{%- if p.included-in contains "arxiv01" %}0.1{% endif -%}
{%- if p.included-in contains "arxiv001" %}0.01{% endif -%}
</td>
<td {% unless p.priority %}sorttable_customkey="100"{% endunless %}>{{p.priority}}</td>
<td>
{{p.comments | markdownify}}
{%- if p.references %}
See 
{% for r in p.references %}
<a href="#ref{{r}}">[{{r}}]</a>
{% endfor %}
{%- endif -%}
{%- if p.supported-through -%}
<p>Tagging support:
{% for t in p.supported-through %}
{%- if t == "package" and p.package-repository -%}
<a href="{{p.package-repository}}"><b>{{t}}</b></a>
{%- else -%}
<b>{{t}}</b>
{%- endif -%}
{%- unless forloop.last -%}, {% endunless -%}
{%- endfor %}.</p>
{%- endif -%}
</td>
<td>
{%- if p.issues -%}
{% for i in p.issues %}
<a href="https://github.com/latex3/tagging-project/issues/{{i}}">#{{i}}</a>
{% endfor %}
{%- endif -%}
{% if p.related-issues %}
{%- if p.issues -%}<br/>{%- endif -%}
Related:
{% for i in p.related-issues %}
<a href="https://github.com/latex3/tagging-project/issues/{{i}}">#{{i}}</a>
{% endfor %}
{% endif %}
{% if p.external-issues %}
{%- if p.issues or p.related-issues -%}<br/>{%- endif -%}
Other:
{% for u in p.external-issues %}
{%- assign ltext = u | replace: "issues/", "" | replace: "-/","" | split: "/" -%}
<a href="{{u}}">{{ltext | slice: -2}}/{{ltext | slice: -1}}</a>
{% endfor %}
{% endif %}
{% if p.tests %}
<a href="{{ site.github.repository_url }}/tree/main/tagging-status/testfiles/{{p.name}}/">test(s)</a>
{% endif %}
</td>
<td>
{{p.tasks | markdownify}}
</td>
<td class="date">{{p.updated}}</td>
</tr>
{%- endfor -%}


</tbody>
</table>


----


## References

{% for r in site.data.references %}
<p id="ref{{r.number}}"><span>{{r.number}}. </span> <a href="{{r.url}}"><span>{{r.authors}}.</span> <span>{{r.title}}</span></a></p>
{% endfor %}

