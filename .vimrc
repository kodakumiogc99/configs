let data_dir = '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-python/python-syntax'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'lervag/vimtex'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'ntpeters/vim-better-whitespace'
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'gelguy/wilder.nvim'

" Markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"Vim Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

call plug#end()

filetype plugin indent on
syntax enable

set nocompatible
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set mouse=a
set nowrap
set hlsearch

nnoremap <C-h> <Left>
nnoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap <Leader>n :nohl<CR>

" onedark
colorscheme onedark
let g:airline_theme='onedark'
unlet g:terminal_ansi_colors

set cursorline
highlight CursorLine ctermbg=243
highlight CursorLineNR ctermfg=208
highlight Visual ctermbg=darkgray
highlight Normal ctermbg=None
highlight SignColumn ctermbg=None
highlight LineNr ctermbg=None ctermfg=5
highlight Terminal ctermbg=None
highlight Comment ctermfg=14
highlight CocErrorHightlight ctermfg=9
highlight CocWarningHightlight ctermfg=11

" vim-airline
let g:airline#extensions#scrollbar#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#keymap#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#entensions#hunks#enabled=1
let g:airline#extensions#hunks#coc_git=1

" vim-clap
nnoremap <silent> <space><space> :Clap files<CR>
nnoremap <silent> <C-f> :Clap filer<CR>
nnoremap <silent> <C-g> :Clap commits<CR>
nnoremap <silent> <C-y> :Clap yanks<CR>
nnoremap <silent> <C-m> :Clap maps<CR>
nnoremap <silent> <C-p> :Clap buffers<CR>
nnoremap <silent> <C-t> :silent! Clap tags coc<CR>
nnoremap <silent> <C-q> :bdelete<CR>
nnoremap <silent> <Leader>j :Clap dumb_jump<CR>

inoremap <silent> <C-f> <ESC>:Clap files<CR>
inoremap <silent> <C-p> <ESC>:Clap buffers<CR>
inoremap <silent> <C-t> <ESC>:silent! Clap tags coc<CR>

" nerdtree
nnoremap <silent> <space><space><space> :NERDTreeToggle<CR>

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDToggleCheckAllLines=1
let g:NERDCreateDefaultMappings=0
autocmd FileType python let g:NERDSpaceDelims=0

nnoremap <silent> <Leader>cc :call nerdcommenter#Comment("n", "Toggle")<CR>
vnoremap <silent> <Leader>cc :call nerdcommenter#Comment("n", "Toggle")<CR>

" python-syntax
let g:python_highlight_all=1

" coc.nvim
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=100
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions=['coc-clangd', 'coc-pyright', 'coc-sh', 'coc-git', 'coc-highlight', 'coc-cmake', 'coc-json', 'coc-yaml', 'coc-snippets', 'coc-vimlsp']

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> ? :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

inoremap <silent><expr> <C-e>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

let g:coc_snippet_next='<C-e>'

nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Down>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Up>"

nmap <silent> <F12> <Plug>(coc-definition)
nmap <F2> <Plug>(coc-rename)

nmap <Leader>gp <Plug>(coc-git-prevchunk)
nmap <Leader>gn <Plug>(coc-git-nextchunk)
nmap <Leader>gg <Plug>(coc-git-chunkinfo)

" vim-floaterm
let g:floaterm_keymap_new='<Leader>fn'
let g:floaterm_keymap_kill='<Leader>fk'
let g:floaterm_keymap_toggle='<Leader>ft'

" vim-autoformat
noremap <F4> :Autoformat<CR>

let g:formatdef_autopep8='"autopep8 - --max-line-length=200"'

" indentLine
let g:indentLine_char='|'
let g:indentLine_fileTypeExclude=['dockerfile', 'tex', 'json']

" wilder.nvim
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline(),
            \     wilder#search_pipeline(),
            \   ),
            \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#basic_highlighter(),
            \ 'highlights': {
                \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
                \ },
                \ }))

"" Set Markdown previewer
" set to 1, nvim will open the preview window after entering the markdown
" buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:fals
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {},
            \ 'flowchart_diagrams': {},
            \ 'content_editable': v:false,
            \ 'disable_filename': 0
            \ }

" use a custom markdown style must be absolute path
" like'/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

""Mappings
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

""Vim markdown hightlight to fold like python style
let g:vim_markdown_folding_disabled = 1
""To prevent foldtext from being set
let g:vim_markdown_override_foldtext = 0
""Enable TOC window auto-fit
let g:vim_markdown_toc_autofit = 1
""Set concealevel
set conceallevel=2
""To disable math conceal with LaTex math syntax enabled
let g:tex_conceal = ""
let g:vim_markdown_math = 1
""Disabling conceal for code fences
let g:vim_markdown_conceal_code_blocks = 0

