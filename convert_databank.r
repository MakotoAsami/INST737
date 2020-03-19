# load csv file to data frame
bank <- read.csv("Databank_1.csv", stringsAsFactors=FALSE)

# delete eccessive rows
bank <- bank[-(4921:4925),]

# repeat for each year (2000-2012)
for(j in 0:12) {

	# create new data frame with 1 row per country x year
	bank_year <- data.frame(Country.Name=c("Afghanistan"),Country.Code=c("AFG"),Year=2000+j,NY.GDP.MKTP.KD.ZG=c(0),
		NY.GDP.MKTP.CD=c(0),NY.GDP.PCAP.CD=c(0),NY.GNP.PCAP.CD=c(0),NE.EXP.GNFS.ZS=c(0),BN.KLT.DINV.CD=c(0),
		NY.GNP.PCAP.PP.CD=c(0),SI.POV.GINI=c(0),FP.CPI.TOTL.ZG=c(0),NY.GDP.DEFL.KD.ZG=c(0),IT.NET.USER.P2=c(0),
		NE.IMP.GNFS.ZS=c(0),SP.DYN.LE00.IN=c(0),SE.ADT.LITR.ZS=c(0),SL.UEM.TOTL.ZS=c(0),SI.POV.NAHC=c(0),
		NV.AGR.TOTL.ZS=c(0),EN.ATM.CO2E.PC=c(0),GC.DOD.TOTL.GD.ZS=c(0),SP.POP.TOTL=c(0),stringsAsFactors=FALSE)

	# transfer data from original dataset to new format using for loop
	for(i in 1:nrow(bank)) {
		# when country code matches, copy data of the year to applicable column
		if(bank[i,4] %in% bank_year[,2]) {
			bank_year[bank_year[,1]==bank[i,3],c(bank[i,2])] <- bank[i,j+5]
		# when country code doesn't match, add a row for the country and copy data of the year to applicable column
  		} else {
			newRow <- data.frame(Country.Name=bank[i,3],Country.Code=bank[i,4],Year=2000+j,NY.GDP.MKTP.KD.ZG=c(0),
				NY.GDP.MKTP.CD=c(0),NY.GDP.PCAP.CD=c(0),NY.GNP.PCAP.CD=c(0),NE.EXP.GNFS.ZS=c(0),
				BN.KLT.DINV.CD=c(0),NY.GNP.PCAP.PP.CD=c(0),SI.POV.GINI=c(0),FP.CPI.TOTL.ZG=c(0),
				NY.GDP.DEFL.KD.ZG=c(0),IT.NET.USER.P2=c(0),NE.IMP.GNFS.ZS=c(0),SP.DYN.LE00.IN=c(0),
				SE.ADT.LITR.ZS=c(0),SL.UEM.TOTL.ZS=c(0),SI.POV.NAHC=c(0),NV.AGR.TOTL.ZS=c(0),EN.ATM.CO2E.PC=c(0),
				GC.DOD.TOTL.GD.ZS=c(0),SP.POP.TOTL=c(0),stringsAsFactors=FALSE)
			bank_year <- rbind(bank_year,newRow)
			bank_year[bank_year[,1]==bank[i,3],c(bank[i,2])] <- bank[i,j+5]
		}
	}

	# delete rows for aggregated data
	bank_year <- bank_year[-(215:246),]
	
	# combine table of the year with table for previous years
	if(j==0) {
		bank_all <- bank_year
	} else {
		bank_all <- rbind(bank_all,bank_year)
	}

}

# convert chr type to numeric type
bank_all$NY.GDP.MKTP.KD.ZG <- as.numeric(bank_all$NY.GDP.MKTP.KD.ZG)
bank_all$NY.GDP.MKTP.CD <- as.numeric(bank_all$NY.GDP.MKTP.CD)
bank_all$NY.GDP.PCAP.CD <- as.numeric(bank_all$NY.GDP.PCAP.CD)
bank_all$NY.GNP.PCAP.CD <- as.numeric(bank_all$NY.GNP.PCAP.CD)
bank_all$NE.EXP.GNFS.ZS <- as.numeric(bank_all$NE.EXP.GNFS.ZS)
bank_all$BN.KLT.DINV.CD <- as.numeric(bank_all$BN.KLT.DINV.CD)
bank_all$NY.GNP.PCAP.PP.CD <- as.numeric(bank_all$NY.GNP.PCAP.PP.CD)
bank_all$SI.POV.GINI <- as.numeric(bank_all$SI.POV.GINI)
bank_all$FP.CPI.TOTL.ZG <- as.numeric(bank_all$FP.CPI.TOTL.ZG)
bank_all$NY.GDP.DEFL.KD.ZG <- as.numeric(bank_all$NY.GDP.DEFL.KD.ZG)
bank_all$IT.NET.USER.P2 <- as.numeric(bank_all$IT.NET.USER.P2)
bank_all$NE.IMP.GNFS.ZS <- as.numeric(bank_all$NE.IMP.GNFS.ZS)
bank_all$SP.DYN.LE00.IN <- as.numeric(bank_all$SP.DYN.LE00.IN)
bank_all$SE.ADT.LITR.ZS <- as.numeric(bank_all$SE.ADT.LITR.ZS)
bank_all$SL.UEM.TOTL.ZS <- as.numeric(bank_all$SL.UEM.TOTL.ZS)
bank_all$SI.POV.NAHC <- as.numeric(bank_all$SI.POV.NAHC)
bank_all$NV.AGR.TOTL.ZS <- as.numeric(bank_all$NV.AGR.TOTL.ZS)
bank_all$EN.ATM.CO2E.PC <- as.numeric(bank_all$EN.ATM.CO2E.PC)
bank_all$GC.DOD.TOTL.GD.ZS <- as.numeric(bank_all$GC.DOD.TOTL.GD.ZS)
bank_all$SP.POP.TOTL <- as.numeric(bank_all$SP.POP.TOTL)

# install ggplots package
install.packages("ggplot2")
library(ggplot2)

# plot each country's population and GDP
ggplot(data=bank_all,aes(x=SP.POP.TOTL,y=NY.GDP.MKTP.CD))+geom_point(size=3)

# output as csv file
write.csv(bank_all, file="bank_all.csv")
