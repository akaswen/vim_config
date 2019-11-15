cnoreabbrev adr call FormatAdr()

function! FormatAdr()
  echom 'setting up adr'
  normal! ggdG
  normal! i---
  normal! otitle: title
  normal! ostatus: status
  execute "normal! odate: " . strftime("%Y-%m-%d")
  normal! o---
  normal! o
  normal! o## Context and Problem Statement
  normal! o
  normal! o## Considered Options
  normal! o
  normal! o## Decision and Outcome
  normal! o
  normal! o### Positive Consequences
  normal! o
  normal! o### Negative Consequences
  normal! o
  normal! o## Pros and Cons of the Options
  normal! o
  normal! gg
endfunction
