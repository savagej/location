whereAmI <- function (file,centers) {
	data <- read.table(file,sep=" ")
	pos <- cbind(data[,4],data[,3])
	clus<-kmeans(pos,centers)
	return(clus$centers)
}