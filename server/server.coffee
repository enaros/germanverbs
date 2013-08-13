Meteor.methods
	search: (word) ->
		result = Meteor.http.get("http://www.verbformen.com/conjugation/" + word + ".htm", { encoding: 'base64', headers: { "Content-Type": "text/html; charset=utf-8" } })
		
		return false if result.statusCode isnt 200

		$ = ch.load(result.content);

		$('a').remove()
		verb = $('#verbinformation > div') # 3 divs
		indikativ = $('#indikativ > div') # 6 divs

		# verb.each (i, elem) ->
		# 	r.push($(elem).text().trim())


		# console.log $.html()
		
		name: $(verb[0]).html()
		description: $(verb[1]).html().toString("utf8")
		description2: $(verb[2]).html()
		indikativ: _.map indikativ, (o) -> $(o).html()

	searchWord: (word) ->
		result = Meteor.http.get("http://www.dict.cc/deutsch-englisch/" + word + ".html")
		result2 = Meteor.http.get("https://ajax.googleapis.com/ajax/services/search/images?v=1.0&imgsz=medium&hl=de&as_filetype=png&q=" + word + "&userip=234.111.111.111")
		return false if result.statusCode isnt 200

		$ = ch.load(result.content)

		singPlural = $("[title='article sg | article pl'] td")[1]
		description = $(singPlural).text().replace(/(\[.*?\])/gi, '<span>$1</span>')
		# singular = singPlural.find('a')

		description: description # $(singular[0]).text() + ' | ' + $(singular[1]).text()
		json: JSON.parse(result2.content)