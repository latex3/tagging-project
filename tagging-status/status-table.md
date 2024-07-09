
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
<tr>
<!-- <td>{{p.type}}</td> -->
<td class="{{p.status}}"><a href="https://ctan.org/pkg/
{%- if p.ctan-pkg -%}{{p.ctan-pkg}}{%- else -%}{{p.name}}{%- endif -%}
">{{p.name}}</a></td>
<td class="{{p.status}}">{{p.status}}</td>
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
<b>{{t}}</b>{%- unless forloop.last -%}, {% endunless -%}
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
See also
{% for i in p.related-issues %}
<a href="https://github.com/latex3/tagging-project/issues/{{i}}">#{{i}}</a>
{% endfor %}
{% endif %}
{% if p.tests %}
<a href="https://github.com/FrankMittelbach/tagging-project/tree/main/tagging-status/testfiles/{{p.name}}/">test(s)</a>
{% endif %}
</td>
<td>{{p.tasks | markdownify}}</td>
<td class="date">{{p.updated}}</td>
</tr>
{%- endfor -%}

</tbody>
</table>
