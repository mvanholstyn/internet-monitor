# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

setupChart = (checks) ->
  ctx = $("#myChart")
  myChart = new Chart ctx,
    options:
      responsive: true
      scales:
        yAxes:[
          ticks:
            stepSize: 1
        ]
        xAxes: [
          type: 'time'
          time:
            unit: 'minute'
        ]
    type: 'line',
    data:
      labels: checks.labels
      datasets: [
        label: "Checks"
        data: checks.data
      ]

$ ->
  $.get "/checks.json", setupChart