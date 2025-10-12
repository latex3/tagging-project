
# LaTeX Tagging Status
## Generation date: {{ site.time | date: "%Y-%m-%d" }}

The file latex-tagging-status.ltx provides data extracted from the YAML source
of
[https://latex3.github.io/tagging-project/tagging-status/full](https://latex3.github.io/tagging-project/tagging-status/full)

The TeX commands and their arguments are internal to code in latex-lab
and are likely to change.

This data is used in a report in a log file if documents specify checking
the status with

\DocumentMetadata{check-tagging-status}


LaTeX Project  
Licence [LPPL](https://www.latex-project.org/lppl/lppl-1-3c/)

```
Code Status                 Meaning  
---- -----                  -------  
4   compatible             Works without any issues when tagging is enabled  
3   partially-compatible   Currently partially compatible, see comments column  
2   currently-incompatible Currently incompatible with the tagging code, may be updated eventually  
1   no-support             Incompatible with the tagging code, not expected to be supported  
0   unknown                Status is not known
```
