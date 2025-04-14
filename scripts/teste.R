library(PaSIM)

SIM2 <- download.SIM(uf = "CE", period = (2010:2023))

download.SIM(uf = "CE", period = (2019:2023))

SIM2L <- process.SIM(SIM2)

base <- SIM2L %>%
    filter(FAIXA_ETARIA=="<1 ano")

table(SIM3$FAIXA_ETARIA)

fSIM <- panel.SIM(SIM2L)

base_panel <- panel.SIM(base)

save("fSIM","CID", file = "X:/USID/BOLSA_PIT_ESTATISTICA_2024/SIM/dataset.Rdata")

data <- as.integer(as.character(SIM$IDADE))<400
data <- data==T
table(data)

str(SIM2L)

save("base",file ="X:/USID/BOLSA_PIT_ESTATISTICA_2024/SIM/infantil.Rdata")

save("base_panel",file ="X:/USID/BOLSA_PIT_ESTATISTICA_2024/SIM/infantil_panel.Rdata")
