# launch-ukbb-gwas
Run GWAS in UKBB on a remote node

## Defaults
### Rank normalize quantitative outcome
QuantOutcomeRankNorm=FALSE

### Extract unrelated individuals
doExtractUnrel=FALSE

### Minimum allele count to filter final results and plot
minmac=3

### Minimum allele frequency to filter final results and plot
minmaf=0

### Minimum imputation score to filter variants when running SAIGE step2 from bgen files
mininfo=0.3

## How to
### Step 1 - create your job
`cd ~/scratch/repo/launch-ukbb-gwas`     
`cp launch.sh launch_your_job.sh`     
`vim launch_your_job.sh`     

Edit your job details     

This is your user name     
user=benb     
This is the name of the file with the phenotype     
phenofile=infection-heart_ukb_v1_phenotypeConstructLT_2020-10-28.txt     
This is the name of the file with information about the GWAS you are about to run     
phenokey=infection-heart_ukb_v1_phenotypeConstructLT_2020-10-28_key.txt     
This is the folder that contains the above files     
folder=/mnt/archive/phenotypes/constructs/phenoCons/example/    

HINT: To edit in vim type `i`     
To save and exit type `:wq`

### Step 2 - check if the machine is free          
`bash cpumem.sh`          

If %CPU and %MEM are not 0 please check who is doing what on Slack.      
There is no queing system for jobs and you need to communicate with others.     
If you have >10 jobs, please let Ben or Laurent know and it might be possible to set up another machine.        

### Step 3 - send your job
#### Open screen     
`screen -S job_name`     
`bash launch_your_job.sh`   

HINT: To edit detach from screen press `ctr + a then d`     
To reattach type `screen -r`

### Step 4 - move your results     
Your results can be found here:     
`/mnt/scratch/output/${user}`     

You can move the result out using cargo or by ordering a kista     
https://docs.hdc.ntnu.no/data-transfer/internal-kista/     
