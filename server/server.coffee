Meteor.methods
	search: (word) ->
		result = Meteor.http.get("http://www.verbformen.com/conjugation/" + encodeURIComponent(word) + ".htm", { encoding: 'buffer', headers: { "Content-Type": "text/html; charset=ISO-8859-1" } })
		
		return false if result.statusCode isnt 200

		console.log result.content

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
		result = Meteor.http.get("http://www.dict.cc/deutsch-englisch/" + encodeURIComponent(word) + ".html")
		return false if result.statusCode isnt 200

		$ = ch.load(result.content)

		singPlural = $("[title='article sg | article pl'] td")[1]
		description = $(singPlural).text().replace(/(\[.*?\])/gi, '<span>$1</span>')
		# singular = singPlural.find('a')

		description: description # $(singular[0]).text() + ' | ' + $(singular[1]).text()
		img: googleImg(word)

googleImg = (word) ->
	param = 
		v: '1.0'
		# as_sitesearch: 'photobucket.com'
		as_filetype: 'jpg'
		q: word
		userip: '234.111.111.111'
		# imgc: 'gray'
		imgcolor: 'white'
		imgsz: 'large'

	r = Meteor.http.get "https://ajax.googleapis.com/ajax/services/search/images?" + _.reduce(param, ((memo, val, key) -> return "#{memo}&#{key}=#{encodeURIComponent(val)}"), '')
	return r if r.statusCode isnt 200

	r = JSON.parse(r.content)
	console.log r
	r.responseData?.results[1]?.url