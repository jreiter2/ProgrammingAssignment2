complete <- function(directory = "specdata", id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        # creating directory name for datasets   
        dir <- paste(directory,"/", sprintf("%03d",id), ".csv", sep="")
        
        # create empty dataset to store imported data
        data <- data.frame()
        
        # add each dataset to the dataframe
        for (i in 1:length(id)) {
                data <- rbind(data,read.csv(dir[i]))
        }
        
        # keep track of original order
        id.order <- data.frame(id,1:length(id))
        colnames(id.order) <- c("id","order")
        
        # total count of each 
        total.count <- table(data$ID)
        
        # number of incomplete lines in each id
        na.data <- subset(data,is.na(data$sulfate) | is.na(data$nitrate))
        na.count <- table(na.data$ID)
        
        # finding the difference between the total and the na
        final.count <- total.count - na.count
        
        # putting the dataframe together
        id.col <- row.names(final.count)
        obs.col <- as.vector(final.count)
        df <- data.frame(id.col,obs.col)
        colnames(df) <- c("id", "nobs")
        
        # sorting the data frame in original order
        merge.df <- merge(df,id.order)
        order.df <- merge.df[with(merge.df, order(order)), ]
        
        # removing sorting variable
        order.df$order <- NULL
        
        # return dataframe
        order.df
        
        
        
        ###non.missing.count <- total.count$n - na.count$n
        ###print(non.missing.count)
        
        # create data frame to return
        ###df <- data.frame(id,non.missing.count)
        ###colnames(df) <- c("id","nobs")
        ###df
}
