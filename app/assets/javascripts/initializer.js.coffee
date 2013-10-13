#= require_self
#= require_tree ./views

window.Application =
  views: {}

$(document).ready ->
  view = new Application.views.ApiClient