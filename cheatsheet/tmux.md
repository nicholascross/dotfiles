# TMUX

Command prompt `ctrl + b` `:`

## Sessions

List

```
tmux ls
```

Create

```
tmux new -s <SESSION_NAME>
```

Attach

```
tmux a -t <SESSION_NAME>
```

Kill

```
tmux kill-session -t <SESSION_NAME>
```

Rename session `ctrl + b` `$`

Detach `ctrl + b` `d`

## Navigation

Switch session `Ctrl + b` `w`

Previous session `ctrl + b` `(`

Next session `ctrl + b` `)`

Next pane `ctrl + b` `;`

Select pane `ctrl + b` `q` `<NUMBER>`

Close pane `ctrl + b` `x`

## Copy mode

Enter copy mode `Ctrl + b` `[`

Start selection `Space`

Clear selection `Escape`

Copy selection `Enter`

Selection with vim motion style hjkl

`/` Search forward, `?` Search backward

Paste `ctrl + b` `]`


