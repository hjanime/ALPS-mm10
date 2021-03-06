
"%||%" <- function(a, b){
  if (!is.null(a)) a else b
}

#' Flat Violin plot
#'
#' @param mapping See \code{\link[ggplot2]{geom_violin}}
#' @param data See \code{\link[ggplot2]{geom_violin}}
#' @param position See \code{\link[ggplot2]{geom_violin}}
#' @param trim See \code{\link[ggplot2]{geom_violin}}
#' @param scale See \code{\link[ggplot2]{geom_violin}}
#' @param show.legend See \code{\link[ggplot2]{geom_violin}}
#' @param inherit.aes See \code{\link[ggplot2]{geom_violin}}
#' @param stat See \code{\link[ggplot2]{geom_violin}}
#' @param ... See \code{\link[ggplot2]{geom_violin}}
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(diamonds, aes(x = cut, y = price, fill = cut))+
#' geom_flat_violin()

geom_flat_violin <- function(mapping = NULL, data = NULL, stat = "ydensity",
                             position = "dodge", trim = TRUE, scale = "area",
                             show.legend = NA, inherit.aes = TRUE, ...) {
  layer(data = data,
        mapping = mapping,
        stat = stat,
        geom = GeomFlatViolin,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(trim = trim, scale = scale, ...))
}

#' @rdname geom_flat_violin
#' @format NULL
#' @usage NULL
#' @export
GeomFlatViolin <-
  ggplot2::ggproto("GeomFlatViolin", Geom,
                   setup_data = function(data, params){
                     data$width <- data$width %||%
                       params$width %||% (resolution(data$x, FALSE) * 0.9)

            # ymin, ymax, xmin, and xmax define
            # the bounding rectangle for each group
          data %>%
            dplyr::group_by(group) %>%
            dplyr::mutate(ymin = min(y),
                          ymax = max(y),
                          xmin = x, xmax = x + width / 2)
          },
          draw_group = function(data, panel_scales, coord) {
            # Find the points for the line to go all the way around
            data <- transform(data,
                              xminv = x,
                              xmaxv = x + violinwidth * (xmax - x))

            # Make sure it's sorted properly to draw the outline
            newdata <- rbind(
              plyr::arrange(transform(data, x = xminv), y),
              plyr::arrange(transform(data, x = xmaxv), -y))

            # Close the polygon: set first and last point the same
            # Needed for coord_polar and such
            newdata <- rbind(newdata, newdata[1, ])

            ggplot2:::ggname("geom_flat_violin",
                             GeomPolygon$draw_panel(newdata, panel_scales, coord))
          },

          draw_key = ggplot2::draw_key_polygon,
          default_aes = ggplot2::aes(weight = 1,
                                     colour = "grey20",
                                     fill = "white",
                                     size = 0.5,
                                     alpha = NA,
                                     linetype = "solid"),
          required_aes = c("x", "y")
)


