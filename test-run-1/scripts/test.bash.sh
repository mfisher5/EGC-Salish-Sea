echo "The scripts works"
# usage bash test.bash.sh {folder}
MAIN_DIR="$(dirname "$0")"
pwd
#mkdir "${OUTPUT_DIR}"
cat ${1}
#Capture one value of the params file
FASTQFOLDER=($(awk -F',' -v COLNUM=1 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
echo "This is the location of file 1"
echo  "${FASTQFOLDER}"

METADATA=($(awk -F',' -v COLNUM=2 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
echo "This is the metadata"
echo  "${METADATA}"

OUTPUTFOLDER=($(awk -F',' -v COLNUM=3 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
if [ -d "${OUTPUTFOLDER}" ]; then
	echo "This is the output folder"
	echo  "'${OUTPUTFOLDER}'"
else
	echo "making output folder"
	mkdir "'${OUTPUTFOLDER}'"
fi

MINLENGTH=($(awk -F',' -v COLNUM=4 \
  'NR>1 {  print $COLNUM }' ${1} \ 
  ))
echo "Using the minimum length"
echo  "${MINLENGTH}"
  