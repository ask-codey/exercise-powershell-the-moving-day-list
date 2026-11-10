# Checks the apartment folder, one test per job in README.md.
# Run it from this folder with: Invoke-Pester
# You don't need to change this file.

BeforeAll {
    $script:apartment = Join-Path $PSScriptRoot 'apartment'

    # A file's lines, with spaces trimmed off the ends; an empty list if the file isn't there.
    function Get-Lines([string] $name) {
        $path = Join-Path $script:apartment $name
        if (-not (Test-Path $path -PathType Leaf)) { return @() }
        @(Get-Content $path | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' })
    }

    $script:firstTodo = '- unpack the kitchen', '- find the TV remote', '- say hi to the neighbors'
}

Describe 'Exercise: The Moving-Day List' {

    It '1) the broken vase and the bubble wrap are thrown out, and the key and the lamp are kept' {
        Join-Path $apartment 'hallway\broken-vase.txt' | Should -Not -Exist -Because 'job 1 removes hallway\broken-vase.txt with Remove-Item (try it with -WhatIf first)'
        Join-Path $apartment 'hallway\bubble-wrap.txt' | Should -Not -Exist -Because 'job 1 removes hallway\bubble-wrap.txt too'
        Join-Path $apartment 'hallway\spare-key.txt' | Should -Exist -Because 'the spare key stays. If a wildcard took it, the starter in a fresh download has it again'
        Join-Path $apartment 'hallway\lamp.txt' | Should -Exist -Because 'the lamp stays in the hallway'
    }

    It '2) the cardboard folder is gone, and the hallway is still there' {
        Join-Path $apartment 'hallway\cardboard' | Should -Not -Exist -Because 'job 2 removes hallway\cardboard and the boxes in it, which needs -Recurse'
        Join-Path $apartment 'hallway' | Should -Exist -Because 'only the cardboard goes: the hallway folder stays'
    }

    It '3) door-sign.txt says Apartment 4B' {
        Join-Path $apartment 'door-sign.txt' | Should -Exist -Because 'job 3 writes door-sign.txt in the apartment folder with Set-Content'
        Get-Lines 'door-sign.txt' | Should -Be @('Apartment 4B') -Because 'the sign has one line, exactly Apartment 4B'
    }

    It '4) "- water the plants" is on the to-do list, after the three lines it had' {
        $todo = Get-Lines 'todo.txt'
        $todo.Count | Should -BeGreaterThan 2 -Because 'todo.txt should still have its first three lines. If they are gone, Set-Content or > replaced the file: get a fresh copy of todo.txt and use Add-Content or >>'
        $todo[0..2] | Should -Be $firstTodo -Because 'the list keeps its first three lines, in order'
        $todo | Should -Contain '- water the plants' -Because 'job 4 adds the line - water the plants with Add-Content'
    }

    It '5) the speaker has the new address' {
        $settings = Get-Lines 'speaker-settings.ini'
        $settings | Should -Contain 'address=48 Maple Avenue, Apt 4B' -Because 'job 5 changes the address line in speaker-settings.ini with edit'
        $settings | Should -Not -Contain 'address=12 Elm Street, Apt 3' -Because 'the old address line goes'
        $settings | Should -Be @('[speaker]', 'name=Living Room', 'volume=40', 'address=48 Maple Avenue, Apt 4B') -Because 'only the address changes; the other three lines stay as they were'
    }

    It '6) unpack-first.txt holds the first three lines of the packing list' {
        Join-Path $apartment 'unpack-first.txt' | Should -Exist -Because 'job 6 saves the packing list''s first three lines into unpack-first.txt, with Get-Content -TotalCount and >'
        Get-Lines 'unpack-first.txt' | Should -Be (Get-Lines 'packing-list.txt')[0..2] -Because 'the file holds the first three lines of packing-list.txt, and nothing else'
    }

    It '7) the last line of the movers'' log is on the to-do list' {
        $last = (Get-Lines 'movers.log')[-1]
        Get-Lines 'todo.txt' | Should -Contain $last -Because 'job 7 adds the last line of movers.log to the end of todo.txt, with Get-Content -Tail and >>'
    }
}
