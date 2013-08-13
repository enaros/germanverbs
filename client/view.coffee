Handlebars.registerHelper "hola", (op,a,b,c) ->
	console.log @, op, a, b 
	'hola'


Template.searchbox.events
	'submit form': (e, t) ->
		method = if Session.get('type') is 'WORD' then 'searchWord' else 'search'
		Meteor.call method, $(t.findAll 'input').val(), (err, result) ->
			console.log result
			Session.set 'word', result
		return false

Template.sidebar.events
	'click a': (e, t) ->
		node = null
		$('.tenses table .text_kategorie').each ->
			if $(this).text().trim() is $(e.currentTarget).text()
				node = @
		node = $(node).parents('table')
		node.siblings(':visible').fadeOut(->node.fadeIn())
		window.snapper.close()
		return false

	'click #menu-type div': (e, t) ->
		Session.set "type", $(e.currentTarget).text()
		$('input').focus()
		window.snapper.close()


Template.results.word = -> Session.get('word')
Template.main.imgurl = -> Session.get('word')?.json?.responseData.results[0].url
Template.sidebar.active = (cual) -> return 'active' if Session.get('type') is cual
Template.sidebar.display = -> return 'hide' if Session.get('type') is 'WORD'

Meteor.startup -> 
	# $('input').select()
	window.snapper = new Snap
		element: document.getElementById('content')
		disable: 'right'
		maxPosition: 201