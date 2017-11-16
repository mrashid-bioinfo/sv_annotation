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
	
	perl variant_effect_predictor.pl --port 3337 --per_gene --hgvs --db_version 79 --database --species human --assembly GRCh37 --force_overwrite --sift b --input_file YOUR_INPUT_VCF.vcf --format vcf --output_file OUTPUT_VCF.VEP.vcf --vcf --stats_file OUTPUT.html

	bgzip YOUR_INPUT_VCF.vcf
	tabix YOUR_INPUT_VCF.vcf.gz


## ---- ##
##	2. Extract a tab delimited file from VEP annotated VCF

	bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%INFO/SVTYPE\t%INFO/SVLEN\t%INFO/END\t%INFO/STRANDS\t%INFO/CSQ\t%INFO/IMPRECISE\t%INFO/CIPOS\t%INFO/CIEND\t%INFO/CIPOS95\t%INFO/CIEND95\t%INFO/MATEID\t%INFO/EVENT\t%INFO/SU\t%INFO/PE\t%INFO/EV[\t%SAMPLE=%GT]\n' YOUR_INPUT_VCF.vcf.gz > YOUR_INPUT_VCF.VEP.txt

	# Convert the txt file to 0 - co-ordinate based bed file
	#
	# i.e.   1  SV_start_location SV_end_location GENE Sample  becomes



## ---- ##
##	3. Annotate the tab delimited file [ bed file ] using bedtools
##		
##		I created this combined annotation file that includes 
##	
##		Transciption Fractor Binding Sites
##		Histone Modification
##		DNA footprint ( e.g. DNase-Seq, FAIRE-Seq )
##		Promoter
##		DNA segmentation defined by the SegWay algorithm
##		and few more fetures. 
##
##		Example of lines
##		Chromosome   Region_Start Region_End 	Centre/Source	 Platform/		type     Cellline  CelllType	Merged_ID		
##																Category				   Name   
##			1       	10200   	10309   	ENSEMBL_Seg       WE      		WE        helas3 	 NA        WE_WE_helas3_NA
##			1       	10149   	10260   	Haib    		  Tfbs    	  ZBTB33  	  HepG2   	liver     Tfbs_ZBTB33_HepG2_liver	
##
##
##		I uploaded the file here : https://www.dropbox.com/s/thrndvberhrdo8d/All_Anno.Merged_Info.bed.gz?dl=0
##

		bedtools intersect -wao -a YOUR_INPUT_VCF.VEP.bed -b All_Anno.Merged_Info.bed > YOUR_INPUT.Annotated.bed
		
