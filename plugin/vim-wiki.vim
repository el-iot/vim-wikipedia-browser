function! MakeWindow(results)
  vnew
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete filetype=yaml

  let line_idx = 1

  " TODO: fix the path resolution
  let lines = readfile('/' . join(split(expand('<sfile>:p:h'), '/')[:-2], '/') . '/assets/header.txt')

  for line in lines
    call setline(line_idx, line)
    let line_idx = line_idx + 1
  endfor

  let b:results = a:results
  let b:results_line = line_idx

  for x in b:results
    call setline(line_idx, x['title'] . ': ' . x['snippet'])
    let line_idx = line_idx + 1
  endfor

  call cursor(b:results_line, 1)
  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! Scrape(query)
  " fix this trailing characters
  return eval(system("/home/el/personal/repos/vim-wiki/scrape " . a:query))
endfunction

function! VimWiki(query)
  let search_results = Scrape(a:query)
  call MakeWindow(search_results)
endfunction

command! -nargs=1 Wiki call VimWiki(<f-args>)
