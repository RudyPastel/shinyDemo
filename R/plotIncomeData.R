#' Plot income data set
#'
#' Each functions plots a different aspect of the data set.
#'
#' @param year An integer between 1967 and 2019.
#' @param includeMarginOfError If `TRUE` margin of error is included. If `FALSE`,
#'        margin of error is not included.
#'
#' @return A [ggplot2::ggplot()] object.
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
    ggplot2::scale_fill_discrete(drop = FALSE) +
    ggplot2::theme(text = ggplot2::element_text(size = 16))

}
#' @rdname plotIncomeDistribution
plotIncomeMedian = function(includeMarginOfError = FALSE){
  # Get the raw data and format it
  incomeDistribution = getIncomeDataSet()
  yLimits = c(round( range(incomeDistribution$income_median + incomeDistribution$income_med_moe)[1], digits = - 3) - 5000,
              round( range(incomeDistribution$income_median + incomeDistribution$income_med_moe)[2], digits = - 3) + 5000)
  # Plot the data
  rawPlot = ggplot2::ggplot(data = incomeDistribution,
                   mapping = ggplot2::aes(x = year, y = income_median, colour = race)) +
    ggplot2::geom_line() +
    ggplot2::labs(
      title = 'Income median by racial group in USA',
      x = 'Year',
      y = 'Income median',
      colour = 'Racial Group'
    ) +
    ggplot2::scale_y_continuous(limits = yLimits)  +
    ggplot2::theme(text = ggplot2::element_text(size = 16))

  # Optionally include the margin of error
  if (includeMarginOfError){
    rawPlot = rawPlot +
      ggplot2::geom_pointrange(
        mapping = ggplot2::aes(
          ymin = income_median - income_med_moe,
          ymax = income_median + income_med_moe)
        )
  }

  #Return the plot
  return(rawPlot)


}

#' @rdname plotIncomeDistribution
plotPlaceHolder = function(){
  ggplot2::ggplot(data = cars, mapping = ggplot2::aes(x = speed, y = dist)) +
    ggplot2::geom_point()
}
