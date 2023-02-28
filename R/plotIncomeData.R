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
  yLimits = c(floor(min(incomeDistribution$income_distribution, na.rm = TRUE)),
              ceiling(max(incomeDistribution$income_distribution, na.rm = TRUE)))
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
      y = 'Group percentage',
      x = 'Income bracket',
      fill = 'Racial group'
    )+
    ggplot2::scale_x_discrete(guide = ggplot2::guide_axis(angle = 90)) +
    ggplot2::scale_y_continuous(limits = yLimits) +
    ggplot2::scale_fill_manual(drop = FALSE, values = levels(incomeDistribution$race_color),
                               breaks = levels(incomeDistribution$race) ) +
    ggplot2::theme(text = ggplot2::element_text(size = 16),
                   legend.position = 'bottom')

}
#' @rdname plotIncomeDistribution
plotIncomeMedian = function(includeMarginOfError = FALSE){
  # Get the raw data and format it
  medianIncomeVsYearByRace = getIncomeDataSet()[, c('income_median', 'income_med_moe', 'year', 'race', 'race_color')]
  medianIncomeVsYearByRace = medianIncomeVsYearByRace[!duplicated(medianIncomeVsYearByRace), ]
  yLimits = c(round( range(medianIncomeVsYearByRace$income_median + medianIncomeVsYearByRace$income_med_moe, na.rm = TRUE)[1], digits = - 3) - 5000,
              round( range(medianIncomeVsYearByRace$income_median + medianIncomeVsYearByRace$income_med_moe, na.rm = TRUE)[2], digits = - 3) + 5000)
  # Plot the data
  rawPlot = ggplot2::ggplot(data = medianIncomeVsYearByRace,
                            mapping = ggplot2::aes(x = year, y = income_median, color = race)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::labs(
      title = 'Income median by racial group in USA',
      x = 'Year',
      y = 'Income median in $',
      color = 'Racial Group'
    ) +
    ggplot2::scale_y_continuous(
      limits = yLimits,
      labels = function(x){sprintf(fmt = '%sk', format(x / 1000, scientific = FALSE))})  +
    ggplot2::theme(text = ggplot2::element_text(size = 16),
                   legend.position = 'bottom')  +
    ggplot2::scale_color_manual(drop = FALSE, values = levels(incomeDistribution$race_color),
                                breaks = levels(incomeDistribution$race) )

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
plotIncomeMean = function(includeMarginOfError = FALSE){
  # Get the raw data and format it
  meanIncomeVsYearByRace = getIncomeDataSet()[, c('income_mean', 'income_mean_moe' , 'year', 'race')]
  meanIncomeVsYearByRace = meanIncomeVsYearByRace[!duplicated(meanIncomeVsYearByRace), ]
  yLimits = c(round( range(meanIncomeVsYearByRace$income_mean + meanIncomeVsYearByRace$income_mean_moe, na.rm = TRUE)[1], digits = - 3) - 5000,
              round( range(meanIncomeVsYearByRace$income_mean + meanIncomeVsYearByRace$income_mean_moe, na.rm = TRUE)[2], digits = - 3) + 5000)

  # Plot the data
  rawPlot = ggplot2::ggplot(data = meanIncomeVsYearByRace,
                            mapping = ggplot2::aes(x = year, y = income_mean, colour = race)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::labs(
      title = 'Income mean by racial group in USA',
      x = 'Year',
      y = 'Income mean in $',
      colour = 'Racial Group'
    ) +
    ggplot2::scale_y_continuous(
      limits = yLimits,
      labels = function(x){sprintf(fmt = '%sk', format(x / 1000, scientific = FALSE))})  +
    ggplot2::theme(text = ggplot2::element_text(size = 16),
                   legend.position = 'bottom')  +
    ggplot2::scale_color_manual(drop = FALSE, values = levels(incomeDistribution$race_color),
                                breaks = levels(incomeDistribution$race) )

  # Optionally include the margin of error
  if (includeMarginOfError){
    rawPlot = rawPlot +
      ggplot2::geom_pointrange(
        mapping = ggplot2::aes(
          ymin = income_mean - income_mean_moe,
          ymax = income_mean + income_mean_moe)
      )
  }

  #Return the plot
  return(rawPlot)


}

#' @rdname plotIncomeDistribution
plotHouseholdNumber = function(){
  # Get the raw data and format it
  numberVsYearByRace = getIncomeDataSet()[, c('number', 'year', 'race')]
  numberVsYearByRace = numberVsYearByRace[!duplicated(numberVsYearByRace), ]

  # Plot the data
  rawPlot = ggplot2::ggplot(
    data = numberVsYearByRace,
    mapping = ggplot2::aes(x = year, y = number / 1e6, colour = race)
  ) +
    ggplot2::geom_line(size = 1) +
    ggplot2::labs(
      title = 'Number of households by racial groups over the years in USA',
      x = 'Year',
      y = 'Number of households in million',
      colour = 'Racial Group'
    ) +
    ggplot2::scale_y_continuous(labels = function(x){format(x, scientific = FALSE)} ) +
    ggplot2::theme(text = ggplot2::element_text(size = 16),
                   legend.position = 'bottom') +
    ggplot2::scale_color_manual(drop = FALSE, values = levels(incomeDistribution$race_color),
                                breaks = levels(incomeDistribution$race) )


  #Return the plot
  return(rawPlot)


}

#' @rdname plotIncomeDistribution
plotPlaceHolder = function(){
  ggplot2::ggplot(data = cars, mapping = ggplot2::aes(x = speed, y = dist)) +
    ggplot2::geom_point()
}
