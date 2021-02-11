" Para que funcione bien vimwiki
set nocompatible    " be iMproved, required
filetype plugin on  " required
syntax on

" Agregar antes de cuando use <leader>
let mapleader = " "

"Para ver bien la letra itálica.
set t_ZH=[3m
set t_ZR=[23m

" Spell checking
set spell spelllang=en

"Arreglar tecla Backspace no borra cuando salgo de insert mode y vuelvo a
"entrar
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Markdown Pandoc
"https://github.com/vim-pandoc/vim-pandoc-syntax
"Plugin 'vim-pandoc/vim-pandoc-syntax'

"Markdown plasticboy (https://github.com/plasticboy/vim-markdown)
Plugin 'plasticboy/vim-markdown'

"Align text when needed
" (http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)
Plugin 'godlygeek/tabular'

"FuzzyFider
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
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


"----------------------- VimWiki  ----------------------------------
" Settings for VimWiki
let g:vimwiki_list = [{'path':'~/scratchbox/vimwiki/zettelkasten/','ext':'.md','syntax':'markdown'}]
let g:vimwiki_autowriteall = 1
let g:vimwiki_folding = ''

"no se si hace falta especificar conceal level
set conceallevel=2 

" Handle Zotero links
function! VimwikiLinkHandler(link)
   "if link starts with 'zotero:'
   if a:link =~# 'zotero:'
    try
      "Open file in Zotero. Can't make it work with 'silent'
      execute "!open -a Zotero " . shellescape(a:link)
      return 1
    catch
      echo "Something went wrong..."
      echo error 
    endtry
  endif
  return 0
endfunction

" Open link in split window
nmap <Leader><CR> <Plug>VimwikiVSplitLink

"----------------------------- vim-zettel Zettelkasten ------------------------------------
"------------------------------------------------------------------------------------------

" FZF ZETTEL
"All these flags are gripgrep (rg) flags, not fzf's.
let g:zettel_fzf_command = "rg --column --line-number --smart-case --multiline --no-heading --color=always --regexp '^title: (.+)' --replace '$1'"
" --smart-case: si escribo en minúscula, ignora el case. Si agrego mayúsculas, lo tiene en cuenta.
" --regexp: '^title' it's an 'Anchored-match' (fzf will search for the lines
"  that start with the given string). And '(.+)' is a regular expression to
"  extend the match to any match that starts with title and continues with
"  anything.
" --replace: Replaces the output or ripgrep. In this case, replaces the first
"  word ($1) wiht nothing. It doesn't modify the file, just the output. 

"All these flags are fzf flags
let g:zettel_fzf_options = ['--with-nth=-1']
" --with-nth: Changes the output to show certain fields indes expressions. In
"  this case, the last field (-1). In practice, this changes the output of fzf
"  to only show the title of the ZK note in the list.

let g:nv_search_paths = ['~/scratchbox/vimwiki/zettelkasten']

"I can't change the layout... this doesn't work
let g:fzf_layout = { 'up': '~60%' }


let g:zettel_format = "%y%m%d%H%M"
let g:zettel_options = [{"template" :  "~/scratchbox/vimwiki/template1.tpl", "disable_front_matter" : 1}]

let g:zettel_default_mappings = 0
" This is basically the same as the default configuration
augroup filetype_vimwiki
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
  autocmd FileType vimwiki nmap <leader>o <Plug>ZettelOpen
augroup END


"Insert Backlinks
nnoremap <leader>d :ZettelBackLinks<CR>
"Change word to tag 
nnoremap <leader>t bi:<ESC>t<Space>a:<ESC> 

"-------------------------------  Markdown (Pandoc)  --------------------------------------
"------------------------------------------------------------------------------------------

" TODO: ver cómo hacer para poder usar pandoc (descomentar para usar) pero sin
" que se me sobreescriban los colores de las tags y backlinks.
" Syntax de Pandoc: https://pandoc.org/MANUAL.html#pandocs-markdown
"
"Leer los documentos de Markdown con Pandoc
"augroup pandoc_syntax
"  autocmd! FileType vimwiki set syntax=markdown.pandoc
"augroup END
"
"let g:pandoc#syntax#conceal#use = 0
"let g:pandoc#syntax#conceal#urls = 1

"let g:pandoc#syntax#conceal#blacklist = ['titleblock', 'block',]



"---------------------------------  QUICK SCOPE  ------------------------------------------
"------------------------------------------------------------------------------------------

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

"----------------------------------  Visual  ----------------------------------------------
"------------------------------------------------------------------------------------------

"Go to next line automatically when text reaches 80 characters
"(when refactoring, it's not that useful. The line stays below if I erase
"content on the top line, and only works on insert mode.)
"textwidth=80

"Wrap text, but remap everything to move like nowrap.
set wrap linebreak breakindent
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap 0 g0
vnoremap ^ g^
vnoremap $ g$

"set relativenumber
set nu
set smartcase
set termguicolors
set incsearch
"
set colorcolumn=92
"highlight ColorColumn ctermbg=0 guibg=lightgrey
"
autocmd vimenter * colorscheme gruvbox
"au Colorscheme * hi! link markdownLinkText GruvboxOrangeBold

"------------------------------  Window Management   --------------------------------------
"------------------------------------------------------------------------------------------

set splitright

"Move between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"----------------------------------  Escribir  --------------------------------------------
"------------------------------------------------------------------------------------------

"Para poder pegar lo último que copié, aunque haya eliminado cosas después.
nnoremap <leader>p "0p
nnoremap <leader>P "0P

nnoremap ; :
nnoremap : ; 
