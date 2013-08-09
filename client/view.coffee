Template.searchbox.events
	'submit form': (e, t) ->
		Meteor.call 'search', $(t.findAll 'input').val(), (err, result) ->
			console.log result
			Session.set 'word', result
		return false

Template.results.word = ->
	Session.get('word')

Meteor.startup -> $('input').select()