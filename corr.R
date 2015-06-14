corr <- function(directory, threshold = 0, id=1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        
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
        
        # using the counts to determine if the threshold is met for each id
        threshold.met <- subset(order.df, order.df$nobs > threshold)
        
        # determine the correlations between sulfate and nitrates for the complete cases
        complete.data <- subset(data,complete.cases(data))
        correlation <- double(length(unique(threshold.met$id)))
        names(correlation) <- unique(threshold.met$id)
        for (i in unique(threshold.met$id)) {
                id.subset <- subset(complete.data, ID == i)
                #print(subset(complete.data, ID== i))
                id.sulfate <- id.subset$sulfate
                id.nitrate <- id.subset$nitrate
                correlation[i] <- cor(id.sulfate,id.nitrate)
        }
        
        correlation
}

