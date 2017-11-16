# sv_annotation : Annotate Structural variants using VEP and bedtools

## ===================================================================== ##
##
## 						Annotate Structural Variants 
##
##	1. Annotate Variant using Variant Effect Predictor ( VEP )
##	2. Extract a tab delimited file from VEP annotated VCF
##	3. Annotate the tab delimited file [ bed file ] using bedtools
##


## ---- ##
##	1. Annotate Structural Variants using Variant Effect Predictor ( VEP )
##
## 	Assumptions 
##
##		1.1 you have a VCF from you SV caller. I used lumpy and it produces a VCF output
##		    ** In case you do not have a VCF file, please have look at the supported input file format
##			in VEP documentation .
##
##			>> change : --format vcf 
##
##			https://www.ensembl.org/info/docs/tools/vep/vep_formats.html
##		1.2 Human assembly version : GRCh37 . If you are using GRCh38 please 
##
##			>> remove  : --port 3337	
##			>> change  : --assembly GRCh37 to   --assembly GRCh38
##
##
