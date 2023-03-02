  refdir = refdir  # directory where reference (Complete) files are located
  workdir = workdir # directory where contigs/reads files are located and output is stored

reference = 1  # 0:pick a random reference from refdir; 1:use given reference; 2: use ANI based reference
  reffile = Kp.fasta  # reference filename when option 1 is chosen

  project = Kp  # main alignment file name

  cdsSNPS = 0  # 0:no cds SNPS; 1:cds SNPs, divides SNPs into coding and non-coding sequences, gff file is required

  buildSNPdb = 0 # 0: only align to reference 1: build SNP database of all complete genomes from refdir

FirstTime = 1  # 1:yes; 2:update existing SNP alignment, only works when buildSNPdb is used first time to build DB

         data = 3  # *See below 0:only complete(F); 1:only contig(C); 2:only reads(R);
                           # 3:combination F+C; 4:combination F+R; 5:combination C+R;
                           # 6:combination F+C+R; 7:realignment  *See below
        reads = 2  # 1: single reads; 2: paired reads; 3: both types present;

         tree = 1  # 0:no tree; 1:use FastTree; 2:use RAxML; 3:use both;
bootstrap = 0  # 0:no; 1:yes;  # Run bootstrapping  *See below
                N = 100  # Number of bootstraps to run *See below

PosSelect = 0  # 0:No; 1:use PAML; 2:use HyPhy; 3:use both # these analysis need gff file to parse genomes to genes

         code = 0  # 0:Bacteria; 1:Virus; 2: Eukarya # Bacteria and Virus sets ploidy to haploid

        clean = 1  # 0:no clean; 1:clean # remove intermediate and temp files after analysis is complete

  threads = 20  # Number of threads to use

   cutoff = 0.1  # Linear alignment (LA) coverage against reference - ignores SNPs from organism that have lower cutoff.
