
Click on the column headings to sort the table by the chosen column.

<table class="sortable" style="display:table   ;width:100%">
<thead>
<tr>
<!-- <th>Type</th>  -->
<th>Name</th>
<th>Status</th>
<th>Comments</th>
<th>Relevant issue(s)</th>
<th>Tasks</th>
<th>Last updated</th>
</tr>
</thead>
<tbody>



{%- for p in packages -%}
<tr id="{{p.name}}">
<!-- <td>{{p.type}}</td> -->
<td class="{{p.status}}"><a href="https://ctan.org/pkg/
{%- if p.ctan-pkg -%}{{p.ctan-pkg}}{%- else -%}{{p.name}}{%- endif -%}
">{{p.name}}</a></td>
<td class="{{p.status}}"  sorttable_customkey="
{%- if p.status == "partially-compatible" %}compatible-partial{% else %}{{p.status}}{% endif -%}
">{{p.status}}</td>
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
{%  if p.luatex-only -%}
{%-   if p.tests == "excluded" -%}
{%-     assign dir = "-excluded" -%}
{%-   elsif p.status == "compatible" -%}
{%-     assign dir = "-compatible-luatex" -%}
{%-   elsif p.status == "partially-compatible" -%}
{%-     assign dir = "-partial-luatex" -%}
{%-   elsif  p.status == "currently-incompatible" -%}
{%-     assign dir = "-incompatible" -%}
{%-   else -%}
{%-     assign dir = "-unchecked" -%}
{%-   endif -%}
{%- else -%}
{%-   if p.tests == "excluded" -%}
{%-     assign dir = "-excluded" -%}
{%-   elsif p.status == "compatible" -%}
{%-     assign dir = "-compatible" -%}
{%-   elsif p.status == "partially-compatible" -%}
{%-     assign dir = "-partial" -%}
{%-   elsif  p.status == "currently-incompatible" -%}
{%-     assign dir = "-incompatible" -%}
{%-   else -%}
{%-     assign dir = "-unchecked" -%}
{%-   endif -%}
{%- endif -%}
<a href="https://github.com/search?q=repo%3Alatex3%2Ftagging-project++path%3A%2Ftestfiles{{dir}}.*%5C%2F{{p.name}}%5C%2F%2F">test(s)</a>
{% endif %}
</td>
<td>
{{p.tasks | markdownify}}
{%- if p.priority and p.status != "compatible"%}
Priority: {{p.priority}}
{% endif -%}
</td>
<td class="date">{{p.updated}}</td>
</tr>
{%- endfor -%}

</tbody>
</table>
