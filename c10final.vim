
" Decrease the timeoutlen to help faster keymap handling
set timeoutlen=200

" comments.vim uses Ctrl-C and Ctrl-X for comment/uncomment (WIERD!)
" Ctrl-X default behaviour in vim is to decrement a number by 1
" So we override comments.vim controls with Ctrl-k and Ctrl-k-u

" unmap Ctrl-C/X first
nunmap <C-c>
nunmap <C-x>
noremap  <silent> <C-k> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-k> :call RangeCommentLine()<CR>
" key-mappings for un-comment line in normal mode
noremap  <silent> <C-k><C-u> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-k><C-u> :call RangeUnCommentLine()<CR>
