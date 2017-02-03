# Download data from: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/22892

# or use the dataverse package:
if ("Klar_AJPS_4.dta" %in% dir()) {
    if (!require("ghit")) {
        install.packages("ghit")
        library("ghit")
    }
    ghit::install_github("IQSS/dataverse-client-r")
    library("dataverse")
    d <- dataverse::get_file("Klar_AJPS_4.dta", dataset = "doi:10.7910/DVN/22892")
    writeBin(as.raw(d), con = "Klar_AJPS_4.dta")
}

# load the data
if (!require("rio")) {
    install.packages("rio")
    library("rio")
}
dat <- rio::import("Klar_AJPS_4.dta")

# analysis focuses only on Democrats
dems <- dat[dat[["pid"]] %in% 1:3,]
dim(dems)
# [1] 277  49

# treatment variable
table(dems[["condition_number"]])
dems[["treatment"]] <- NA_real_
dems[["treatment"]][dems[["condition_number"]] == 2] <- 1L
dems[["treatment"]][dems[["condition_number"]] == 3] <- 4L
dems[["treatment"]][dems[["condition_number"]] == 4] <- 2L
dems[["treatment"]][dems[["condition_number"]] == 5] <- 5L
dems[["treatment"]][dems[["condition_number"]] == 6] <- 3L
dems[["treatment"]][dems[["condition_number"]] == 7] <- 6L
dems[["ambivalent"]] <- NA_real_
dems[["ambivalent"]][dems[["treatment"]] %in% 1:3] <- 1L
dems[["ambivalent"]][dems[["treatment"]] %in% 4:6] <- 0L
dems[["group_type"]] <- NA_real_
dems[["group_type"]][dems[["treatment"]] %in% c(1,4)] <- 0L
dems[["group_type"]][dems[["treatment"]] %in% c(2,5)] <- 1L # homogeneous
dems[["group_type"]][dems[["treatment"]] %in% c(3,6)] <- 2L # heterogeneous


# Figure 1
aggregate(energypriority ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
aggregate(healthpriority ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energypriority ~ ambivalent, data = dems))
summary(lm(healthpriority ~ ambivalent, data = dems))

# Figure 2
aggregate(oil ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
aggregate(alternative ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
aggregate(competition ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
aggregate(subsidies ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(oil ~ ambivalent, data = dems))
summary(lm(alternative ~ ambivalent, data = dems))
summary(lm(competition ~ ambivalent, data = dems))
summary(lm(subsidies ~ ambivalent, data = dems))

# Figure 3
aggregate(energypriority ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
aggregate(healthpriority ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energypriority ~ group_type, data = dems))
summary(lm(healthpriority ~ group_type, data = dems))

# Figure 4
aggregate(oil ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
aggregate(alternative ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
aggregate(competition ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
aggregate(subsidies ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(oil ~ group_type, data = dems))
summary(lm(alternative ~ group_type, data = dems))
summary(lm(competition ~ group_type, data = dems))
summary(lm(subsidies ~ group_type, data = dems))

# Figure 5
aggregate(energypriority ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
aggregate(healthpriority ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energypriority ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))
summary(lm(healthpriority ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))

# Figure 6
aggregate(oil ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
aggregate(competition ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
## regression version
summary(lm(oil ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))
summary(lm(competition ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))

# Figure 7
aggregate(energygroup ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
aggregate(healthgroup ~ ambivalent, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energygroup ~ ambivalent, data = dems))
summary(lm(healthgroup ~ ambivalent, data = dems))

# Figure 8
aggregate(energygroup ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
aggregate(healthgroup ~ group_type, data = dems, FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energygroup ~ group_type, data = dems))
summary(lm(healthgroup ~ group_type, data = dems))

# Figure 9
aggregate(energygroup ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
aggregate(healthgroup ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),], FUN = mean, na.rm = TRUE)
## regression version
summary(lm(energygroup ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))
summary(lm(healthgroup ~ ambivalent + group_type, data = dems[!dems[["treatment"]] %in% c(1,4),]))
