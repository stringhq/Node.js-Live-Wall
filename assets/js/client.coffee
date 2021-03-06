$ ->
	entry_el = $('#chatter')
	display = $('display')
	controls = $('controls')
	_body = $('body')
	
	pads = $('.pads')
	
	socket = new io.connect()
	
	socket.on 'news', (data) ->
		display = $('#display')
		display.append '<p>' + data.hello + '</p>'
	
	socket.on 'change-color', (color) ->
	    console.log color
	    _body.css 'background', color
	
	socket.on 'message', (message) ->
		console.log message
		display.append '<p>' + message + '</p>'
		entry_el.prop 'value'
	
	entry_el.keypress (event) ->
		if event.keyCode != 13
			return
		msg = entry_el.prop 'value'
		if msg
			socket.emit 'message', {mymsg: msg}
			entry_el.prop 'value', ''
			entry_el.focus()
			display.append '<p>' + msg + '</p>'
			
	pads.click ->
		#console.log 'hey hey'
		if $('#color').val()==''
			thecolor = '#'+Math.floor(Math.random()*16777215).toString(16)
		else
		    thecolor = $('#color').val().toLowerCase()
		socket.emit 'message', {mymsg: 'x '+thecolor+' '+$(this).attr('title')}