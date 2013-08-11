Meteor.methods
	search: (word) ->
		result = Meteor.http.get("http://www.verbformen.com/conjugation/" + word + ".htm", { headers: { "Content-Type": "text/html; charset=utf-8" } })
		
		return false if result.statusCode isnt 200

		$ = ch.load(result.content);

		$('a').remove()
		verb = $('#verbinformation > div')
		indikativ = $('#indikativ > div')

		# verb.each (i, elem) ->
		# 	r.push($(elem).text().trim())


		console.log $.html()
		
		name: $(verb[0]).html()
		description: $(verb[1]).html()
		description2: $(verb[2]).html()
		indikativ: [
			$(indikativ[0]).html()
			$(indikativ[1]).html()
			$(indikativ[2]).html()
			$(indikativ[3]).html()
		]