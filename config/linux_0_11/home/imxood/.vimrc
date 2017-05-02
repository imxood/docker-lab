"-----------------------------------基本------------------------------------
"处理未保存或只读文件时，弹出确认
set confirm

"自动保存
set autowrite

"历史记录数
set history=1000

"编码设置
set fenc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2313,cp936

set t_Co=256
colorscheme molokai
set background=dark

"语法高亮
if has("syntax")
syntax on
endif

"设置行号
set nu

"设置缩进
set tabstop=4
set sts=4
set smartindent
set expandtab
set softtabstop=4
set shiftwidth=4
"设置自动格式化,解决复制代码过来的时候出现格式混乱
"shift +v 开头
"shift +g 结尾
"==
"格式化全文： gg=G
"自动缩进当前行： ==

set formatoptions=tcrqn

"设置括号配对情况
set showmatch
set matchtime=2
"设置没有自动备份
set noswapfile
set nobackup
"设置纵向虚线对齐
"底部显示光标的位置的状态行
set ruler
"设置查找
"搜索模式忽略大小写
set ignorecase
"如果搜索模式包含大小写则不适用ignorecase
set smartcase
"禁止搜索到文件两端时重新搜索
set nowrapscan
"高亮显示搜索到的文本
set hlsearch
"逐字符高亮
set incsearch
"使用鼠标
"按住 shift 才由鼠标右键处理操作
set mouse=a
"突出显示当前编辑行
set cursorline
"开启折叠，并设置空格来开关折叠
set foldenable
set foldmethod=syntax
set foldcolumn=0
setlocal foldlevel=1
set foldclose=all
nnoremap <space> @=((foldclosed(line('.'))<0)?'zc':'zo')<CR>
"搜索和undo时不展开设置好的折叠
set foldopen-=search
set foldopen-=undo