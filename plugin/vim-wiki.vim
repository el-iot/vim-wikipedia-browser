function! GoToArticle()
  let  linenum = getcurpos()[1]
  let title = b:vimwiki_search_lookup[linenum]
  let contents = eval(system("/home/el/personal/repos/vim-wiki/scrape " . title))['parse']['wikitext']['*']
  call MakePageWindow(split(contents, '\n'))
  endfor

endfunction

function! MakePageWindow(contents)
  vnew
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete filetype=yaml

  let line_idx = 1

  for line in a:contents
    call setline(line_idx, line)
    let line_idx = line_idx + 1
  endfor

  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! MakeSearchWindow(results)
  vnew
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete filetype=yaml
  nnoremap <buffer> <silent> <CR> :call GoToArticle()<cr>

  let line_idx = 1

  " TODO: fix the path resolution
  let lines = readfile('/' . join(split(expand('<sfile>:p:h'), '/')[:-2], '/') . '/assets/header.txt')

  for line in lines
    call setline(line_idx, line)
    let line_idx = line_idx + 1
  endfor

  let s:results_line = line_idx
  let b:vimwiki_search_lookup = {}

  for x in a:results
    call setline(line_idx, x['title'] . ': ' . x['extract'])
    let b:vimwiki_search_lookup[line_idx] = x['title'] " store for later
    let line_idx = line_idx + 1
  endfor

  call cursor(s:results_line, 1)
  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! Search(query)
  " TODO: fix trailing characters
  return eval(system("/home/el/personal/repos/vim-wiki/search " . a:query))
endfunction

function! VimWiki(query)
  let search_results = Search(a:query)
  call MakeSearchWindow(search_results)
endfunction

command! -nargs=1 Wiki call VimWiki(<f-args>)
