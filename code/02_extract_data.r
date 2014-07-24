rm(list = ls())

library(cubfits)

seq.string <- read.seq("../yeast_s288c/s288c.genome.fasta")
phi <- read.phi.df("../yassour2009/yassour2009.phi.tsv")

seq.string <- seq.string[order(names(seq.string))]
phi <- phi[order(phi$ORF),]

### Get 5K.
new.phi <- phi[phi$ORF %in% names(seq.string), ]
new.seq.string <- seq.string[names(seq.string) %in% phi$ORF]

write.seq(new.seq.string, "../data_5K/genome.fasta")
write.phi.df(new.phi, "../data_5K/genome.phi.tsv")

### Get 1K.
set.seed(1234)

id <- sort(sample(length(new.seq.string), size = 1000))
new.phi <- new.phi[id,]
new.seq.string <- new.seq.string[id]

write.seq(new.seq.string, "../data_1K/genome.fasta")
write.phi.df(new.phi, "../data_1K/genome.phi.tsv")
