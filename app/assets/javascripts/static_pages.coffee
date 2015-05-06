# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  characters = 140
  $("#counter").append("You have <strong>" + characters + "</strong> characters remaining")

  $("#micropost_content").keyup(() ->
    if $(this).val().length > characters
      $(this).val($(this).val().substr(0, characters))

    remaining = characters - $(this).val().length
    $("#counter").html("You have <strong>" + remaining + "</strong> characters remaining")
    color = if (remaining <= 10) then "red" else "black"
    $("#counter").css("color", color)
  )
