clusterDays <- function (file) {
	if (is.null(google_location_data)) {google_location_data <- read.table(file,sep=" ")}
	google_location_data <- read.table(file,sep=" ")
	pos <- cbind(google_location_data[,4],google_location_data[,3])
	dates <- unique(google_location_data[,1])
	all_centers<-numeric()
	for (i in dates) {
		date_check <- google_location_data[,1]==i
		pos_for_day<-cbind(pos[date_check,1],pos[date_check,2])
		clus_for_day<-kmeans(pos_for_day,2) # I just want the main two places I've gone
		centers_for_day <- c(clus_for_day$centers[1,],clus_for_day$centers[2,])
		all_centers<-rbind(all_centers,centers_for_day)
	}
	return(all_centers)
}
