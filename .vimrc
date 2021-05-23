set backspace=2

set pastetoggle=<F2>
set foldcolumn=0
set shell=/bin/sh

" set ignorecase
" set smartcase

" fold

if !has('nvim')
    set ttymouse=xterm2
endif

set mouse=a

" .mac -> TCL
au BufRead,BufNewFile *.mac set ft=tcl

" .t -> PERL
au BufRead,BufNewFile *.t set ft=perl


" ---------------------------------------------------------------------------------------
" VIMPLUG
" ---------------------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" ---------------------------------------------------------------------------------------
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-sandwich'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'ryanoasis/vim-devicons'

Plug 'bronson/vim-trailing-whitespace'

" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'


Plug 'yggdroot/indentline'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'

Plug 'Konfekt/FastFold'


Plug 'hdima/python-syntax'

Plug 'elixir-editors/vim-elixir'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-obsession'

Plug 'vim-perl/vim-perl'

Plug 'sunaku/vim-dasht'
Plug 'FooSoft/vim-argwrap'

Plug 'osyo-manga/vim-over'
Plug 'machakann/vim-swap'
Plug 'AndrewRadev/switch.vim'
Plug 'justinmk/vim-sneak'

" Plug 'ludovicchabant/vim-gutentags'
Plug 'ap/vim-css-color'

Plug 'mbbill/undotree'
Plug 'thinca/vim-qfreplace'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'


" ---------------------------------------------------------------------------------------
" Initialize plugin system
call plug#end()




" ------------------------------------------------------------------------
"  COC
" ------------------------------------------------------------------------
" let g:coc_node_path = '/home/kduong/scratch/local/bin/node'

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=20

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" ------------------------------------------------------------------------
"  COC-SNIPPET
" ------------------------------------------------------------------------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


" ------------------------------------------------------------------------
"  Pressing HOME on indented line doesn't go to the front
" ------------------------------------------------------------------------
function ExtendedHome()
    let column = col('.')
        normal! ^
    if column == col('.')
        normal! 0
    endif
endfunction
noremap <silent> <Home> :call ExtendedHome()<CR>
inoremap <silent> <Home> <C-O>:call ExtendedHome()<CR>


" ------------------------------------------------------------------------
"  Basic settings
" ------------------------------------------------------------------------
syntax on
filetype plugin indent on
set number
set relativenumber

set tabstop=4
set shiftwidth=2
set expandtab

set clipboard=unnamedplus


let g:r_base_only=1


" ------------------------------------------------------------------------
"  AIRLINE
" ------------------------------------------------------------------------
" set termguicolors
let base16colorspace=256
" colorscheme base16-default-dark
" colorscheme base16-solarized-light
colorscheme base16-atelier-heath-light

" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

" let g:airline_theme='base16'
let g:airline_theme='minimalist'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols

" powerline symbols
let g:airline_left_sep = ''
" let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_sep = '\u25b6'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
"

let g:airline_section_a = airline#section#create(['mode',' ','branch'])

let g:airline#extensions#tabline#enabled = 1






" " ------------------------------------------------------------------------
" "  VIM Tmux navigator
" " ------------------------------------------------------------------------
" let g:tmux_navigator_no_mappings = 1
" "
" nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
" nnoremap <silent> <M-Down> :TmuxNavigateDown<cr>
" nnoremap <silent> <M-Up> :TmuxNavigateUp<cr>
" nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>
" " " nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>


" ------------------------------------------------------------------------
" FZF
" ------------------------------------------------------------------------

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-h': 'hsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
" POTENTIAL PROBLEM!
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <silent> <Leader>f :GitFiles<CR>
nnoremap <silent> <Leader>F :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>w :Windows<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>m :Marks<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>: :Commands<CR>
nnoremap <silent> <Leader>/ :History/<CR>



" ------------------------------------------------------------------------
" NERDcommentr
" ------------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


" ------------------------------------------------------------------------
"  Some short cut mapping
" ------------------------------------------------------------------------
" Tab switching
map <silent> <C-l> :tabn<CR>
map <silent> <C-j> :tabp<CR>

" Strip whitespace
nmap <silent> <leader><space> :FixWhitespace<CR>

" No highlight
map <silent> <leader>l :nohl<CR>

" Insert new line without editing
nmap <S-Enter> O<ESC>
nmap <CR> o<ESC>

