# This script sends a job to the remote node

# Update this section
user=benb
phenofile=infection-heart_ukb_v1_phenotypeConstructLT_2020-10-28.txt
phenokey=infection-heart_ukb_v1_phenotypeConstructLT_2020-10-28_key.txt
folder=/mnt/archive/phenotypes/constructs/phenoCons/example/

#### Do NOT change anything below ####
WARNING=yes

if [ "$WARNING" == "yes" ] ; then
 read -r -p "Have you checked that no one else is running a job? Continue? [Y/n] " input

 case $input in
   [yY][eE][sS]|[yY])
     echo "Continue"
     ;;
   [nN][oO]|[nN])
     exit 1
     ;;
   *)
     echo "Invalid input..."
     exit 1
     ;;
 esac
fi

# Copy pheno files
rsync -avP ${folder}/${phenokey} ubuntu@hunt-ukbb-iaas-theem:/home/ubuntu/mnt-ukbb/pheno/
rsync -avP ${folder}/${phenofile} ubuntu@hunt-ukbb-iaas-theem:/home/ubuntu/mnt-ukbb/pheno/

# Send job
ssh ubuntu@hunt-ukbb-iaas-theem 'bash /home/ubuntu/mnt-ukbb/scripts/run.sh '${phenofile}' '${phenokey}''

wait

# Move results
outdir=/mnt/scratch/output/${user}
mkdir -p ${outdir}

rsync -av --remove-source-files -P ubuntu@hunt-ukbb-iaas-theem:/home/ubuntu/mnt-ukbb/output/* ${outdir}

# Done - no checks
echo 'Completed'
echo "Your output can be found here '${outdir}'"
