# script to create production cards for 2016 bstar from example card (bstar_tW_Left_M700)

masspoints=(900 1000 1100 1200 1300 1400 1500 1600 1700)
couplings=( "LH" "RH" )
base_dir="2017/13TeV"
template_dir="2017/13TeV/x53x53_tW_tPythia_narrow_M1000/"

# loop over all masspoints
for handedness in "${couplings[@]}"
do
    for mp in "${masspoints[@]}"
    do
	dir="${base_dir}/x53x53_tW_tPythia_narrow_${handedness}_M${mp}/"
	mkdir -p "$dir"
	cp "${template_dir}x53x53_tW_tPythia_narrow_M1000_extramodels.dat" "${dir}x53x53_tW_tPythia_narrow_${handedness}_M${mp}_extramodels.dat"
	cp "${template_dir}x53x53_tW_tPythia_narrow_M1000_proc_card.dat" "${dir}x53x53_tW_tPythia_narrow_${handedness}_M${mp}_proc_card.dat"
	sed -i "s/M1000/${handedness}_M${mp}/g" "${dir}x53x53_tW_tPythia_narrow_${handedness}_M${mp}_proc_card.dat"
	cp "${template_dir}x53x53_tW_tPythia_narrow_M1000_run_card.dat" "${dir}x53x53_tW_tPythia_narrow_${handedness}_M${mp}_run_card.dat"
#	cp "${template_dir}x53x53_tW_tPythia_narrow_M1000_madspin_card.dat" "${dir}x53x53_tW_tPythia_narrow_${handedness}_M${mp}_madspin_card.dat"
	root -l -b -q "writeCards.C(${mp},\"${handedness}\",\"${dir}\")"
    done
done
