examineDays <- function (file) {
	if (is.null(google_location_data)) {google_location_data <- read.table(file,sep=" ")}
	#google_location_data <- read.table(file,sep=" ")
	pos <- cbind(google_location_data[,4],google_location_data[,3])
	dates <- unique(google_location_data[,1])
	home <- c(41.9057066, -87.6701663)
	work <- c(41.7910532, -87.5991970)
	#print(dates)
	
	all_centers<-numeric()
	for (i in dates) {
		date_check <- google_location_data[,1]==i
		pos_for_day<-cbind(pos[date_check,1],pos[date_check,2])
		work_check <- ((pos_for_day[,1]-work[1])^2+(pos_for_day[,2]-work[2])^2) < 0.001
		home_check <- ((pos_for_day[,1]-home[1])^2+(pos_for_day[,2]-home[2])^2) < 0.001
		if(sum(work_check) > 0) {was_at_work <- sum(work_check)} else {was_at_work <- 0}
		if(sum(home_check) > 0) {was_at_home <- sum(home_check)} else {was_at_home <- 0}
		all_centers <- rbind(all_centers, c(was_at_work,was_at_home))
	}
	all_centers <- cbind(as.character(dates),all_centers)
	return(all_centers)
}