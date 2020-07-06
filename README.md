```
         d8b            ....................................,//,*#
         Y8P        ...................................., ...,,,,,,,*/(
                  ...........................**.............*,,, ,,,,,**(
888  888 888 88888b.d88b.........................../.......... ,,,,,,,*****.
888  888 888 888 "888 "88b...................................../,,,,,,,***.*//(
Y88  88P 888 888..888..888........................,...../.....,,# ,,,,,***/ ///(
 Y8bd8P  888 888..888..888........................# ....,.....,,,,*,,,,,*@*@*#/(#
  Y88P   888 888..888..888.....................**., .............,,,,.,,,,@#@&@///((
         .............................................,.,@@@....# ,,,,,,,**&&(@@///(,
        ...............................................#,..,&...,# ,( ,#.*,(@@**///.(/
       ................................................,%.........,,,,,,,(,***#(,/(,((#
      ........d8b.888......d8b........................888.d8b/(/*.,,,,,,,(,.*****//./(#*
      ........Y8P.888......Y8P........................888.Y8P..#.,,,,,/#.#.*****///((((/
      ............888.................................888,#.....,,,,,,,,,**,**##./(((((#
888..888..888.888.888..888.888.88888b.....d88b.....d88888.888..8888b.,,,,**(,***#*/((((#
888..888..888.888.888..88P.888.888."88b.d8P..Y8b.d88".888.888....."88b,,,****#//.//(((##
888..888..888.888.888888K..888.888..888.88888888.888..888.888..d888888,,****#./////(((/#
Y88b.888.d88P.888.888."88b.888.888.d88P.Y8b......Y88b.888.888.888..888,*****#,//#*(#(##(
."Y8888888P"..888.888..888.888.88888P"..."Y8888..."Y88888.888."Y888888******/#.//(((###
       ........................888.........................,,# .,,,,#.***#**//#,(((####
        .......................888.........................,,#,,,,,********////((((###
         ......................888.........................*# ,,@***@****( ////(((##/
888        ....................................................@@@(*****(./(.(*(((*(
888          .................................................*.@*****/////((((#(#
888           ..............................................*********((//((####*.
88888b   888d888..d88b...888..888..888..d8888b....d88b...888d888.///#,(*(((#/#,
888 "88b 888P"  d88""88b.888..888..888.88K......d8P..Y8b.888P..(.////((((###
888  888 888    888..888.888..888..888."Y8888b..88888888.888..////(((((##
888 d88P 888    Y88 .88P.Y88b.888.d88P......X88.Y8b......888../((((###
88888P"  888     "Y88P"..."Y8888888P"...88888P'.."Y8888..888..#(#,
                        ...................................
```

<h1>vim-wikipedia-browser</h1>
A simple vim-plugin for searching-for and browsing-between wikipedia entries using vim.

<h2>Why?</h2>
I love vim and I often find it hard to swap between vim and the browser (particularly when I am making notes) because the visual-formatting between the two environments are so inconsistent (as well as the fact that I don't use vim-keybindings in my browser). This plugin allows you to view and jump-between wikipedia entries in a vim-buffer.

<h2>Hasn't this been done before?</h2>
Probably - I have been making a few different vim-plugins lately and I thought this would make a good exercise. If you find a better alternative I fully encourage you to use it.

<h2> Usage </h2>
<img src="https://github.com/el-iot/vim-wikipedia-browser/blob/master/assets/demo.gif" width="800" height="450" />

The plugin exposes a function <code>Wikipedia</code> that takes a query string as an argument. The plugin uses the MediaWiki API to search for wikipedia entries matching your query string and displays them in a new buffer. You can use <code><Cr></code> inside this buffer to choose a selected page, at which point the plugin gets the text for this entry on wikipedia and renders it inside a new buffer.

<h2>Configuration</h2>
Very little configuration is exposed currently but it's on the roadmap. <br>
It is recommended you add <code>chikamichi/mediawiki.vim</code> to add syntax highlighting (where relevant) to wikipedia entries.

<h2>Contributing</h2>
Please do! If you find the plugin useful then any contributions are welcome.
