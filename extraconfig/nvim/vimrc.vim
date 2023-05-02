








lua << EOF
-- Basic Config
vim.o.background = "light"
vim.cmd([[colorscheme gruvbox]])










-- NVIM-LSPCONFIG
require'lspconfig'.erlangls.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.ltex.setup{"markdown", "org"}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>d', vim.diagnostic.setloclist)
vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)

--Leave telescope single keypress:
-- local actions = require("telescope.actions")
-- require("telescope").setup({
--     defaults = {
-- 			layout_config = {
--       horizontal = {
--         preview_cutoff = 0,
--       },
--     },
--         mappings = {
--             i = {
--                 ["<esc>"] = actions.close,
--             },
--         },
--     },
-- })







-- Lualine
require('lualine').get_config()
require('lualine').setup()
options = { theme = 'gruvbox_light' }








-- TELESCOPE FILE BROWSER

-- open file_browser with the path of the current buffer
local builtin = require('telescope.builtin')


 vim.api.nvim_set_keymap(
   "n",
   "<space>f.",
   ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
   { noremap = true }
 )
 
-- open in home dir
 vim.api.nvim_set_keymap(
   "n",
   "<space>ff",
   ":Telescope file_browser path=~<CR>",
   { noremap = true }
 )


local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

-- telescope.load_extension('media_files')
-- telescope.load_extension('telescope_project')

telescope.setup {
  defaults = {
    color_devicons = true,
    prompt_prefix = " ",
    selection_caret = " ",

    mappings = {
		-- Insert mode mappings
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,


        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,


        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

	  -- Normal Mode Mappings
      n = {
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    },
    find_hidden = {
      hidden_files = true -- default: false
      }, -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local file_browser_actions = require("telescope").extensions.file_browser.actions



require("telescope").setup({
  extensions = {
    file_browser = {

      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
				["c"] = file_browser_actions.create,
				["y"] = file_browser_actions.copy,
				["m"] = file_browser_actions.move,
				["d"] = file_browser_actions.remove,
				["r"] = file_browser_actions.rename,

          -- your custom normal mode mappings
        },
      },
    },
  },
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
      },
    },
  },
})



require("telescope").load_extension "file_browser"






EOF










" VIMSCRIPT
set number relativenumber
nnoremap <SPACE> <Nop>
let mapleader = " "
set cursorline
"set cursorcolumn 
set colorcolumn=80 
set scrollbind
set nohlsearch
set background=light 
set tabstop=2
set shiftwidth=2
set expandtab
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Remove auto-comments
" Tab Completion?
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" WINDOWS/SPLITS:
" KEEP PERSISTENT SPLITS SIZE:
autocmd VimResized * wincmd =
" EASIER SPLIT NAVIGATION:
noremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>W
nnoremap <C-L> <C-W>w
" VIEW/split A FILE IN TWO COLLUMNS (leader+vs):
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>



" 

" Daniel CUSTOM settings/ KEYBINDINGS
"

"Save curosr position in a file
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 


" NEOVIM/Vim TERMINAL:
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
cd %:p:h
    if win_gotoid(g:term_win)
	hide
    else
	botright new
	exec "resize " . a:height
	try
	    exec "buffer " . g:term_buf
	catch
      call termopen($SHELL, {"detach": 0})
	    let g:term_buf = bufnr("")
	    set nonumber
	    set norelativenumber
	    set signcolumn=no
	endtry
	startinsert!
	let g:term_win = win_getid()
    endif
  cd -
endfunction


