args = commandArgs(TRUE)

# args[1] is the directory for simulation files
# args[2] is output directory of csv file
# args[3] is the number of iterations
# args[4] is temperature treatment 
# args[5] is co2_treatment 

#args1 = "graphoutput/Simu_dailyflux.txt"
#args2 = "graphoutput"
args1 = args[1] 
args2 = args[2] 
args4 = args[4]
args5 = args[5]

currentdate = Sys.Date()
firstday = as.numeric(currentdate - as.Date('2011-01-01'))
lastday = firstday+6


setwd(args1)
#setwd("C:/Users/yuanyuan/Desktop")
k=1
filename = paste("Simu_dailyflux",sprintf("%03d",k),".txt",sep='')
tmp <- read.table(filename,sep=",")
tspan = nrow(tmp)
years = floor(tspan/365)+1
ind = as.integer(args[3])
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

setwd(args2)

gpp_mean = rowMeans(gpp.mat[firstday:lastday,])
gpp_std = apply(gpp.mat[firstday:lastday,],1,sd)

nee_mean = rowMeans(nee.mat[firstday:lastday,])
nee_std = apply(nee.mat[firstday:lastday,],1,sd)


er_mean = rowMeans(er.mat[firstday:lastday,])
er_std = apply(er.mat[firstday:lastday,],1,sd)

foliage_mean = rowMeans(foliage.mat[firstday:lastday,])
foliage_std = apply(foliage.mat[firstday:lastday,],1,sd)

wood_mean = rowMeans(wood.mat[firstday:lastday,])
wood_std = apply(wood.mat[firstday:lastday,],1,sd)

root_mean = rowMeans(root.mat[firstday:lastday,])
root_std = apply(root.mat[firstday:lastday,],1,sd)

soil_mean = rowMeans(soil.mat[firstday:lastday,])
soil_std = apply(soil.mat[firstday:lastday,],1,sd)

days<-seq(currentdate,currentdate+6, "days")



data.gpp.weekly<-data.frame(date=days,gpp=gpp_mean,gpp_sd=gpp_std,nee=nee_mean, 
          nee_sd=nee_std,er=er_mean,er_sd=er_std,foliage=foliage_mean,foliage_sd=foliage_std,
          wood=wood_mean,wood_sd=wood_std,root=root_mean,root_sd=root_std,soil=soil_mean,
          soil_sd=soil_std)

currenthour=format(Sys.time(), "%H")
currentyear=format(Sys.time(), "%Y")
#outhour=3

outcsv_name=paste(currentyear,"-temp-",sprintf("%s",args4),"-co2-",sprintf("%s",args5),".csv",sep='')
print(outcsv_name)

write.table(data.gpp.weekly, file = outcsv_name, sep = ",", col.names = T,
row.names = F, qmethod = "double")

