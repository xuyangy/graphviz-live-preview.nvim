" Vim syntax file
" Language: Graphviz Dot
" Maintainer: graphviz-live-preview
" Basic highlighting for dot files

if exists("b:current_syntax")
  finish
endif

syntax keyword dotGraphType graph digraph subgraph
syntax keyword dotEdgeOp -- ->
syntax keyword dotAttrType node edge graph
syntax match dotComment /\/\/.*/
syntax match dotComment /#.*/
syntax match dotString /"[^"]*"/
syntax match dotNumber /\<\d\+\>/
syntax match dotID /[a-zA-Z_][a-zA-Z0-9_]*/

highlight link dotGraphType Keyword
highlight link dotEdgeOp Operator
highlight link dotAttrType Type
highlight link dotComment Comment
highlight link dotString String
highlight link dotNumber Number
highlight link dotID Identifier

let b:current_syntax = "dot"
