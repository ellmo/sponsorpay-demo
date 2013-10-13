class Application.views.ApiClient
  constructor: ->
    $('.form .button#submit').off('click').on 'click', (event) =>
      uid = $('.form input#uid').val()
      pub0 = $('.form input#pub0').val()
      page = $('.form input#page').val()
      console.log [uid, pub0, page]


