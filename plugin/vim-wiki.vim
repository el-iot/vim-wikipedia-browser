let s:dir = '/' . join(split(expand('<sfile>:p:h'), '/')[:-2], '/')

function! GoToArticle()
  let title = b:vimwiki_search_lookup[getcurpos()[1]] " get the title under the cursor
  let contents = system(s:dir . "/scripts/api " . "scrape " . title)
  call MakePageBuffer(split(contents, '\n'))
endfunction

function! FillWithContents(contents)
  let line_idx = 1
  for line in a:contents
    call setline(line_idx, line)
    let line_idx = line_idx + 1
  endfor
endfunction

function! MakePageBuffer(contents)
  call MakeScratchBuffer()
  call FillWithContents(a:contents)
  setlocal nomodifiable " only make non-modifiable after everything has already been written
endfunction

function! MakeHeader()
  let line_idx = 1
  for line in readfile(s:dir . '/assets/header.txt')
    call setline(line_idx, line)
    let line_idx = line_idx + 1
  endfor
  return line_idx
endfunction

function! MakeScratchBuffer()
  vnew
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete
endfunction

function! MakeSearchBuffer(results)

  call MakeScratchBuffer()

  nnoremap <buffer> <silent> <CR> :call GoToArticle()<cr>

  let line_idx = MakeHeader()

  let s:results_line = line_idx
  let b:vimwiki_search_lookup = {}

  for [_, x] in items(a:results)
    call setline(line_idx, x['title'] . ': ' . x['extract'])
    let b:vimwiki_search_lookup[line_idx] = x['title'] " store for later
    let line_idx = line_idx + 1
  endfor

  call cursor(s:results_line, 1)
  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! Search(query)
  return json_decode(system(s:dir . "/scripts/search.sh " . a:query)) " call external script
endfunction

function! VimWikipediaSearch(query)
  call MakeSearchBuffer(Search(a:query))
endfunction

command! -nargs=1 WikiSearch call VimWikipediaSearch(<f-args>)
