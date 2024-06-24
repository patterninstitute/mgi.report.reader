
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mgi.report.reader

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mgi.report.reader)](https://CRAN.R-project.org/package=mgi.report.reader)
[![R-CMD-check](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`{mgi.report.reader}` provides a set of functions designed to facilitate
the reading, parsing, and analysis of [MGI (Mouse Genome
Informatics)](https://www.informatics.jax.org) [report
files](https://www.informatics.jax.org/downloads/reports/index.html).

## Installation

You can install the development version of `{mgi.report.reader}` like
so:

``` r
# install.packages("pak")
pak::pak("patterninstitute/mgi.report.reader")
```

## Example

``` r
library(mgi.report.reader)

base_url <- "https://www.informatics.jax.org/downloads/reports"

# Import the Mouse Genetic Markers (including withdrawn marker symbols) Report
read_report(file.path(base_url, "MRK_List1.rpt"), "MRK_List1", n_max = 10L)
#> # A tibble: 10 × 12
#>    marker_id   marker_symbol marker_name marker_type status cM_pos chr     start
#>    <chr>       <chr>         <chr>       <fct>       <fct>   <dbl> <fct>   <int>
#>  1 MGI:1341858 03B03F        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  2 MGI:1341869 03B03R        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  3 MGI:1337005 03.MMHAP34FR… DNA segmen… DNA Segment O        NA   11    NA     
#>  4 <NA>        0610005A07Rik withdrawn,… Gene        W        NA   3     NA     
#>  5 MGI:1918911 0610005C13Rik RIKEN cDNA… Gene        O        29.4 7      4.52e7
#>  6 <NA>        0610005K03Rik withdrawn,… Gene        W        NA   15    NA     
#>  7 <NA>        0610005M07Rik withdrawn,… Gene        W        NA   6     NA     
#>  8 <NA>        0610006A03Rik withdrawn,… Gene        W        NA   4     NA     
#>  9 <NA>        0610006A11Rik withdrawn,… Gene        W        NA   <NA>  NA     
#> 10 <NA>        0610006C01Rik withdrawn,… Gene        W        NA   <NA>  NA     
#> # ℹ 4 more variables: end <int>, strand <fct>, feature_type <fct>,
#> #   synonyms <list>
```

``` r
# Import Mouse Genetic Markers (excluding withdrawn marker symbols) Report
read_report(file.path(base_url, "MRK_List2.rpt"), "MRK_List2", n_max = 10L)
#> # A tibble: 10 × 12
#>    marker_id   marker_symbol marker_name marker_type status cM_pos chr     start
#>    <chr>       <chr>         <chr>       <fct>       <fct>   <dbl> <fct>   <int>
#>  1 MGI:1341858 03B03F        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  2 MGI:1341869 03B03R        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  3 MGI:1337005 03.MMHAP34FR… DNA segmen… DNA Segment O        NA   11    NA     
#>  4 MGI:1918911 0610005C13Rik RIKEN cDNA… Gene        O        29.4 7      4.52e7
#>  5 MGI:1923503 0610006L08Rik RIKEN cDNA… Gene        O        NA   7      7.45e7
#>  6 MGI:1925547 0610008J02Rik RIKEN cDNA… Gene        O        NA   <NA>  NA     
#>  7 MGI:3698435 0610009E02Rik RIKEN cDNA… Gene        O        18.9 2      2.63e7
#>  8 MGI:1918921 0610009F21Rik RIKEN cDNA… Gene        O        NA   16     9.17e7
#>  9 MGI:1918931 0610009K14Rik RIKEN cDNA… Gene        O        NA   4      1.36e7
#> 10 MGI:1914088 0610009L18Rik RIKEN cDNA… Gene        O        84.1 11     1.20e8
#> # ℹ 4 more variables: end <int>, strand <fct>, feature_type <fct>,
#> #   synonyms <list>
```

``` r
# Import the MGI Marker Coordinates' Report
read_report(file.path(base_url, "MGI_MRK_Coord.rpt"), "MGI_MRK_Coord", n_max = 10L)
#> # A tibble: 10 × 12
#>    marker_id marker_type marker_symbol marker_name  genome_assembly chr    start
#>    <chr>     <fct>       <chr>         <chr>        <fct>           <fct>  <int>
#>  1 MGI:87853 Gene        a             nonagouti    GRCm39          2     1.55e8
#>  2 MGI:87854 Gene        Pzp           PZP, alpha-… GRCm39          6     1.28e8
#>  3 MGI:87937 Gene        Adrb1         adrenergic … GRCm39          19    5.67e7
#>  4 MGI:87904 Gene        Actb          actin, beta  GRCm39          5     1.43e8
#>  5 MGI:87938 Gene        Adrb2         adrenergic … GRCm39          18    6.23e7
#>  6 MGI:87859 Gene        Abl1          c-abl oncog… GRCm39          2     3.16e7
#>  7 MGI:87939 Gene        Adrb3         adrenergic … GRCm39          8     2.77e7
#>  8 MGI:87862 Gene        Scgb1b27      secretoglob… GRCm39          7     3.37e7
#>  9 MGI:87940 Gene        Grk2          G protein-c… GRCm39          19    4.34e6
#> 10 MGI:87886 Gene        Chrna2        cholinergic… GRCm39          14    6.64e7
#> # ℹ 5 more variables: end <int>, strand <fct>, feature_type <fct>,
#> #   provider_collection <fct>, provider_display <fct>
```

``` r
# Import the MGI Sequence Coordinates (in GFF format)
read_report(file.path(base_url, "MGI_GTGUP.gff"), "MGI_GTGUP", n_max = 10L)
#> # A tibble: 10 × 9
#>    marker_id marker_symbol marker_type chr    start    end strand feature_source
#>    <chr>     <chr>         <fct>       <fct>  <int>  <int> <fct>  <fct>         
#>  1 MGI:6903… Rr15647       Other Geno… 1     3.05e6 3.05e6 <NA>   MGI           
#>  2 MGI:6914… Rr26566       Other Geno… 1     3.05e6 3.05e6 <NA>   MGI           
#>  3 MGI:6914… Rr26567       Other Geno… 1     3.05e6 3.05e6 <NA>   MGI           
#>  4 MGI:6903… Rr15649       Other Geno… 1     3.06e6 3.06e6 <NA>   MGI           
#>  5 MGI:6914… Rr26568       Other Geno… 1     3.06e6 3.06e6 <NA>   MGI           
#>  6 MGI:6914… Rr26571       Other Geno… 1     3.06e6 3.06e6 <NA>   MGI           
#>  7 MGI:6903… Rr15664       Other Geno… 1     3.08e6 3.08e6 <NA>   MGI           
#>  8 MGI:6914… Rr26579       Other Geno… 1     3.10e6 3.10e6 <NA>   MGI           
#>  9 MGI:6924… Rr36329       Other Geno… 1     3.12e6 3.12e6 <NA>   MGI           
#> 10 MGI:6924… Rr36333       Other Geno… 1     3.13e6 3.13e6 <NA>   MGI           
#> # ℹ 1 more variable: feature_type <fct>
```

``` r
# Import the MGI Marker associations to Sequence (GenBank, RefSeq,Ensembl) information
read_report(file.path(base_url, "MRK_Sequence.rpt"), "MRK_Sequence", n_max = 10L)
#> # A tibble: 10 × 19
#>    marker_id   marker_symbol marker_name marker_type status cM_pos chr     start
#>    <chr>       <chr>         <chr>       <fct>       <fct>   <dbl> <fct>   <int>
#>  1 MGI:1341858 03B03F        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  2 MGI:1341869 03B03R        DNA segmen… BAC/YAC end O        NA   5     NA     
#>  3 MGI:1918911 0610005C13Rik RIKEN cDNA… Gene        O        29.4 7      4.52e7
#>  4 MGI:1923503 0610006L08Rik RIKEN cDNA… Gene        O        NA   7      7.45e7
#>  5 MGI:1925547 0610008J02Rik RIKEN cDNA… Gene        O        NA   <NA>  NA     
#>  6 MGI:3698435 0610009E02Rik RIKEN cDNA… Gene        O        18.9 2      2.63e7
#>  7 MGI:1918921 0610009F21Rik RIKEN cDNA… Gene        O        NA   16     9.17e7
#>  8 MGI:1918931 0610009K14Rik RIKEN cDNA… Gene        O        NA   4      1.36e7
#>  9 MGI:1914088 0610009L18Rik RIKEN cDNA… Gene        O        84.1 11     1.20e8
#> 10 MGI:1915609 0610010K14Rik RIKEN cDNA… Gene        O        43.0 11     7.01e7
#> # ℹ 11 more variables: end <int>, strand <fct>, feature_type <fct>,
#> #   genbank_id <chr>, refseq_trp_id <chr>, ensembl_trp_id <chr>,
#> #   uniprot_id <chr>, tr_embl_id <chr>, ensembl_prt_id <chr>,
#> #   refseq_prt_id <chr>, unigene_id <chr>
```

## Disclaimer

The `{mgi.report.reader}` package is provided “as is” without any
guarantees or warranty. Although the authors have made every effort to
ensure the accuracy and reliability of the software and its
documentation, they are not responsible for any errors, omissions, or
misinterpretations. Users are advised to test the package thoroughly
before relying on it in critical applications. The authors disclaim all
liability for any damage or loss resulting from the use of this package.
Use of the `{mgi.report.reader}` package is at the user’s own risk.
