main_panel <- mainPanel(
  h2("How unemployment affect poverty based on the different states"),
  plotlyOutput(
    outputId = "interactive_graph"
  )
)