" Deleleting words backward
nmap <C-d> diw
nmap <C-f> daw
imap <C-d> <C-[>diwi
imap <C-f> <C-[>dawi

" Delete line
imap <C-s> <C-[>ddi



" ------------------------------------------------------------------------
" Folding
" ------------------------------------------------------------------------
let r_syntax_folding = 1
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
map <F10> zO

function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()




" ------------------------------------------------------------------------
" Indent guide
" ------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
" let g:indentLine_char = '┆'
let g:indentLine_char = '│'
" f ¦, ┆, │, ⎸, or ▏ to
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 238


" ------------------------------------------------------------------------
" Alignment
" ------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------
" FAST FOLD
" ------------------------------------------------------------------------
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
" let g:markdown_folding = 1
" let g:tex_fold_enabled = 1
" let g:vimsyn_folding = 'af'
" let g:xml_syntax_folding = 1
" let g:javaScript_fold = 1
" let g:sh_fold_enabled= 7
" let g:ruby_fold = 1
" let g:perl_fold = 1
" let g:perl_fold_blocks = 1
" let g:r_syntax_folding = 1
" let g:rust_fold = 1
" let g:php_folding = 1
"
" let perl_sync_dist = 250
let perl_fold = 1
let perl_fold_anonymous_subs = 1
let perl_nofold_packages = 1
let perl_include_pod = 1
let perl_sub_signatures = 1

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

au VimEnter * RainbowParentheses


" ------------------------------------------------------------------------
" Press F4 to toggle highlighting on/off, and show current value.
" ------------------------------------------------------------------------
:noremap <F4> :set hlsearch! hlsearch?<CR>

" " let g:ycm_autoclose_preview_window_after_completion=1
" " map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" "
"
" set completeopt+=menuone
" set completeopt+=noselect
" set completeopt+=noinsert
"
" set shortmess+=c
" set belloff+=ctrlg
"
"
"
"
"
" " search related docsets
" nnoremap <Leader>k :Dasht<Space>
"
" " search ALL the docsets
" nnoremap <Leader><Leader>k :Dasht!<Space>
"
" " search related docsets
" nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
"
" " search ALL the docsets
" nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
"
" " search related docsets
" vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
"
" " search ALL the docsets
" vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>
"
" let g:dasht_filetype_docsets = {} " filetype => list of docset name regexp
"
" " For example: {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
"
"   " When in Elixir, also search Erlang:
"   let g:dasht_filetype_docsets['elixir'] = ['erlang']
"
"   " When in C++, also search C, Boost, and OpenGL:
"   let g:dasht_filetype_docsets['cpp'] = ['^c$', 'boost', 'OpenGL']
"
"   " When in Python, also search NumPy, SciPy, and Pandas:
"   let g:dasht_filetype_docsets['python'] = ['(num|sci)py', 'pandas']
"
"   " When in HTML, also search CSS, JavaScript, Bootstrap, and jQuery:
"   let g:dasht_filetype_docsets['html'] = ['css', 'js', 'bootstrap']
"
" " and so on... }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
"
"
"
"
"
" ------------------------------------------------------------------------
"Argwrap
" ------------------------------------------------------------------------
nnoremap <silent> <leader>a :ArgWrap<CR>


" ------------------------------------------------------------------------
" vim-over
" ------------------------------------------------------------------------
"
nnoremap <silent> <leader>s :OverCommandLine %s/<CR>
vnoremap <silent> <leader>s :<C-U>OverCommandLine '<,'>s/<CR>

nnoremap <silent> <leader>r :execute 'OverCommandLine %s/'.expand('<cword>').'/'<CR>


" ------------------------------------------------------------------------
" switch.vim
" ------------------------------------------------------------------------
let g:switch_mapping = '-'
let g:switch_custom_definitions =
    \ [
    \   ['FALSE', 'TRUE'],
    \   ['0', '1'],
    \   ['!=', '=='],
    \   ['yes', 'no'],
    \   ['Yes', 'No'],
    \   ['YES', 'NO']
    \ ]

" ------------------------------------------------------------------------
"  vim-sneak
" ------------------------------------------------------------------------
nmap ss <Plug>Sneak_s
nmap SS <Plug>Sneak_S
nmap sl <Plug>Sneak_s
nmap sj <Plug>Sneak_S
nmap s<Left> <Plug>Sneak_s
nmap s<Right> <Plug>Sneak_S

" ------------------------------------------------------------------------
"  undotree
" ------------------------------------------------------------------------
nnoremap <F5> :UndotreeToggle<cr>


" ------------------------------------------------------------------------
" ColumnColor
" ------------------------------------------------------------------------
set cc=90
hi ColumnColor ctermbg=22


" ------------------------------------------------------------------------
" PERLtidy
" ------------------------------------------------------------------------
autocmd FileType perl setlocal equalprg=perltidy\ -st
