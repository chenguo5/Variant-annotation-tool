#!/bin/bash
#requires snpeff: http://pcingola.github.io/SnpEff/

#create the output folder
mkdir -p output

#read in the variant config file to pull the variables
source ./variant.cfg

#have the user enter in the input vcf sample name
read -p "Please enter in the sample name (all chars up to .vcf): " sample

#execute snpEff to annotate the variants using the genome information provided
java -Xmx8g -jar ${snpEff_path} -v -stats ${sample}.stats.html ${ref_genome_input} ${sample}.vcf > ${sample}.annotated.vcf

#execute snpSift to pull out relevant metrics for coordinates, coverage, variant count, frequency, and annotation
java -Xmx8g -jar ${snpSift_path} extractFields -s "," -e "." ${sample}.annotated.vcf CHROM POS REF ALT DP AO AF "ANN[0].EFFECT" > ${sample}.final.tsv

#relabel the headers
sed -i '1s/^.*/Chromosome\tPosition\tReference Allele\tVariant Allele\tCoverage\tVariant Count\tVariant Frequency\tAnnotation/' ${sample}.final.tsv

#since multiple annotations for each variant are sorted from most deleterious to least separated by "&", we can delete everything after the first "&" to produce the final file
sed -i -e 's/\&.*//' ${sample}.final.tsv

#move files to the output folder
mv ${sample}.annotated.vcf output
mv ${sample}.final.tsv output
mv ${sample}.stats.html output
mv ${sample}.stats.genes.txt output
