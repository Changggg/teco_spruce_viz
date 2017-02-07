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

#firstday = as.numeric(as.Date('2016-10-10') - as.Date('2011-01-01'))
#curday = as.numeric(currentdate - as.Date('2011-01-01'))
#lastday = curday+6



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

#days<-seq(as.Date('2016-10-10'),currentdate+6, "days")

days<-format(days, format="%m/%d/%Y")


data.gpp.weekly<-data.frame(date=days,gpp=gpp_mean,gpp_high=gpp_mean+gpp_std,gpp_low=gpp_mean-gpp_std,
                            nee=nee_mean, nee_high=nee_mean + nee_std, nee_low= nee_mean - nee_std, 
                            er =er_mean,  er_high =er_mean  + er_std,  er_low = er_mean  - er_std,
                            foliage=foliage_mean,foliage_high = foliage_mean + foliage_std, foliage_low = foliage_mean - foliage_std,
                            wood=wood_mean,wood_high = wood_mean + wood_std, wood_low = wood_mean - wood_std,
                            root=root_mean,root_high = root_mean + root_std, root_low = root_mean - root_std,
                            soil=soil_mean,soil_high = soil_mean + soil_std, soil_low = soil_mean - soil_std)


currenthour=format(Sys.time(), "%H")
currentyear=format(Sys.time(), "%Y")
#outhour=3

col_header<-c('date','gpp (g m-2 day-1)','gpp_high (g m-2 day-1)', 'gpp_low (g m-2 day-1)',
              'nee (g m-2 day-1)','nee_high (g m-2 day-1)', 'nee_low (g m-2 day-1)',
              'er (g m-2 day-1)', 'er_high (g m-2 day-1)',  'er_low (g m-2 day-1)',
              'foliage_C (g m-2)','foliage_C_high (g m-2)', 'foliage_C_low (g m-2)',
              'wood_C (g m-2)','wood_C_high (g m-2)', 'wood_C_low (g m-2)',
              'root_C (g m-2)','root_C_high (g m-2)', 'root_C_low (g m-2)',
              'soil_C (g m-2)','soil_C_high (g m-2)', 'soil_C_low (g m-2)' )

#outtxt_name=paste(currentyear,"-temp-",sprintf("%s",args4),"-co2-",sprintf("%s",args5),".txt",sep='')
#outcsv_name=paste(currentyear,"-temp-",sprintf("%s",args4),"-co2-",sprintf("%s",args5),".csv",sep='')

# modified 01_04_2017, stick on one file for all the years 
outtxt_name=paste("temp-",sprintf("%s",args4),"-co2-",sprintf("%s",args5),".txt",sep='')
outcsv_name=paste("temp-",sprintf("%s",args4),"-co2-",sprintf("%s",args5),".csv",sep='')


print(outcsv_name)

#write.table(data.gpp.weekly, file = outtxt_name, sep = ",", col.names = col_header,
#row.names = F, qmethod = "double")

write.table(data.gpp.weekly, file = outtxt_name, sep = ",", col.names = col_header,
   row.names = F, quote = FALSE,eol="\r\n")

file.rename(outtxt_name,outcsv_name)  # in order to add double quote

