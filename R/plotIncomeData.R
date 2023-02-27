#' Plot income data set
#'
#' @param year An integer between 1967 and 2019.
plotIncomeDistribution = function(year){

  # Get the raw data and format it
  incomeDistribution = getIncomeDataSet()
  yLimits = c(floor(min(incomeDistribution$income_distribution)),
             ceiling(max(incomeDistribution$income_distribution)))
  incomeDistribution = incomeDistribution[incomeDistribution$year == year, ]

  # Plot the data
  ggplot2::ggplot(data = incomeDistribution,
         mapping = ggplot2::aes(x = income_bracket,
                       y = income_distribution,
                       fill = race)) +
    ggplot2::geom_col() +
    ggplot2::facet_grid(year~race, drop = FALSE) +
    ggplot2::labs(
      title = sprintf(fmt = 'Income distribution by racial group in %s in USA', year),
      y = 'Group fraction',
      x = 'Income bracket',
      fill = 'Racial Group'
    )+
    ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(angle = 90)) +
    ggplot2::scale_y_continuous(limits = yLimits) +
    ggplot2::scale_fill_discrete(drop = FALSE)

}

#' @rdname plotIncomeDistribution
plotPlaceHolder = function(){
  ggplot2::ggplot(data = cars, mapping = ggplot2::aes(x = speed, y = dist)) +
    ggplot2::geom_point()
}
