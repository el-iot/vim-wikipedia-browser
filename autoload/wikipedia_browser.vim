let s:dir = '/' . join(split(expand('<sfile>:p:h'), '/')[:-2], '/')

function! GoToArticle()

  let page_data = b:vimwiki_search_lookup[getcurpos()[1]]
  let page_id = page_data['pageid']
  let title = page_data['title']
  let contents = system(s:dir . "/scripts/get_page.sh " . string(page_id))

  call ClearExistingBuffers()
  call MakePageBuffer(["== " . title . " =="] + split(contents, '\n'))

endfunction

function! ClearExistingBuffers()
  execute(":bd")
endfunction

function! FillWithContents(contents)

  let line_idx = 1
  for line in a:contents
    if line != ''
      call setline(line_idx, line)
      call setline(line_idx + 1, '')
      let line_idx += 2
    endif
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
    let line_idx += 1
  endfor
  return line_idx
endfunction

function! MakeScratchBuffer()
  vnew
  setlocal nobuflisted noswapfile wrap buftype=nofile bufhidden=delete filetype=mediawiki
endfunction

function! MakeSearchBuffer(results)

  call MakeScratchBuffer()

  let line_idx = MakeHeader()
  let s:results_line = line_idx
  let b:vimwiki_search_lookup = {}

  for [_, x] in items(a:results)
    call setline(line_idx, x['title'] . ': ' . x['extract'])
    let b:vimwiki_search_lookup[line_idx] = {'pageid': x['pageid'], 'title': x['title']} " store for later
    let line_idx += 1
  endfor

  call cursor(s:results_line, 1)
  nnoremap <buffer> <silent> <CR> :call GoToArticle()<cr>

  syntax match WikiKey   /\v^[^:]+:/
  highlight WikiKey ctermfg=cyan

  setlocal nomodifiable " only make non-modifiable after everything has already been written

endfunction

function! Search(query)
  return json_decode(system(s:dir . "/scripts/search.sh " . a:query)) " call external script
endfunction

function! wikipedia_browser#WikipediaSearch(query)
  call MakeSearchBuffer(Search(a:query))
endfunction
