# Make small datasets

library(Racmacs)

map_2004 <- read.acmap("data/seq-t9a-mod27.ace")

ag_seq <- agSequences(map_2004)
sr_seq <- srSequences(map_2004)

pick_ag <- which(apply(ag_seq, 1, "[[", 145)=="K" & 
                   (apply(ag_seq, 1, "[[", 156)=="K" | 
                      apply(ag_seq, 1, "[[", 156)=="Q" |
                      apply(ag_seq, 1, "[[", 156)=="H") &
                   apply(ag_seq, 1, "[[", 189)=="S")


pick_sr <- which(apply(sr_seq, 1, "[[", 145)=="K" & 
                   (apply(sr_seq, 1, "[[", 156)=="K" | 
                      apply(sr_seq, 1, "[[", 156)=="Q" |
                      apply(sr_seq, 1, "[[", 156)=="H") &
                   apply(sr_seq, 1, "[[", 189)=="S")

small_map <- subsetMap(map_2004, pick_ag, pick_sr)

write.csv(titerTable(small_map), "data/small-dataset.csv")


# simulating a second data set by adding noise
small_map2 <- small_map
set.seed(42)
tt <- 10*2^round(logtiterTable(small_map)+rnorm(length(logtiterTable(small_map)), mean=0, sd=0.5))
tt[tt<20] <- "<20"
tt[tt=="NaN"] <- "*"
titerTable(small_map2) <- tt

write.csv(titerTable(small_map2), "data/small-dataset-2.csv")

