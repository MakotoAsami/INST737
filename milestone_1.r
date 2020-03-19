# load csv file to data frame
bank <- read.csv("Databank_1.csv", stringsAsFactors=FALSE)

# delete eccessive rows
bank <- bank[-(4921:4925),]

# create new data frame for 2012 data with 1 row per country
bank2012 <- data.frame(Country.Name=c("Afghanistan"),Country.Code=c("AFG"),NY.GDP.MKTP.KD.ZG=c(0),
	NY.GDP.MKTP.CD=c(0),NY.GDP.PCAP.CD=c(0),NY.GNP.PCAP.CD=c(0),NE.EXP.GNFS.ZS=c(0),BN.KLT.DINV.CD=c(0),
	NY.GNP.PCAP.PP.CD=c(0),SI.POV.GINI=c(0),FP.CPI.TOTL.ZG=c(0),NY.GDP.DEFL.KD.ZG=c(0),IT.NET.USER.P2=c(0),
	NE.IMP.GNFS.ZS=c(0),SP.DYN.LE00.IN=c(0),SE.ADT.LITR.ZS=c(0),SL.UEM.TOTL.ZS=c(0),SI.POV.NAHC=c(0),
	NV.AGR.TOTL.ZS=c(0),EN.ATM.CO2E.PC=c(0),GC.DOD.TOTL.GD.ZS=c(0),SP.POP.TOTL=c(0),stringsAsFactors=FALSE)

# transfer data from original dataset to new format using for loop
for(i in 1:nrow(bank)) {
	# when country code matches, copy 2012 data to applicable column
	if(bank[i,4] %in% bank2012[,2]) {
		bank2012[bank2012[,1]==bank[i,3],c(bank[i,2])] <- bank[i,c("X2012")]
	# when country code doesn't match, add a row for the country and copy 2012 data to applicable column
  	} else {
		newRow <- data.frame(Country.Name=bank[i,3],Country.Code=bank[i,4],NY.GDP.MKTP.KD.ZG=c(0),
			NY.GDP.MKTP.CD=c(0),NY.GDP.PCAP.CD=c(0),NY.GNP.PCAP.CD=c(0),NE.EXP.GNFS.ZS=c(0),
			BN.KLT.DINV.CD=c(0),NY.GNP.PCAP.PP.CD=c(0),SI.POV.GINI=c(0),FP.CPI.TOTL.ZG=c(0),
			NY.GDP.DEFL.KD.ZG=c(0),IT.NET.USER.P2=c(0),NE.IMP.GNFS.ZS=c(0),SP.DYN.LE00.IN=c(0),
			SE.ADT.LITR.ZS=c(0),SL.UEM.TOTL.ZS=c(0),SI.POV.NAHC=c(0),NV.AGR.TOTL.ZS=c(0),EN.ATM.CO2E.PC=c(0),
			GC.DOD.TOTL.GD.ZS=c(0),SP.POP.TOTL=c(0),stringsAsFactors=FALSE)
		bank2012 <- rbind(bank2012,newRow)
		bank2012[bank2012[,1]==bank[i,3],c(bank[i,2])] <- bank[i,c("X2012")]
	}
}

# convert chr type to numeric type
bank2012$NY.GDP.MKTP.KD.ZG <- as.numeric(bank2012$NY.GDP.MKTP.KD.ZG)
bank2012$NY.GDP.MKTP.CD <- as.numeric(bank2012$NY.GDP.MKTP.CD)
bank2012$NY.GDP.PCAP.CD <- as.numeric(bank2012$NY.GDP.PCAP.CD)
bank2012$NY.GNP.PCAP.CD <- as.numeric(bank2012$NY.GNP.PCAP.CD)
bank2012$NE.EXP.GNFS.ZS <- as.numeric(bank2012$NE.EXP.GNFS.ZS)
bank2012$BN.KLT.DINV.CD <- as.numeric(bank2012$BN.KLT.DINV.CD)
bank2012$NY.GNP.PCAP.PP.CD <- as.numeric(bank2012$NY.GNP.PCAP.PP.CD)
bank2012$SI.POV.GINI <- as.numeric(bank2012$SI.POV.GINI)
bank2012$FP.CPI.TOTL.ZG <- as.numeric(bank2012$FP.CPI.TOTL.ZG)
bank2012$NY.GDP.DEFL.KD.ZG <- as.numeric(bank2012$NY.GDP.DEFL.KD.ZG)
bank2012$IT.NET.USER.P2 <- as.numeric(bank2012$IT.NET.USER.P2)
bank2012$NE.IMP.GNFS.ZS <- as.numeric(bank2012$NE.IMP.GNFS.ZS)
bank2012$SP.DYN.LE00.IN <- as.numeric(bank2012$SP.DYN.LE00.IN)
bank2012$SE.ADT.LITR.ZS <- as.numeric(bank2012$SE.ADT.LITR.ZS)
bank2012$SL.UEM.TOTL.ZS <- as.numeric(bank2012$SL.UEM.TOTL.ZS)
bank2012$SI.POV.NAHC <- as.numeric(bank2012$SI.POV.NAHC)
bank2012$NV.AGR.TOTL.ZS <- as.numeric(bank2012$NV.AGR.TOTL.ZS)
bank2012$EN.ATM.CO2E.PC <- as.numeric(bank2012$EN.ATM.CO2E.PC)
bank2012$GC.DOD.TOTL.GD.ZS <- as.numeric(bank2012$GC.DOD.TOTL.GD.ZS)
bank2012$SP.POP.TOTL <- as.numeric(bank2012$SP.POP.TOTL)

# delete rows for aggregated data
bank2012 <- bank2012[-(215:246),]

# install ggplots package
install.packages("ggplot2")
library(ggplot2)

# plot each country's population and GDP
ggplot(data=bank2012,aes(x=SP.POP.TOTL,y=NY.GDP.MKTP.CD))+geom_point(size=3)

