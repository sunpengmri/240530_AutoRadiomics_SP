#!/usr/bin/bash

RawPath=/home/peng/01_data/02_radiomics/data
TargetPath=/home/peng/00_github/03_radiomics/240530_AutoRadiomics_SP/examples/autorad_tutorial/data


sublist=($(ls $RawPath));



# # 4. for qianfoshan & shanxi nii data

# sublist=($(ls $RawPath | sed 's/\.nii\.gz$//'));

# for sub in ${sublist[@]};
# # for sub in ${sublist};  
# do   
#     mkdir -p ${TargetPath}/${sub};

#     cp ${RawPath}/${sub}.nii.gz ${TargetPath}/${sub}/${sub}_0000.nii.gz
    
# done

# # 5. for shenzhen nii data
# sublist=($(ls $RawPath | sed 's/\_0000.nii\.gz$//'));
# echo ${sublist[@]}

for sub in ${sublist[@]};
# for sub in ${sublist};  
do   
    mkdir -p ${TargetPath}/${sub};

    cp ${RawPath}/${sub}/1/NIFTI/*.nii.gz ${TargetPath}/${sub}/
    
done
