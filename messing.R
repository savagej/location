data <- read.table("output.txt",sep=" ")
dates <- unique(data[1])
avXperday <- tapply(data[,3],data[,1],mean)
avYperday <- tapply(data[,4],data[,1],mean)