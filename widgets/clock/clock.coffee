class Dashing.Clock extends Dashing.Widget

  ready: ->

    setInterval(@startTime, 5000) #update every 5s

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)
    @set('time', h + ":" + m )
    @set('date', today.toDateString())

  formatTime: (i) ->
    if i < 10 then "0" + i else i
