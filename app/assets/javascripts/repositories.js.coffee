# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  graph = new Rickshaw.Graph(
    element: document.querySelector("#main_graph")
    renderer: 'bar'
    width: 600
    height: 200
    series: [
      color: "steelblue"
      data: [
        x: 0
        y: $('#main_graph').data('worktime')
      ,
        x: 1
        y: $('#main_graph').data('overtime')
      ]
    ,
      color: "lightblue"
      data: [
        x: 0
        y: $('#main_graph').data('unworktime')
      ,
        x: 1
        y: $('#main_graph').data('weekend')
      ]
    ]
  )
  graph.renderer.unstack = true
  graph.render()
