printGeoJson <- function (x,factor,file) {
	x_size <- dim(x)
	if (x_size[2] != 2) {stop("x has to be an N by 2 matrix")}
	unique_factors <- unique(factor)
	
	sink(file)
	cat ("{\n\"type\": \"FeatureCollection\",\n\"features\": [\n")
		
	for (j in unique_factors) {
		print_matrix <- x[factor == j,]
		if (j == unique_factors[1]) {} else { cat(",")}
		if (class(print_matrix)=="matrix") {
			length = dim(print_matrix)[1]

			cat("{\n\"type\": \"Feature\",\n\"properties\": {},\n\"geometry\": ")
			cat("{\n\"type\": \"LineString\",\n\"coordinates\": [\n")
			
			for (i in seq(length)) {
				if (i == 1) {
					cat("[\n",print_matrix[i,2],",\n ",print_matrix[i,1],"\n]")
				} else {
					cat(",[\n",print_matrix[i,2],",\n ",print_matrix[i,1],"\n]")
				}
			}
			cat("]\n}\n")
			cat("}\n")

		} else {
			#length = length(print_matrix)
			cat("{\n\"type\": \"Feature\",\n\"properties\": {},\n\"geometry\": ")
			cat("{\n\"type\": \"Point\",\n\"coordinates\":\n")
				
			#for (i in seq(length)) {
			#	if (i == 1) {
					cat("[\n",print_matrix[2],",\n ",print_matrix[1],"\n]")
			#	} else {
			#		cat(",[\n",print_matrix[2],",\n ",print_matrix[1],"\n]")
			#	}
			#}
			cat("}\n")
			#cat("\"style\":{\"fill\":\"red\",\"fill-opacity\":0.6}\n")
			cat("}\n")
		}
	}	

	
	cat("]\n}\n")
	sink()
	
}