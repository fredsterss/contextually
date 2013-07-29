class @Contextually

  firebaseRef: 'https://contextually.firebaseio.com'
  
  input: $('#new-message')
  messages: $('#messages')
  topics: $('#topics')

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

    $('.message').on 'click', (e) ->
      console.log e

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
      message.key = key
      @renderMessage message

  renderMessage: (message) ->
    @messages.append "<li class='message' id='#{message.key}'>#{message.user_id}: #{message.text}</li>"
    $("##{message.key}").on 'click', (e) =>
      @newTopic message

  newTopic: (message) ->
    @topics.append "<li class='topic'>#{message.text}</li>"

$('document').ready ->
  new Contextually()