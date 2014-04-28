plotAday <- function (day) {
	if (length(data) < 1) {
		stop("No data")
	}
	dayX <- data[data[,1]==day,3]
	dayY <- data[data[,1]==day,4]
	xrange <- c(min(dayX),max(dayX))
	yrange <- c(min(dayY),max(dayY))
	plot(dayX,dayY,col="blue",xlim=xrange,ylim=yrange)
	par(new=T)
	plot(-87.6701663, 41.9057066,col="red",pch=4,xlim=xrange,ylim=yrange)
	par(new=T)
	plot(-87.599197, 41.7910532,col="green",xlim=xrange,ylim=yrange)
}