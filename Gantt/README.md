# Gantt chart workflow

The Gantt chart in `Chapters/ChapII_Implementation.tex` (Table `tab:gantt`) is generated
from the workbook `FYS330_Gantt_chart.xlsx`. Edit the workbook, not the table.

## Update the chart

```bash
pip install openpyxl            # once
python3 Gantt/gantt_xlsx_to_tex.py Gantt/FYS330_Gantt_chart.xlsx Chapters/ChapII_Implementation.tex
```

Only the block between `% BEGIN GANTT` and `% END GANTT` is replaced; the rest of the
file is untouched. Re-running with an unchanged workbook gives identical output.

## What to edit in the workbook (blue cells)

* **Weeks**: Phase, Is Break (Y/N), Break Label. Project weeks renumber automatically.
* **Tasks**: ID, Task, Responsible, Type (Task / Milestone / Deliverable), Start/End calendar week,
  and **Gantt label** (short name shown in the chart; falls back to Task if empty).
  Rows appear in the chart in the same order as on the sheet.

## Options

* `--leaders "Planning=Name1,Implementation=Name2,Reporting=Name3"` sets the phase leaders in the header
  (by default they are kept from the existing header).
* `--trail-width 0.4cm` widens the last grey column (the template default 0.25cm is a tight fit for the D5 marker).
* `--out new.tex` writes to another file instead of updating in place.

The caption and instruction box in the chapter contain fixed text (week counts, number of grey columns)
that is not updated automatically.
