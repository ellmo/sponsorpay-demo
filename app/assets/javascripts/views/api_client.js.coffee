class Application.views.ApiClient
  constructor: ->
    $('.form .button#submit').off('click').on 'click', (event) =>
      uid = $('.form input#uid').val()
      pub0 = $('.form input#pub0').val()
      page = $('.form input#page').val()
      req = $.ajax
        url: '/api_client/get_offers'
        type: 'GET'
        data:
          uid: uid,
          pub0: pub0,
          page: page
      req.done (data, result) =>
        $('#response').html JST['offers'](offers: data.offers)
      req.fail (jqXHR, result) =>
        data = JSON.parse jqXHR.responseText
        $('#response').html JST['no_offers'](error: data.message)


