

args = commandArgs(TRUE)
# args[1] is the directory for observation files
# args[2] is the directory for simulation files
# args[2] is output directory of graphs
args1 = "obs_file/SPRUCE_obs.txt"
args2 = "graphoutput/Simu_dailyflux001.txt"
args3 = "graphoutput"

tmp <- read.table(args1,header=TRUE,sep="")
daily = tmp[,1]
dailygpp = tmp[,2]
dailygpp[dailygpp==-9999]=NA
dailynee = tmp[,4]
dailynee[dailynee==-9999]=NA
dailyer = tmp[,6]
dailyer[dailyer==-9999]=NA
dailyfoliage = tmp[,8]
dailyfoliage[dailyfoliage==-9999]=NA
dailyfnpp = tmp[,10]
dailyfnpp[dailyfnpp==-9999]=NA
dailywood = tmp[,12]
dailywood[dailywood==-9999]=NA
dailywnpp = tmp[,14]
dailywnpp[dailywnpp==-9999]=NA
dailyroot = tmp[,16]
dailyroot[dailyroot==-9999]=NA
dailyrnpp = tmp[,18]
dailyrnpp[dailyrnpp==-9999]=NA
dailysoilc = tmp[,20]
dailysoilc[dailysoilc==-9999]=NA
dailypheno = tmp[,22]
dailypheno[dailypheno==-9999]=NA

tmp <- read.table(args2,sep=",")
days = tmp[,1]
gpp = tmp[,2]
nee = tmp[,3]
er = tmp[,4]
foliage = tmp[,5]
fnpp = tmp[,6]
wood = tmp[,7]
wnpp = tmp[,8]
root = tmp[,9]
rnpp = tmp[,10]
soil = tmp[,11]
phenology = tmp[,12]
LAI = tmp[,13]

setwd(args3)
png(height=1200, width=1400,pointsize=40, file="gpp.png")
plot(days,gpp,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("GPP (g ",m^-2,day^-1,")")),line=2.3,cex=1.2) 
ticks=c(0,365,365*2,365*3,365*4,365*5,365*6)
xticklab=c("2011","2012","2013","2014","2015","2016","2017")
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailygpp,col='red',pch=19)
dev.off()


png(height=1200, width=1400,pointsize=40, file="er.png")
plot(days,er,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("ER (g ",m^-2,day^-1,")")),line=2.3,cex=1.2) 
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailyer,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="foliage.png")
plot(days,foliage,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("Foliage C (g ",m^-2,")")),line=2.3,cex=1.2) 
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailyfoliage,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="wood.png")
plot(days,wood,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("Wood C (g ",m^-2,")")),line=2.3,cex=1.2) 
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailywood,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="root.png")
plot(days,root,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("Root C (g ",m^-2,")")),line=2.3,cex=1.2) 
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailyroot,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="soil.png")
plot(days,soil,type='l',axes=FALSE,xlab="Years",ylab="")
mtext(side = 2, expression(paste("Soil C (g ",m^-2,")")),line=2.3,cex=1.2) 
axis(side=1,at=ticks,labels=xticklab)
axis(side=2)
points(daily,dailysoilc,col='red',pch=19)
dev.off()
