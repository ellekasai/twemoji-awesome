# Twemoji Possum 🐭🐭🐭🐭🐭

This started as a javascript parser to merge unicode human-readable
names with twemoji's code-point references in a scalable and repeatable
way for the [twemoji-awesome](http://ellekasai.github.io/twemoji-awesome/) project; however, due to memory leaks in various XML parsers available for node, it became a ruby project 😅

### Build Instructions

`git clone`

`bundle`

`rake`

If you don't have ruby, install via [rbenv](https://github.com/rbenv/rbenv#homebrew-on-mac-os-x).
If you don't have bundler, `gem install bundler` after getting a ruby.

After that, just follow the same three statements in the root (with the
Gemfile) directory of this project.

The rake task will generate an up-to-date mapping of all relevant
entitites.

### Unicode Parse

http://unicode.org/emoji/charts/full-emoji-list.html

Date safety: for some reason, Unicode stores its last update date as
javascript variable, the current build is pulled as of:

- 6/28/2016, 6:16:15 AM

Please use common sense if there's a big update to the emoji table to
check and see if any of the parsing rules break 😃

### Twemoji Parse

https://twemoji.maxcdn.com/2/test/preview.html

Date safety: I don't see an official update stamp for twemoji v2, but
the values were pulled as of:

- 8/10/2016, 1:34:15 AM

### Custom Names Parse

These were pulled from either the twemoji-awesome repo or filled in extensions from
unicode's naming scheme; twemoji-awesome's rules are derived from
emoji-cheat-sheat.  `lib/null-list-rules` are gap-fillers for twitter's
non-standard or cutting edge emoji's that didn't exist in any other
list.

### Collisions

In the event of a collision between names, the Unicode Consortium gets
the name on preference at the expense of custom rules.

The following rules were deprecated from emoji-cheat-sheet and modified
to match the Unicode Consortium name for their code point:

- post-office: 1f3e3 => japanese-post-office
- camel: 1f42b => two-hump-camel
- mouse: 1f42d => mouse-face
- cow: 1f42e => cow-face
- tiger: 1f42f => tiger-face
- rabbit: 1f430 => rabbit-face
- cat: 1f431 => cat-face
- whale: 1f433 => spouting-whale
- horse: 1f434 => horse-face
- dog: 1f436 => dog-face
- pig: 1f437 => pig-face
- kiss: 1f48b => kiss-mark
- calendar: 1f4c6 => tear-off-calendar
- speaker: 1f50a => speaker-loud
- sunglasses,1f60e => smiling-face-with-sunglasses
- satellite: 1f4e1 => satellite-antenna
- egg: 1f373 => cooking
- umbrella: 2614 => umbrella-with-rain-drops
- snowman: 26c4 => snowman-without-snow
- raised-hand: 1f64b => happy-person-raising-hand


because Unicode encodes them as:

- post-office: 1f3e4
- camel: 1f42a
- mouse: 1f401
- cow: 1f404
- tiger: 1f405
- rabbit: 1f407
- cat: 1f408
- whale: 1f40b
- horse: 1f40e
- dog: 1f415
- pig: 1f416
- kiss: 1f48f
- calendar: 1f4c5
- speaker: 1f508
- sunglasses: 1f576
- satellite: 1f6f0
- egg: 1f95a
- umbrella: 2602
- snowman: 2603
- raised-hand: 270b

The modified custom rules are in `lib/modified-cheat-sheet.json`, the
original emoji-cheat-sheet can be found in
`errata/elle-kasai-emoji-cheatsheet.json`

### Author

👳🏾 Kamal R

- email: kamalasaurus@gmail.com
- twitter: [@kamalasaurus](https://twitter.com/kamalasaurus)
- website: [kamalasaurus.github.io](https://kamalasaurus.github.io)

### Contributors

👩🏻 Elle Kasai (creator of twemoji awesome)
- email: elle.kasai@gmail.com
- twitter: [@ellekasai](https://twitter.com/ellekasai)
- website: [ellekasai.com](http://ellekasai.com)

👽 Fake Unicode (mysterious twitter user/genius of unicode documentation)
- twitter: [@FakeUnicode](https://twitter.com/FakeUnicode)
- website: [☃.net](http://☃.net)

👨🏽 Angel Cruz (creator of twemoji awesome npm module)
- email: me@abr4xas.org

### License

- Code: [MIT](https://opensource.org/licenses/MIT)
- Graphics: [CC-BY](https://creativecommons.org/licenses/by/4.0/)

### Acknowledgements

The conversation that prompted this project is hosted on twitter at:
- https://twitter.com/kamalasaurus/status/761504342922842112

What began as minor confusion turned into a fun weekend spike; basically,
assigning human-readable names to all the unicode code-points is kind of
a 🐻

Of course, a huge thanks to Twitter and their amazing in-house designers
for contributing to an open future for the web:
- https://twitter.github.io/twemoji/

### Notes

Other than the list employed, you can see the authoritative published
unicode documentations here:

- http://www.unicode.org/Public/9.0.0/ucd/UnicodeData.txt
- http://www.unicode.org/Public/emoji/3.0//emoji-data.txt
- http://www.unicode.org/Public/emoji/3.0//emoji-zwj-sequences.txt
- http://www.unicode.org/Public/emoji/3.0//emoji-sequences.txt

ZWF Sequence notes such as the pride flag:
- http://www.unicode.org/L2/L2016/16183-rainbow-flag.pdf

Emoji 3.0 Public Spec:
- http://www.unicode.org/Public/emoji/3.0//

It's a bit easier to scrape the emoji-list found at:
- http://unicode.org/emoji/charts/full-emoji-list.html
than to parse and munge overinclusive text files 😅

Since everything is hosted at unicode.org, I'm assuming it'll be
maintained properly ¯\\_(ツ)_/¯

### How to use

It's unlikely anyone will be using this repo directly, since it's meant
to just generate a component for twemoji-awesome, the css of which is
what is intended for consumption!  But if you want to contribute by
adding custom names and stuff to the rule list, this is the place to do
it!

This project is stored as a submodule in twemoji-awesome, so make your
changes, make a pull request, update to the latest submodule state and
in the twemoji-awesome root directory run `sass twemoji-awesome.scss`.

Make sure you have sass!  `gem install sass`.
- http://sass-lang.com/documentation/

This will generate a new twemoji-awesome.css.

If for some reason, sass just dumps the compiled output into the buffer,
use `sass twemoji-awesome.scss > twemoji-awesome.css`

You can also manually copy your output `dist/emoji-map.scss` to the root
of twemoji-awesome and and change the `@import` directive to point at
your generated file to test out your custom rules if you don't want to
deal with the pull request process.

### Twemoji Cheat Sheet

The cheat sheet will be maintained at another repo, downstream of
twemoji-awesome.  The link to it can be found here:

https://github.com/kamalasaurus/twemoji-awesome-cheatsheet

### Contributing

If I was really awesome, I would have made the `src/CustomMapper.rb`
file iterate through all json's in `lib` and append them to the custom
rules list.  Since I'm not that awesome for v1, just go ahead and make a
json of `"code-point": "custom-name"` or `"code-point": ["custom-names"...]` and have it consumed in `CustomMapper.rb` like all the other custom names.

### TODO

It might be cool to have custom flag names for some of the longer
names.  I'm not sure if I should have the authority to name countries
or something, so I'm preferentially leaving that to the internet.  Refer
to the cheat sheet for obviously unwieldy names.

