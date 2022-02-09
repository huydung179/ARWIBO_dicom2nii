#!/bin/bash

usage()
{
    echo "Usage: "
    echo "$0 <dcm_image_directory> [output_directory]"
    exit 1
}

if [ $# -eq 0 ]; then
    echo "ERROR: no input image path provided"
    usage
    exit 1
fi

if [ $# -gt 2 ]; then
    echo "ERROR: too much arguments"
    usage
    exit 1
fi

input_path="$1"
if [[ ! -d "${input_path}" ]]; then
    echo "ERROR: input file is invalid: ${input_path}"
    exit 1
fi

if [[ $# -eq 2 ]] ; then
    output_dir="$2"

    if [[ ! -d "${output_dir}" ]] ; then
	echo "ERROR: output directory is invalid: ${output_dir}"
	exit 1
    fi
else
    output_dir="$(dirname ${input_path})/output"
fi
mkdir -p -m777 "${output_dir}"
mkdir -p -m777 "${output_dir}/tmp"
mkdir -p -m777 "${output_dir}/FLAIR"
mkdir -p -m777 "${output_dir}/T1w"
mkdir -p -m777 "${output_dir}/T1w_2D"
mkdir -p -m777 "${output_dir}/other"

echo "Input directory = ${input_path}"
echo "Output directory = ${output_dir}"

prefix="nG_ARWIBO"

for tar_path in ${input_path}/*tar.bz2; do
    echo $(basename ${tar_path})
    id=$(echo $(basename ${tar_path}) | sed 's/^.*ARWIBO+\([0-9]*\).*$/\1/g')
    echo $id
    image_info=$(echo $(basename ${tar_path}) | sed 's/^.*ARWIBO+\([0-9]*\)+\([0-9]*\)+\([a-z0-9]*\)+\([0-9A-Z]*\)+\([0-9A-Z]*\).*$/\5/g')
    echo ${image_info}

    if [[ ${image_info} = "FLAIR" ]] || [[ ${image_info} = "T2FL" ]] || [[ ${image_info} = "T2FLV01" ]] || [[ ${image_info} = "T2FLV02" ]] ; then
        image_type="FLAIR"
    elif [[ ${image_info} = "MPR" ]] || [[ ${image_info} = "T13D" ]] || [[ ${image_info} = "T13DV01" ]] || [[ ${image_info} = "T13DV02" ]] || [[ ${image_info} = "T1TSE" ]] ; then
        image_type="T1w"
    elif [[ ${image_info} = "T12D" ]] || [[ ${image_info} = "T1G2D" ]] ; then
        image_type="T1w_2D"
    else
        image_type="other"
    fi
    echo ${image_type}

    tar -xf ${tar_path} -C ${output_dir}/tmp
    dcm2niix -x n -f ${prefix}_${id}_${image_type} -z y -o ${output_dir}/${image_type} ${output_dir}/tmp/
    rm -r ${output_dir}/tmp/*

    printf "\n\n"
done

rm -r ${output_dir}/tmp 
