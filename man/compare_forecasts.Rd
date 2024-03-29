% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compare_forecasts.R
\name{compare_forecasts}
\alias{compare_forecasts}
\title{Compare forecast accuracies}
\usage{
compare_forecasts(m, y = NULL, holdout = NULL)
}
\arguments{
\item{m}{a list of models to compare}

\item{y}{a monovariate time series; the data to train and test the models on}

\item{holdout}{single integer; the last n points will be forecasted}
}
\description{
Test the efficacy of time series models by comparing forecasts with actual data
}
\examples{
data(tf.d12)
ts2 <- head(tf.d12, 110)

mod1 <- forecast::snaive(ts2)
mod2 <- ar(ts2)
mod3 <- forecast::ets(ts2)
mod.l <- list(mod1, mod2, mod3)

(l <- compare_forecasts(mod.l, ts2, 12))

par(mfrow=c(3, 1), mar=c(3, 3, 2, 1), mgp=c(2, 0.6, 0), oma=c(0, 0, 0, 0))
invisible(lapply(l, function(x) {
  plot(x$fcast.obj, shaded=FALSE, PI=FALSE, include=48, type="l", 
    cex.main=0.9, xpd=NA)
  lines(x$test, col="#00FF4488")
  }
))

\dontrun{
data(sunspot.month)

extr <- aggregate(sunspot.month, nfrequency=2, mean)[100:349]
extr <- ts(extr, f=21)

mod1 <- StructTS(extr)
mod2 <- ar(extr)
mod3 <- nnetar(extr)
mod4 <- arfima(extr)
mod5 <- Arima(extr, order=c(3, 0, 1))
mod6 <- Arima(extr, order=c(2, 0, 2), seasonal=c(2, 1, 0))

mod.l <- list(mod1, mod2, mod3, mod4, mod5, mod6)

l <- compare_forecasts(mod.l, extr, 21)

diffs <- sapply(l, function(y) y[["fcast"]] - y[["test"]])
matplot(diffs, type="l", 
  col=c("red", "lightgreen", "blue", "orange", "pink", "cyan"), lty=1)

par(mfrow=c(3, 2), mar=c(3, 3, 2, 1), mgp=c(2, 0.6, 0), oma=c(0, 0, 0, 0))
invisible(lapply(l, function(x) {
  plot(x$fcast.obj, shaded=FALSE, PI=FALSE, include=66, type="l", 
    cex.main=0.9, xpd=NA)
  lines(x$test, col="#00FF4488")
  }
))
summary(l)
head(forecasts(l))
l
}
}
