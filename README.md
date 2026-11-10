# Exercise: The Moving-Day List

Exercise code for the lesson **Exercise: The Moving-Day List** in PowerShell in Depth on [ask-codey.com](https://www.ask-codey.com).

You've moved into apartment 4B. The movers left a mess in the hallway, your smart speaker still has your old address, and the to-do list keeps growing. You'll clear up and write your lists with PowerShell, and a Pester check tells you which jobs are done.

## What's here

- `apartment/`: your new apartment's files. This is the folder you work in.
- `Check.Tests.ps1`: the check that looks at the apartment folder. You don't need to change it.

## What to do

Open PowerShell 7, go into this folder with `Set-Location`, then into `apartment`. Do each job with the commands from the *Deleting, Writing and Editing* chapter: `Remove-Item` (with `-WhatIf` first), `Set-Content`, `Add-Content`, `>` and `>>`, `edit`, and `Get-Content` with `-TotalCount` and `-Tail`.

1. Throw out the broken vase and the bubble wrap: `hallway\broken-vase.txt` and `hallway\bubble-wrap.txt`. The spare key and the lamp stay.
2. Get rid of the flattened boxes: the folder `hallway\cardboard`, with everything in it. The hallway itself stays.
3. Make a sign for the door: a new file, `door-sign.txt`, with one line: `Apartment 4B`.
4. Add the line `- water the plants` to the end of `todo.txt`, keeping the three lines it has.
5. Your smart speaker still has your old address. Open `speaker-settings.ini` with `edit` and change its last line to `address=48 Maple Avenue, Apt 4B`, keeping the other lines as they are.
6. Save the first three lines of `packing-list.txt` into a new file, `unpack-first.txt`, with one command.
7. The last line of `movers.log` says where box 14 ended up. Add that line to the end of `todo.txt`, with one command, so you remember to fetch it.

Make every new file inside `apartment`, next to `todo.txt`.

## Check your work

The check needs Pester 5 or newer. Install it once, if you haven't already:

```powershell
Install-PSResource Pester
```

Then, from this folder (the one with `Check.Tests.ps1` in it, not `apartment`):

```powershell
Invoke-Pester
```

At first every test fails: that is expected. Each job you do turns its test green. A failing test's message says which job it is and what it looked for.

If PowerShell says the check *cannot be loaded because running scripts is disabled* or *is not digitally signed*, the folder came from a download that Windows marked as from the internet. Unblock its files once with `Get-ChildItem -Recurse | Unblock-File`, from this folder, and run `Invoke-Pester` again. *Why a Script Won't Run: The Execution Policy*, in Module 5, explains what that does.

## Tips

- Rehearse every delete with `-WhatIf`, then press the up arrow, take `-WhatIf` off and press Enter.
- `Set-Content` and `>` replace a whole file; `Add-Content` and `>>` add to its end. If you replace `todo.txt` by mistake, get a fresh copy of it from the download and start that job again.
- Look at a file with `Get-Content` after you change it.

## Hand it in

When it works, push your solution to a public repo of your own on GitHub, then paste that repo's address into **Submit your exercise** on the lesson page at [ask-codey.com](https://www.ask-codey.com). That's what completes the lesson. The lesson page shows the Git commands, step by step.
