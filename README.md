# Variant annotation tool

## Requirements
Must install snpEff software: http://pcingola.github.io/SnpEff/

## Steps to run

#### 1.	Update the variant.cfg file to input your species of interest and path to the snpEff and snpSift .jar files
#### 2.	Execute the variant.cfg script
#### 3.	Enter in the name of the variant file you want to analyze without including the .vcf extension. eg. for Challenge_data.vcf, input Challenge_data. It must be in the script directory
#### 4.	Results are in the /output/ folder:
-  ${sample}.final.tsv file: final annotated output
-  ${sample}.annotated.vcf file: annotated vcf file
-  ${sample}.stats.html and ${sample}.stats.genes.txt files: additional stats about the annotation
