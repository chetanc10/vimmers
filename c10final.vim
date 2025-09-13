
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
	" setup keymap to invoke certain fzf features
	nnoremap <C-f>f  :Files<CR>
	nnoremap <C-f>gf :GFiles<CR>
	nnoremap <C-f>l  :Lines<CR>
	nnoremap <C-f>bl :BLines<CR>
	nnoremap <C-f>c  :Commits<CR>
	nnoremap <C-f>bc :BCommits<CR>
	nnoremap <C-f>m  :Maps<CR>
	nnoremap <C-f>h  :History<CR>
	nnoremap <C-f>rg :Rg <C-R>=expand("<cword>")<CR><CR>
	" Disable preview for fzf Files 
	let g:fzf_files_options = '--no-preview'
	" Make the layout display the prompt at the top of the results
    let $FZF_DEFAULT_OPTS = '--layout=reverse'
endif

if exists('g:loaded_session')
	" If 'vim-session' loaded, do post-load configuration and setup keymaps
	let g:session_autoload = 'no'
	let g:session_autosave = 'no'

	" Try open 'repo_name'-'branch_name'.vim session if git project
	" On failure, try 'dir_name'-Session.vim, if that fails, do nothing
	nnoremap <silent> <leader>so :call OpenSessionProj()<CR>
    function! OpenSessionProj()
		if system('git rev-parse --is-inside-work-tree 2>&1') =~ 'true'
			let branch_name = system('git rev-parse --abbrev-ref HEAD')
            let branch_name = trim(substitute(branch_name, '/', '_', 'g'))
            let repo_name = trim(system('basename $(git rev-parse --show-toplevel)'))
			let sname = '~/.vim/sessions/' . repo_name . '-' . branch_name . '.vim'
			if filereadable(expand(sname))
				execute 'OpenSession ' . repo_name . '-' . branch_name
				return
			endif
        endif
		" pwd is not git repo or has no branch-session, try Session.vim
		let sname = '~/.vim/sessions/' . fnamemodify(getcwd(), ':t') . '.Session.vim'
		if filereadable(expand(sname))
			execute 'OpenSession ' . substitute(fnamemodify(sname, ':t'), '\.vim$', '', '')
		endif
    endfunction

	" Delete session
	nnoremap <silent> <leader>sd :DeleteSession<CR>

	" Normal save session
	nnoremap <silent> <leader>ss :SaveSession<Space>

	" Try save 'repo_name'-'branch_name'.vim session if git project
	" On failure, save 'dir_name'-Session.vim
	nnoremap <silent> <leader>sg :call SaveSessionGitBranch()<CR>
	function! SaveSessionGitBranch()
		if system('git rev-parse --is-inside-work-tree 2>&1') =~ 'true'
			let branch_name = system('git rev-parse --abbrev-ref HEAD')
			let branch_name = trim(substitute(branch_name, '/', '_', 'g'))
			let repo_name = trim(system('basename $(git rev-parse --show-toplevel)'))
			execute 'SaveSession ' . repo_name . '-' . branch_name
		else
			let dname = fnamemodify(getcwd(), ':t')
			echo "Session not in git repo. Saving to " . dname . ".Session.vim..."
			execute 'SaveSession ' . dname . '.Session'
		endif
	endfunction

endif

if exists('g:loaded_fugitive')
	"""""""""""" Invoke fugitive Git command
	nnoremap <leader>g :Git<CR>
	"""""""""""" Show current git branch name
	nnoremap <leader>gb :Git rev-parse --abbrev-ref HEAD<CR><CR>
	"""""""""""" show all branch and highlight current branch
	nnoremap <leader>gba :echo system('git branch -a')<CR>
	"""""""""""" Stage (git add) current file
	nnoremap <leader>ga :Gwrite<CR>
	"""""""""""" Commit changes
	nnoremap <leader>gc :Git commit -s -v <CR>
	"""""""""""" Commit changes with message directly
	nnoremap <leader>gcm :Git commit -s -m<Space>
	"""""""""""" Revert current file (git checkout)
	nnoremap <leader>gco :Gread<bar>w<CR>
	"""""""""""" Open fugitive Git diff for current file in vertical split
	nnoremap <leader>gd :Gvdiffsplit<CR>
	"""""""""""" Open fugitive Git diff for repo in vertical split
	nnoremap <leader>gD :Git diff<CR>
	"""""""""""" Pull changes
	nnoremap <leader>gl :Git pull --rebase<CR>
	"""""""""""" Git log TODO fix git-log family not responding
	"nnoremap <leader>glt :Git log<CR>
	"nnoremap <leader>gll :Git log --graph --pretty=oneline --abbrev-commit<CR>
	"""""""""""" Open fugitive Git status
	nnoremap <leader>gs :Git status<CR>
	nnoremap <leader>gsm :Git status -uno<CR>
	nnoremap <leader>gss :Git status -s<CR>
	"""""""""""" Git config listing
	nnoremap <leader>gcfg :Git config -l<CR>
	"""""""""""" Push changes
	nnoremap <leader>gp :Git push<CR>
	"""""""""""" Git reset hard
	nnoremap <leader>grh :Git reset --hard<Space>
	"""""""""""" Show git remote url
	nnoremap <leader>grv :Git remote -v<CR>
	"""""""""""" Show git blame for the current line
	nnoremap <leader>gbl :Git blame<CR>
endif

if exists('g:loaded_fern')
	function! FernSmartOpen() abort
		return fern#smart#leaf(
					\ "\<Plug>(fern-action-open)",
					\ "\<Plug>(fern-action-expand)",
					\ "\<Plug>(fern-action-collapse)")
	endfunction

	augroup FernCustomMappings
		autocmd!
		autocmd FileType fern call SetupFernMappings()
	augroup END

	function! SetupFernMappings() abort
		" Map <CR> to smart open/expand/collapse using expression mapping
		execute 'nmap <buffer><expr> <CR> FernSmartOpen()'
		" Map 'x' to collapse folder instead of 'h'
		"autocmd FileType fern unmap h
		"autocmd FileType fern nnoremap <buffer> x <Plug>(fern-action-collapse)
		execute 'unmap <buffer> h'
		execute 'nnoremap <buffer> x <Plug>(fern-action-collapse)'
	endfunction

	let g:fern#renderer#default#leading = ' '
	let g:fern#renderer#default#collapsed_symbol = '+ '
	let g:fern#renderer#default#expanded_symbol = '- '
	let g:fern#disable_viewer_smart_cursor = 1
	let g:fern#renderer#default#leaf_symbol = ". "

	nnoremap <leader>F :Fern . -drawer -toggle<CR>
endif

" USER defined final customizations are sourced using ~/.cvimrc
" User keymaps, functions, settings, etc shall be kept in ~/.cvimrc
" Note: vim-plug based setup is done using 'vimplugs' bash command
if filereadable(expand("~/.cvimrc"))
    source ~/.cvimrc
endif
