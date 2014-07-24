### Yassour M, Kaplan T, Fraser HB, Levin JZ, Pfiffner J, Adiconis X,
### Schroth G, Luo S, Khrebtukova I, Gnirke A, Nusbaum C, Thompson DA,
### Friedman N, Regev A. (2009) Ab initio construction of a eukaryotic
### transcriptome by massively parallel mRNA sequencing.
### Proc Natl Acad Sci USA 106(9):3264-9. [PMID:19208812]
###
### http://www.pnas.org/content/early/2009/02/10/0812841106
### http://www.pnas.org/content/vol0/issue2009/images/data/0812841106/DCSupplemental/SD3.xls

rm(list = ls())

da <- read.table("../yassour2009/SD3.xls", header = TRUE, sep = "\t",
                 quote = "", stringsAsFactors = FALSE)

### Select ORF, YPD0.1, YPD0.2, YPD15.1, YPD15.2.
phi <- da[, c(1, 8, 9, 10, 11)]
head(phi)
colnames(phi) <- c("ORF", "YPD0.1", "YPD0.2", "YPD15.1", "YPD15.2")

### Wallace's approach.
# tmp <- phi[, 2:5]
# tmp <- exp(rowMeans(log(tmp + 1)) - 1)
# tmp <- tmp / sum(tmp, na.rm = TRUE) * 15000

### Drop inappropriate values (NaN, NA, Inf, -Inf, and 0).
tmp <- phi[, 2:5]
id.tmp <- rowSums(is.finite(as.matrix(tmp)) & tmp != 0) >= 3

### As Wallace's approach, but drop 0.
phi.tmp <- phi[id.tmp,]
tmp <- phi.tmp[, 2:5]
tmp <- apply(tmp, 1, function(x) exp(mean(log(x[x != 0]))))
tmp <- tmp / sum(tmp) * 15000

### Dump out.
phi.new <- data.frame(ORF = as.character(phi.tmp$ORF), phi = tmp)
phi.new <- phi.new[order(phi.new$ORF),]

write.table(phi.new,
            file = paste("../yassour2009/yassour2009.phi.tsv", sep = ""),
            quote = FALSE, sep = "\t", row.names = FALSE)
