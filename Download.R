# Install and load the rentrez package
#install.packages("rentrez")
library(rentrez)

# Indicate a series of IDs which we want to download
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# Fetch (download) the sequences that we are interested in,
# as indicated by the ncbi_ids from the NCBI database
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

# Split the fetched sequence string into three separate
# strings in a list
sequences <- strsplit(Bburg, "\n\n")
sequences <- unlist(sequences)


header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",sequences)
sequences<-data.frame(Name=header,Sequence=seq)

sequences$Sequence <- gsub("\n", "", sequences$Sequence)

# Write the strings to a CSV
write.csv(sequences, "Sequences.csv")
