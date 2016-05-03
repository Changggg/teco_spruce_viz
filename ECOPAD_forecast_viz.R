

args = commandArgs(TRUE)
library(ggplot2)
# args[1] is the directory for observation files
# args[2] is the directory for simulation files
# args[3] is output directory of graphs
# args[4] is the number of iterations
#args1 = "obs_file/SPRUCE_obs.txt"
#args2 = "graphoutput/Simu_dailyflux.txt"
#args3 = "graphoutput"
args1 = args[1]
#"E:/OU/MCMC/ECOPAD_TECO_SPRUCE/input/SPRUCE_obs.txt"
args2 = args[2] 
#"E:/OU/MCMC/ECOPAD_TECO_SPRUCE/output/"
args3 = args[3] 
# "E:/OU/MCMC/ECOPAD_TECO_SPRUCE/graphoutput"


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

setwd(args2)
k=1
filename = paste("Simu_dailyflux",sprintf("%03d",k),".txt",sep='')
tmp <- read.table(filename,sep=",")
tspan = nrow(tmp)
years = floor(tspan/365)+1
ind = as.integer(args[4])
days.mat = matrix(nrow=tspan,ncol=ind)
gpp.mat = matrix(nrow=tspan,ncol=ind)
nee.mat = matrix(nrow=tspan,ncol=ind)
er.mat = matrix(nrow=tspan,ncol=ind)
foliage.mat = matrix(nrow=tspan,ncol=ind)
wood.mat = matrix(nrow=tspan,ncol=ind)
root.mat = matrix(nrow=tspan,ncol=ind)
soil.mat = matrix(nrow=tspan,ncol=ind)

for(k in 1:ind){
  filename = paste("Simu_dailyflux",sprintf("%03d",k),".txt",sep='')
  tmp <- read.table(filename,sep=",")
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
  
  days.mat[,k]=days
  gpp.mat[,k]=gpp
  nee.mat[,k]=nee
  er.mat[,k]=er
  foliage.mat[,k]=foliage
  wood.mat[,k]=wood
  root.mat[,k]=root
  soil.mat[,k]=soil
}

setwd(args3)
png(height=1200, width=1400,pointsize=40, file="gpp_forecast.png")
plot(days,gpp.mat[,1],type='l',axes=FALSE,xlab="Years",ylab="GPP",ylim=c(0,14))
for(i in 2:ind){
  lines(days,gpp.mat[,i])
}
ticks=c(0,365,365*2+1,365*3+1,365*4+1,365*5+1,365*6+2,365*7+2,365*8+2,
        365*9+2,365*10+3,365*11+3,365*12+3,365*13+3,365*14+3)
xticklab=c("2011","2012","2013","2014","2015","2016","2017",
           "2018","2019","2020","2021","2022","2023","2024","2025")
axis(side=1,at=ticks[1:years],labels=xticklab[1:years])
axis(side=2)
points(daily,dailygpp,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="er_forecast.png")
plot(days,er.mat[,1],type='l',axes=FALSE,xlab="Years",ylab="ER",ylim=c(0,10))
for(i in 2:ind){
  lines(days,er.mat[,i])
}
axis(side=1,at=ticks[1:years],labels=xticklab[1:years])
axis(side=2)
points(daily,dailyer,col='red',pch=19)
dev.off()

png(height=1200, width=1400,pointsize=40, file="foliage_forecast.png")
mean1 = rowMeans(foliage.mat)
std1 = apply(foliage.mat,1,sd)
lowb = mean1-std1
highb = mean1+std1
data.foliage <- data.frame(days=days,foliage=mean1)
points.foliage<-data.frame(days=daily,foliage=dailyfoliage)
ggplot(data.foliage,aes(x=days,y=foliage)) +
  theme_bw()+
  geom_point(data=points.foliage,col="red",size=10)+
  geom_smooth(aes(ymin=lowb,ymax=highb),stat='identity',size=3,fill="#008B00") +
  labs(x="Years",y="Foliage") +
  scale_x_continuous(breaks=ticks[1:years],labels=xticklab[1:years])+
  theme(axis.text = element_text(size=23),axis.title=element_text(size=rel(1.8)))
dev.off()

png(height=1200, width=1400,pointsize=40, file="wood_forecast.png")
mean1 = rowMeans(wood.mat)
std1 = apply(wood.mat,1,sd)
lowb = mean1-std1
highb = mean1+std1
data.wood <- data.frame(days=days,wood=mean1)
points.wood<-data.frame(days=daily,wood=dailywood)
ggplot(data.wood,aes(x=days,y=wood)) +
  theme_bw()+
  geom_point(data=points.wood,col="red",size=10)+
  geom_smooth(aes(ymin=lowb,ymax=highb),stat='identity',size=3,fill="#008B00") +
  labs(x="Years",y="Wood") +
  scale_x_continuous(breaks=ticks[1:years],labels=xticklab[1:years])+
  theme(axis.text = element_text(size=23),axis.title=element_text(size=rel(1.8)))
dev.off()

png(height=1200, width=1400,pointsize=40, file="root_forecast.png")
mean1 = rowMeans(root.mat)
std1 = apply(root.mat,1,sd)
lowb = mean1-std1
highb = mean1+std1
data.root <- data.frame(days=days,root=mean1)
points.root<-data.frame(days=daily,root=dailyroot)
ggplot(data.root,aes(x=days,y=root)) +
  theme_bw()+
  geom_smooth(aes(ymin=lowb,ymax=highb),stat='identity',size=3,fill="#008B00") +
  geom_point(data=points.root,col="red",size=10)+
  labs(x="Years",y="Root") +
  scale_x_continuous(breaks=ticks[1:years],labels=xticklab[1:years])+
  theme(axis.text = element_text(size=23),axis.title=element_text(size=rel(1.8)))
dev.off()

png(height=1200, width=1400,pointsize=40, file="soil_forecast.png")
mean1 = rowMeans(soil.mat)
std1 = apply(soil.mat,1,sd)
lowb = mean1-std1
highb = mean1+std1
data.soil <- data.frame(days=days,soil=mean1)
points.soil<-data.frame(days=daily,soil=dailysoilc)
ggplot(data.soil,aes(x=days,y=soil)) +
  theme_bw()+
  geom_smooth(aes(ymin=lowb,ymax=highb),stat='identity',size=3,fill="#008B00") +
  geom_point(data=points.soil,col="red",size=10)+
  labs(x="Years",y="Soil C") +
  scale_x_continuous(breaks=ticks[1:years],labels=xticklab[1:years])+
  theme(axis.text = element_text(size=23),axis.title=element_text(size=rel(1.8)))
dev.off()

