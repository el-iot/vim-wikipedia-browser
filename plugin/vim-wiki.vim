function! MakeWindow(results)
  new
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete filetype=yaml

  let idx = 1
  let b:results = a:results

  for x in b:results
    call setline(idx, x['title'] . ': ' . x['snippet'])
    let idx = idx + 1
  endfor

  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! Scrape(query)
  " fix this trailing characters
  return eval(system("/home/el/personal/repos/vim-wiki/scrape " . a:query))
endfunction


function! VimWikiHelper(query)
  let search_results = Scrape(a:query)
  call MakeScratchBuffer(search_results)
endfunction

command! VimWiki call VimWikiHelper("elliot")
