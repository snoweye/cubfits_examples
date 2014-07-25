library(RCurl)

github.dir <- "https://raw.githubusercontent.com/snoweye/cubfits_examples/master/data_1K/"
fn.seq <- "genome.fasta"
fn.phi <- "genome.phi.tsv"

da.seq <- getURL(paste(github.dir, fn.seq, sep = ""), ssl.verifypeer = FALSE)
da.phi <- getURL(paste(github.dir, fn.phi, sep = ""), ssl.verifypeer = FALSE)

tempdir <- tempdir()
fn.seq.local <- paste(tempdir, fn.seq, sep = "/")
fn.phi.local <- paste(tempdir, fn.phi, sep = "/")
write(da.seq, file = fn.seq.local)
write(da.phi, file = fn.phi.local)

library(cubfits)
seq.string <- read.seq(fn.seq.local)
phi.df <- read.phi.df(fn.phi.local)
