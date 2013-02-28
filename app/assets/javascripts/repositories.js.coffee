# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  Morris.Bar
    element: "main_graph"
    data: [
      y: "Commits"
      a: $("#main_graph").data('worktime')
      b: $("#main_graph").data('offtime')
    ]
    xkey: "y"
    ykeys: ["a", "b"]
    labels: ["Work time", "Off time"]
    hideHover: 'auto'
    barColors: [
      "green"
    ,
      "red"
    ]

  Morris.Bar
    element: "offtime_graph"
    data: [
      y: "Commits"
      a: $("#offtime_graph").data('overtime')
      b: $("#offtime_graph").data('weekend')
    ]
    xkey: "y"
    ykeys: ["a", "b"]
    labels: ["Overtime", "Weekend"]
    hideHover: 'auto'
    barColors: [
      "#CC0000"
    ,
      "#990000"
    ]
