

args = commandArgs(TRUE)
library(ggplot2)
# args[1] is the directory for observation files
# args[2] is the directory for simulation files
# args[2] is output directory of graphs
#args1 = "obs_file/SPRUCE_obs.txt"
args2 = "graphoutput/Simu_dailyflux.txt"
args3 = "graphoutput"

args2 = args[1]
#args2 = "E:/OU/MCMC/ECOPAD_TECO_SPRUCE/output/Paraest.txt"
args3 = args[2]
#args3 = "E:/OU/MCMC/ECOPAD_TECO_SPRUCE/graphoutput"

par.string = c('lat','longi','wsmax','wsmin','LAImax','LAImin','rdepth',
               'Rootmax','Stemmax','SapR','SapS','SLA','GLmax','GRmax',
               'GSmax','stom_n','a1','Ds0','Vcmax','extkU','xfang',
               'alpha','Tau_leaf','Tau_wood','Tau_root','Tau_fine',
               'Tau_coarse','Tau_fast','Tau_slow','Tau_passive',
               'GDDonset','Q10','RL0','RS0','Rr0')
npara = scan(args2,nlines=1)
da.varname = scan(args2,skip=1,nlines=1,sep="")
tmp <- read.table(args2,skip=2,sep=",")
len2 = nrow(tmp)
len1 = floor(len2/2)
tmp <- tmp[len1:len2,c(-npara-2)]
data.reshape = reshape(tmp,idvar="V1",varying=list(2:(npara+1)),direction="long")
data.reshape$time = as.factor(data.reshape$time)
levels(data.reshape$time) <- par.string[da.varname]

setwd(args3)
png(height=1200, width=1400,pointsize=40, file="histogram.png")
ggplot(data.reshape,aes(V2)) + geom_histogram() + facet_wrap(~ time,scales="free_x") +
  theme(strip.text.x = element_text(size = 20)) +
  labs(x="",y="Frequency") +
  theme(axis.text = element_text(size=20),axis.title=element_text(size=rel(1.8)))
dev.off()




