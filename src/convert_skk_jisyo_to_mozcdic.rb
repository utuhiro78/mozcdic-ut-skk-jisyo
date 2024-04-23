#! /usr/bin/env ruby
# coding: utf-8

require 'nkf'

`wget -N https://github.com/skk-dev/dict/raw/master/SKK-JISYO.L`

filename = "SKK-JISYO.L"
dicname = "mozcdic-ut-skk-jisyo.txt"
id_mozc = "1843"

file = File.new(filename, "r")
	lines = file.read.encode("UTF-8", "EUC-JP")
	lines = lines.split("\n")
file.close

# 確認用に出力
dicfile = File.new(filename + ".utf8", "w")
	dicfile.puts lines
dicfile.close

l2 = []
p = 0

lines.length.times do |i|
	# わりふr /割り振/割振/
	# いずみ /泉/和泉;地名,大阪/出水;地名,鹿児島/
	s = lines[i].split(" /")
	yomi = s[0]
	yomi = yomi.gsub("う゛", "ゔ")

	# 読みが2文字以下の場合はスキップ
	if yomi[2] == nil ||
	# 読みが英数字を含む場合はスキップ
	yomi.bytesize != yomi.length * 3
		next
	end

	hyouki = s[1].split("/")

	hyouki.length.times do |c|
		hyouki[c] = hyouki[c].split(";")[0]

		# 表記の全角英数を半角に変換
		hyouki[c] = NKF.nkf("-m0Z1 -W -w", hyouki[c])

		# 表記が1文字の場合はスキップ
		if hyouki[c][1] == nil ||
		# 表記が英数字のみの場合はスキップ
		hyouki[c].length == hyouki[c].bytesize
			next
		end

		# 2個目以降の表記が1つ前の表記と同じ場合はスキップ
		# ＩＣカード/ICカード/
		if c > 0 && hyouki[c] == hyouki[c - 1]
			next
		end

		# 2個目以降の表記のコストを上げる
		cost = 8000 + (10 * c)

		l2[p] = [yomi, id_mozc, id_mozc, cost.to_s, hyouki[c]]
		l2[p] = l2[p].join("	")
		p = p + 1
	end
end

lines = l2
l2 = []

# 重複する行を削除
lines = lines.uniq.sort

dicfile = File.new(dicname, "w")
	dicfile.puts lines
dicfile.close
