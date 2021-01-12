" Para que funcione bien vimwiki
set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

" Agregar antes de cuando use <leader>
let mapleader = " "

"Para ver bien la letra itálica.
set t_ZH=[3m
set t_ZR=[23m

" Spell checking
set spell spelllang=en,es

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Markdown
"https://github.com/vim-pandoc/vim-pandoc-syntax
"Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"FuzzyFider
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Zettelkasten
Plugin 'vimwiki/vimwiki'
Plugin 'michal-h21/vim-zettel'

"Tema
Plugin 'morhetz/gruvbox'

"Sincronizar automáticamente GitHub
Plugin 'michal-h21/vimwiki-sync'

Plugin 'https://github.com/alok/notational-fzf-vim'

" Marcar con color la primera ocurrencia de una letra al apretar "f" o "t"
Plugin 'unblevable/quick-scope'

" Barra de información
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Medir uso de VIM con ActivityWatcher
Plugin 'ActivityWatch/aw-watcher-vim'

call vundle#end()            " required
filetype plugin indent on    " required


"----------------------- VimWiki Zettelkasten ----------------------------------
" Settings for VimWiki
let g:vimwiki_list = [{'path':'~/scratchbox/vimwiki/zettelkasten/','ext':'.md','syntax':'markdown'}]
let g:vimwiki_autowriteall = 1
set conceallevel=2 
"let g:vim_markdown_conceal = 1


"-------------------------------
let g:zettel_fzf_command = "rg --column --line-number --smart-case --multiline \--no-heading --color=always "
" --smart-case: si escribo en minúscula, ignora el case. Si agrego mayúsculas,
"  lo tiene en cuenta.
let g:zettel_fzf_options = ['--exact', '--tiebreak=end']
"-------------------------------


let g:zettel_format = "%y-%m-%d_%H%M_%title"
let g:zettel_options = [{"template" :  "~/scratchbox/vimwiki/template1.tpl"}]
let g:nv_search_paths = ['~/scratchbox/vimwiki/zettelkasten']

"insertar Backlinks
nnoremap <leader>d :ZettelBackLinks<CR>
"Abrir una nota
nnoremap <leader>o :ZettelOpen<CR>
" Convertir palabra en tag
nnoremap <leader>t bi:<ESC>t<Space>a:<ESC> 


"-------------------------  Markdown (Pandoc)  ---------------------------------

" TODO: ver cómo hacer para poder usar pandoc (descomentar para usar) pero sin
" que se me sobreescriban los colores de las tags y backlinks.
" Syntax de Pandoc: https://pandoc.org/MANUAL.html#pandocs-markdown
"
"Leer los documentos de Markdown con Pandoc
"augroup pandoc_syntax
"  autocmd! FileType vimwiki set syntax=markdown.pandoc
"augroup END



"-----------------------------  QUICK SCOPE  ----------------------------------------

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"TODO: Ver porqué con Vim no funciona 'guifg' pero en nvim sí.
"Poner antes de colorscheme
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_max_chars=150

"-----------------------------  Visual  ----------------------------------------
set relativenumber
set nowrap
set smartcase
set termguicolors
set incsearch
"
set colorcolumn=92
highlight ColorColumn ctermbg=0 guibg=lightgrey
"
autocmd vimenter * colorscheme gruvbox

"-----------------------------  Escribir  ----------------------------------------

"Para poder pegar lo último que copié, aunque haya eliminado cosas después.
nnoremap <leader>p "0p
nnoremap <leader>P "0P

nnoremap ; :
nnoremap : ; 