" Toggle terminal on/off (neovim)
nnoremap <leader>ot :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Leave terminal (this also makes ctrl-w not slow):
tnoremap <C-[> <C-\><C-n>



" Ignore Terminal exit code:
au TermClose * call feedkeys("i")



















" STARTIFY:
nnoremap <leader>st :Startify<CR>
let g:startify_session_dir = '~/.config/home-manager/extraconfig/nvim/sessions_nvim/'
let g:startify_session_persistence = 0
let g:startify_session_sort = 0

  let g:startify_lists = [
        \ { 'type': 'files', 'header': ['   Recent:'] },
		\ { 'type': 'sessions',  'header': ['   Projects/Workspaces']       },
	   \ { 'header': ['    Bookmarks'], 'type': 'bookmarks' },
        \ ]
  
if has("nvim")
 let g:startify_bookmarks = [
  \ { 's': '~/School/' },
  \ { 'p': '~/Projects/' },
  \ { 'h': '~/.config/home-manager/home.nix' },
  \ { 'v': '~/.config/home-manager/extraconfig/nvim/vimrc.vim' },
  \ ]
endif











let g:startify_custom_header_quotes = [
	\ ["Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.", '', '- Brian Kernighan'],
	\ ["If you don't finish then you're just busy, not productive."],
	\ ['Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.', '', '- Alan Perlis'],
	\ ['Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.', '', '- Alan Perlis'],
	\ ['It is easier to change the specification to fit the program than vice versa.', '', '- Alan Perlis'],
	\ ['Simplicity does not precede complexity, but follows it.', '', '- Alan Perlis'],
	\ ['Optimization hinders evolution.', '', '- Alan Perlis'],
	\ ['Recursion is the root of computation since it trades description for time.', '', '- Alan Perlis'],
	\ ['It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.', '', '- Alan Perlis'],
	\ ['There is nothing quite so useless as doing with great efficiency something that should not be done at all.', '', '- Peter Drucker'],
	\ ["If you don't fail at least 90% of the time, you're not aiming high enough.", '', '- Alan Kay'],
	\ ['I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.', '', '- Glyn Williams'],
	\ ['I would rather die of passion than of boredom.', '', '- Vincent Van Gogh'],
	\ ["The computing scientist's main challenge is not to get confused by the complexities of his own making.", '', '- Edsger W. Dijkstra'],
	\ ["Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.", '', '- Alan Kay'],
	\ ['The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.', '', '- Phil Wadler'],
	\ ['A good programmer is someone who always looks both ways before crossing a one-way street.', '', '- Doug Linder'],
	\ ['Patterns mean "I have run out of language."', '', '- Rich Hickey'],
	\ ['Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.', '', '- John Woods'],
	\ ['Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.'],
	\ ['There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.', '', '- C.A.R. Hoare'],
	\ ["If you don't make mistakes, you're not working on hard enough problems.", '', '- Frank Wilczek'],
	\ ["If you don't start with a spec, every piece of code you write is a patch.", '', '- Leslie Lamport'],
	\ ['Caches are bugs waiting to happen.', '', '- Rob Pike'],
	\ ['To iterate is human, to recurse divine.', '', '- L. Peter Deutsch'],
	\ ['Computers are useless. They can only give you answers.', '', '- Pablo Picasso'],
	\ ['The question of whether computers can think is like the question of whether submarines can swim.', '', '- Edsger W. Dijkstra'],
	\ ["It's ridiculous to live 100 years and only be able to remember 30 million bytes. You know, less than a compact disc. The human condition is really becoming more obsolete every minute.", '', '- Marvin Minsky'],
	\ ["The city's central computer told you? R2D2, you know better than to trust a strange computer!", '', '- C3PO'],
	\ ['Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.', '', '- Alan Kay'],
	\ ["I've finally learned what \"upward compatible\" means. It means we get to keep all our old mistakes.", '', '- Dennie van Tassel'],
	\ ["There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.", '', '- Jeremy S. Anderson'],
	\ ["The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.", '', '- Linus Torvalds'],
	\ ['Controlling complexity is the essence of computer programming.', '', '- Brian Kernighan'],
	\ ['Complexity kills. It sucks the life out of developers, it makes products difficult to plan, build and test, it introduces security challenges, and it causes end-user and administrator frustration.', '', '- Ray Ozzie'],
	\ ['The function of good software is to make the complex appear to be simple.', '', '- Grady Booch'],
	\ ["There's an old story about the person who wished his computer were as easy to use as his telephone. That wish has come true, since I no longer know how to use my telephone.", '', '- Bjarne Stroustrup'],
	\ ['There are only two industries that refer to their customers as "users".', '', '- Edward Tufte'],
	\ ['Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.', '', '- Larry Wall'],
	\ ['Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.', '', '- Eric S. Raymond'],
	\ ['Optimism is an occupational hazard of programming; feedback is the treatment.', '', '- Kent Beck'],
	\ ['First, solve the problem. Then, write the code.', '', '- John Johnson'],
	\ ['Measuring programming progress by lines of code is like measuring aircraft building progress by weight.', '', '- Bill Gates'],
	\ ["Don't worry if it doesn't work right. If everything did, you'd be out of a job.", '', "- Mosher's Law of Software Engineering"],
	\ ['A LISP programmer knows the value of everything, but the cost of nothing.', '', '- Alan J. Perlis'],
	\ ['All problems in computer science can be solved with another level of indirection.', '', '- David Wheeler'],
	\ ['Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.', '', '- Alan J. Perlis'],
	\ ['Easy things should be easy and hard things should be possible.', '', '- Larry Wall'],
	\ ['Nothing is more permanent than a temporary solution.'],
	\ ["If you can't explain something to a six-year-old, you really don't understand it yourself.", '', '- Albert Einstein'],
	\ ['All programming is an exercise in caching.', '', '- Terje Mathisen'],
	\ ['Software is hard.', '', '- Donald Knuth'],
	\ ['They did not know it was impossible, so they did it!', '', '- Mark Twain'],
	\ ['The object-oriented model makes it easy to build up programs by accretion. What this often means, in practice, is that it provides a structured way to write spaghetti code.', '', '- Paul Graham'],
	\ ['Question: How does a large software project get to be one year late?', 'Answer: One day at a time!'],
	\ ['The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.', '', '- Tom Cargill'],
	\ ["In software, we rarely have meaningful requirements. Even if we do, the only measure of success that matters is whether our solution solves the customer's shifting idea of what their problem is.", '', '- Jeff Atwood'],
	\ ['If debugging is the process of removing bugs, then programming must be the process of putting them in.', '', '- Edsger W. Dijkstra'],
	\ ['640K ought to be enough for anybody.', '', '- Bill Gates, 1981'],
	\ ['To understand recursion, one must first understand recursion.', '', '- Stephen Hawking'],
	\ ['Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.', '', '- Jon Acuff'],
	\ ['Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.', '', '- Patrick McKenzie'],
	\ ["The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.", '', '- Daniel J. Bernstein'],
	\ ['Walking on water and developing software from a specification are easy if both are frozen.', '', '- Edward V. Berard'],
	\ ['Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.', '', '- Aaron Swartz'],
	\ ['What one programmer can do in one month, two programmers can do in two months.', '', '- Frederick P. Brooks'],
	\ ]

function! Get_random_offset(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\.\zs\d\+')[1:]) % a:max
endfunction

" asciis sourced from the interwebs on free ascii sites,
" mostly from https://www.asciiart.eu/
let g:asciis = [
  \ [
  \ '               `;,;.;,;.;.`',
  \ '              ..:;:;::;: ',
  \ '        ..--``` `` ` ` ```--.  ',
  \ '      /. .   .         ..   .`\',
  \ '     | /    /            \   `.|',
  \ '     | |   :             :    :|',
  \ '   .`| |   :             :    :|',
  \ ' ,: /\ \.._\ __..===..__/_../ /`.',
  \ '|`` |  :.|  ``          ``  |.`  ::.',
  \ '|   |  ``|    :``;          | ,  `''\',
  \ '|.:  \/  | /`-.``   `:`.-`\ |  \,   |',
  \ '| `  /  /  | / |...   | \ |  |  |`;`|',
  \ ' \ _ |:.|  |_\_|`.`   |_/_|  |.:| _ |',
  \ '/,.,.|` \__       . .      __/ `|.,.,\',
  \ 'l42  | `:`.`----._____.---`.`   |',
  \ '      \   `:`""-------"""` |   |',
  \ '       `,-,-`,             .`-=,=,',
	\ ],
  \ [
  \ '⠀⠀⠀⠀⠀⠀⣰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⣰⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀',
  \ '⠀⠀⠀⠀⢀⠁⠀⠇⠀⠀⠀⠀⠀⠀⠀⢀⠀⠤⠀⠒⣶⣶⠆⠀⠀⢀⠔⠁⢠⠀',
  \ '⠀⠀⠀⠀⠘⢀⠼⠤⠀⠀⠀⠄⡠⠐⠈⠀⠀⠀⠀⡰⠟⠁⠀⢀⠔⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⢜⡁⠀⠀⠀⣖⣦⠀⠀⠤⣤⠄⠐⠂⠁⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⡇',
  \ '⠀⠀⠀⡸⠷⢁⡀⢀⡀⠈⢉⠤⢄⠀⠈⡀⠀⠀⠀⠀⣔⡁⠄⠄⠀⠀⢀⠠⠂⠁',
  \ '⠀⠀⢠⢻⠀⠹⣿⠿⡇⠀⠡⠔⠜⠀⠀⢁⠀⠀⠀⠀⢡⠀⠀⢀⠄⠊⠁⠀⠀⠀',
  \ '⠀⠀⠀⠫⡀⠀⠐⠤⠃⠀⠀⠀⠀⢀⠀⠀⢂⠀⠀⠀⠀⢃⠀⠸⠀⠀⠀⠀⠀⠀',
  \ '⢀⠠⠐⠂⠉⠢⠀⡀⠀⠀⠀⠀⠖⠉⠉⠀⠀⢧⡀⠀⡠⠒⠀⡠⠀⠀⠀⠀⠀⠀',
  \ '⢸⡘⠀⠀⠀⠀⢢⠈⠂⠀⠀⠀⠘⢤⣄⣤⠄⠀⠈⢊⠢⣠⣎⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠉⠀⠒⠒⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠗⣾⠿⠆⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡷⠄⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠘⡀⠀⠀⠀⣀⣀⠀⠀⢀⣀⡀⠤⢊⠆⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠐⠢⢤⣥⠒⠉⠉⠑⠂⠠⠤⡤⢺⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢛⠀⠀⠀⠀⠀⠀⠀⠐⢾⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ ],
  \ [
  \ '⠀⠀⠀⣀⠔⠒⠒⠂⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⢰⢅⠀⠀⢀⣤⢄⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⠀⣾⡆⠀⠀⠀⢸⠼⡎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
  \ '⠀⢀⢗⠂⠀⠀⡀⠈⢉⠅⠇⠀⠀⠀⠀⠀⠀⢠⣄⠀',
  \ '⠀⠈⠢⣓⠔⣲⠖⡫⠊⡘⠀⠀⠀⠀⠀⠀⠲⡟⠙⡆',
  \ '⠀⢀⢀⠠⠘⣇⠖⢄⠀⠉⠐⠠⢄⣀⡀⠀⠜⠀⠀⣁',
  \ '⠘⣏⣀⣀⣀⠃⠀⠀⠑⣀⣀⣀⣰⠼⠇⠈⠄⠀⠈⡻',
  \ '⠀⠁⠀⠀⢰⠀⠀⠀⠀⠠⠀⠡⡀⠀⠀⠀⠈⡖⠚⠀',
  \ '⠀⠀⠀⡠⠘⠀⠀⠀⠀⢀⠆⠀⠐⡀⠀⡠⠊⣠⠀⠀',
  \ '⠀⠀⢐⠀⠀⠁⡀⠀⠀⢀⠀⠀⠀⢨⠀⡠⡴⠂⠀⠀',
  \ '⠀⢀⣨⣤⠀⠀⠐⠃⠐⠚⠢⠀⠀⠈⠑⠊⠀⠀⠀⠀',
  \ '⠀⠘⠓⠋⠉⠁⠀⠀⠀⠀⠀⠓⢶⡾⠗⠀⠀⠀⠀⠀',
  \ ],
  \ [
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠐⠒⠒⠂⠠⡀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠀⠀⡠⢠⠂⠀⠀⠀⠡⡀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⠀⢰⣷⣾⠀⠀⠀⠀⠀⡇⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠜⢨⠢⠔⡀⠀⠠⠘⠛⠛⠀⠀⠀⠀⢸⡇⠀',
  \ '⠀⠀⠀⢀⣀⣀⠀⠀⠀⠰⠀⠀⠀⠀⠡⡀⠀⠈⠀⠒⠂⠄⡀⢀⠀⡀⠀',
  \ '⠀⡴⠊⠀⠀⠀⠉⢆⠀⡔⢣⠀⠀⠀⠀⠐⡤⣀⠀⠀⠀⠀⠀⣀⠄⠀⠀',
  \ '⢸⠀⠀⠀⢠⠀⠀⠈⣼⠀⠀⠣⠀⠀⠀⡰⡀⠀⠉⠀⠀⠰⠉⠀⠁⠠⢄',
  \ '⢰⠀⠀⠀⠀⠇⠀⢀⢿⠀⢀⠇⡐⠀⠈⠀⠈⠐⠠⠤⠤⠤⠀⠀⠀⠀⢨',
  \ '⠀⢓⠤⠤⠊⠀⠀⢸⠀⠣⠀⡰⠁⠀⠀⡀⠀⠀⠀⠸⠀⢰⠁⠐⠂⠈⠁',
  \ '⠀⠀⠑⢀⠀⠀⠀⠈⣄⠖⠉⠑⢄⠠⠊⠀⠢⢄⣠⣃⣀⡆⠀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠑⠠⢀⣀⠎⠀⠀⠀⠈⡄⠀⠀⠀⢠⢃⠠⠃⠐⡀⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⢀⠯⠉⠤⢴⡃⠁⠀⠀⠀⡇⠀⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠰⡁⠀⠀⠀⠠⠂⠀⠀⠀⠀⠑⢄⠀⠀⢀⠲⠁⠀⠀⠀',
  \ '⠀⠀⠀⠀⠀⠀⠀⠘⠒⠑⠔⠁⠀⠀⠀⠀⠀⠀⠀⠁⠉⠀⠀⠀⠀⠀⠀',
  \ ]
  \ ]



let g:thought = [
	\ 'o',
	\ '  O',
  \ ]


let g:startify_custom_header =
			\ 'startify#pad(startify#fortune#boxed() + startify#pad(startify#pad(startify#pad(g:thought + g:asciis[Get_random_offset(len(g:asciis))]))))'





























" EASYMOTION:

" <Leader>f{char} to move to {char}
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)


autocmd VimResized * wincmd =
set noequalalways











" TELESCOPE ADITIONAL:
" TODO: port to lua
"nnoremap <leader>fd <cmd>lua require('telescope.builtin').find_files({hidden=true,cwd = "~/"})<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fd <cmd>lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') }) hidden=true<cr>
nnoremap <leader>fd <cmd>Telescope find_files search_dirs=~/<cr>
nnoremap <leader>fg <cmd>Telescope live_grep search_dirs=~/<cr>

" This Is a sick command I made to open an erlang shell in the current directory:
"cd %:p:h | botright new | res 10 | exe "term erl -mode interactive" | cd - | 2 wincmd w | stopinsert


" DANIEL's CUSTOM FUNCTIONS:

function! ErlTerm()
    cd %:p:h | botright new | res 10 | exe "term erl -mode interactive -kernel shell_history enabled" | cd - | 2 wincmd w | stopinsert
endfunction


" Open pdfs:
function! Cse381()
  silent !zathura ~/School/erlang/cse381/*.pdf &
  silent !zathura ~/School/erlang/cse381/grading/*.pdf &
  silent !zathura ~/School/erlang/*.pdf &
endfunction

function! Cse481()
  silent !zathura ~/School/erlang/cse481/*.pdf &
  silent !zathura ~/School/erlang/cse481/grading/*.pdf &
  silent !zathura ~/School/erlang/*.pdf &
endfunction


