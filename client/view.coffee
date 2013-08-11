Handlebars.registerHelper "hola", (op,a,b,c) ->
	console.log @, op, a, b 
	'hola'


Template.searchbox.events
	'submit form': (e, t) ->
		Meteor.call 'search', $(t.findAll 'input').val(), (err, result) ->
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
		node.show().siblings().hide()
		return false



Template.results.word = -> Session.get('word')

Meteor.startup -> 
	# $('input').select()
	snapper = new Snap
		element: document.getElementById('content')
		disable: 'right'
		maxPosition: 201