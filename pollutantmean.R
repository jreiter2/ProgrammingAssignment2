pollutantmean <- function(directory="specdata", pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
        
        # creating directory name for datasets   
        dir <- paste(directory,"/", sprintf("%03d",id), ".csv", sep="")

        # create empty dataset to store imported data
        data <- data.frame()
        
        # add each dataset to the dataframe
        for (i in 1:length(id)) {
                data <- rbind(data,read.csv(dir[i]))
        }
        
        # produce vector with pollutant values
        pol <- data[,pollutant]
        
        # calculate mean where not NA
        mean(pol, na.rm = TRUE)
}
