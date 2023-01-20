---
title: Mozc UT SKK-JISYO Dictionary
date: 2023-01-15
---

## Overview

Mozc UT SKK-JISYO Dictionary is a dictionary converted from [SKK-JISYO](http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=SKK%BC%AD%BD%F1) for Mozc.

Thanks to the SKK-JISYO team.

## License

mozcdic-ut-skk-jisyo.txt: GNU General Public License v2.0 or later

Source code: Apache License, Version 2.0

```
head -n 30 SKK-JISYO.L

;; This dictionary is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
```

## Usage

Add mozcdic-ut-*.txt to dictionary00.txt and build Mozc as usual.

```
tar xf mozcdic-ut-*.txt.tar.bz2
cat ../mozc-master/src/data/dictionary_oss/dictionary00.txt mozcdic-ut-*.txt > dictionary00.txt.new
mv dictionary00.txt.new ../mozc-master/src/data/dictionary_oss/dictionary00.txt
```

To modify the costs for words or merge multiple UT dictionaries into one, use this tool:

[merge-ut-dictionaries](https://github.com/utuhiro78/merge-ut-dictionaries)

## If you create your own UT dictionary

Requirement(s): ruby, rsync

```
cd src/
sh make.sh
```

[HOME](http://linuxplayers.g1.xrea.com/mozc-ut.html)
