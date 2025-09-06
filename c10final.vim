
" Decrease the timeoutlen to help faster keymap handling
set timeoutlen=300

if exists("loaded_comments_plugin")
	" comments.vim uses Ctrl-C and Ctrl-X for comment/uncomment (WEIRD!)
	" Ctrl-X default behaviour in vim is to decrement a number by 1
	" So we override comments.vim controls with Ctrl-k and Ctrl-k-u
	nunmap <C-c>
	nunmap <C-x>
	vunmap <C-c>
	vunmap <C-x>
	noremap  <silent> <C-k> :call CommentLine()<CR>
	" key-mappings for range comment lines in visual <Shift-V> mode
	vnoremap <silent> <C-k> :call RangeCommentLine()<CR>
	" key-mappings for un-comment line in normal mode
	noremap  <silent> <C-k><C-u> :call UnCommentLine()<CR>
	" key-mappings for range un-comment lines in visual <Shift-V> mode
	vnoremap <silent> <C-k><C-u> :call RangeUnCommentLine()<CR>
endif

" vim-cscope keymaps to ':cs find X ' to avoid typing cscope find command
nnoremap <leader>cs :cs find s<Space>
nnoremap <leader>cg :cs find g<Space>
nnoremap <leader>cc :cs find c<Space>
nnoremap <leader>ct :cs find t<Space>
nnoremap <leader>ce :cs find e<Space>
nnoremap <leader>cf :cs find f<Space>
nnoremap <leader>ci :cs find i<Space>
nnoremap <leader>cd :cs find d<Space>
nnoremap <leader>ca :cs find a<Space>

if exists('g:loaded_fzf_vim')
	" If fzf.vim is loaded, setup keymap to invoke certain features
	nnoremap <C-f>f :Files<CR>
	nnoremap <C-f>gf :GFiles<CR>
	nnoremap <C-f>l :Lines<CR>
	nnoremap <C-f>bl :BLines<CR>
	nnoremap <C-f>c :Commits<CR>
	nnoremap <C-f>bc :BCommits<CR>
	nnoremap <C-f>m :Maps<CR>
	nnoremap <C-f>h :History<CR>
endif

if exists('g:loaded_session')
	" If 'vim-session' loaded, do post-load configuration and setup keymaps
	let g:session_autoload = 'no'
	let g:session_autosave = 'no'

	nnoremap <leader>so :OpenSession<Space>
	nnoremap <leader>ss :SaveSession<Space>
	nnoremap <leader>sd :DeleteSession<CR>
	nnoremap <leader>sg :call SaveSessionGitBranch()<CR>
	function! SaveSessionGitBranch()
		let branch_name = system('git rev-parse --abbrev-ref HEAD')
		if empty(branch_name)
			echoerr "Current session is no under a git repo!"
			return
		endif
		let repo_name = system('basename $(git rev-parse --show-toplevel)')
		let repo_name = substitute(repo_name, '\n', '', '')
		let branch_name = substitute(branch_name, '\n', '', '')
		let branch_name = substitute(branch_name, '/', '_', 'g')
		execute 'SaveSession ' . repo_name . '-' . branch_name
	endfunction
endif

" USER defined final customizations are sourced using ~/.cvimrc
" User keymaps, functions, settings, etc shall be kept in ~/.cvimrc
" Note: vim-plug based setup is done using 'vimplugs' bash command
if filereadable(expand("~/.cvimrc"))
    source ~/.cvimrc
endif
