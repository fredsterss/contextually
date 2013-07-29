class @Contextually

  firebaseRef: 'https://contextually.firebaseio.com'
  
  input: $('#new-message')
  messages: $('#messages')

  constructor: ->
    @userId = window.location.hash.substr(1)

    # @id = Math.floor(Math.random() * 10000000)
    @chatId = 11111
    @f = new Firebase("#{@firebaseRef}/chats/#{@chatId}/message_list/")

    @input.focus()
    @addListeners()    

  addListeners: ->
    @input.on 'keypress', (e) =>
      if e.which is 13
        @addMessage()
        e.preventDefault()

    @f.on 'value', (snapshot) =>
      @renderMessages snapshot.val()

  addMessage: ->
    @saveMessage @input.val()
    @input.val ''

  saveMessage: (text) ->
    @f.push().set
      user_id: @userId
      text: text

  renderMessages: (list) ->
    @messages.empty()
    for key, message of list
      @renderMessage message

  renderMessage: (message) ->
    @messages.append "<li>#{message.user_id}: #{message.text}</li>"


$('document').ready ->
  new Contextually()