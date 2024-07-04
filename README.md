
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mgi.report.reader

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mgi.report.reader)](https://CRAN.R-project.org/package=mgi.report.reader)
[![R-CMD-check](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Overview

The goal of `{mgi.report.reader}` is to facilitate the import of [Mouse
Genome Informatics
(MGI)](https://www.informatics.jax.org/downloads/reports/index.html)
report files into R.

## Installation

``` r
install.packages("mgi.report.reader")

# Or the development version from GitHub:
# install.packages("pak")
pak::pak("patterninstitute/mgi.report.reader")
```

## Supported MGI reports

The list of currently supported MGI reports by `{mgi.report.reader}` is
provided by the dataset `?reports`:

``` r
library(mgi.report.reader)

reports
#> # A tibble: 13 × 4
#>    report_key                 report_file              report_type   report_name
#>    <chr>                      <chr>                    <chr>         <chr>      
#>  1 marker_list1               MRK_List1.rpt            MRK_List1     Mouse Gene…
#>  2 marker_list2               MRK_List2.rpt            MRK_List2     Mouse Gene…
#>  3 marker_coordinates         MGI_MRK_Coord.rpt        MGI_MRK_Coord MGI Marker…
#>  4 gene_model_coordinates     MGI_Gene_Model_Coord.rpt MGI_Gene_Mod… MGI Gene M…
#>  5 sequence_coordinates       MGI_GTGUP.gff            MGI_GTGUP     MGI Sequen…
#>  6 genbank_refseq_ensembl_ids MRK_Sequence.rpt         MRK_Sequence  MGI Marker…
#>  7 swiss_trembl_ids           MRK_SwissProt_TrEMBL.rpt MRK_SwissPro… MGI Marker…
#>  8 swiss_prot_ids             MRK_SwissProt.rpt        MRK_SwissProt MGI Marker…
#>  9 gene_trap_ids              MRK_GeneTrap.rpt         MRK_GeneTrap  MGI Marker…
#> 10 ensembl_ids                MRK_ENSEMBL.rpt          MRK_ENSEMBL   MGI Marker…
#> 11 biotype_conflicts          MGI_BioTypeConflict.rpt  MGI_BioTypeC… MGI Marker…
#> 12 primers                    PRB_PrimerSeq.rpt        PRB_PrimerSeq MGI Marker…
#> 13 interpro_domains           MGI_InterProDomains.rpt  MGI_InterPro… InterPro d…
```

## Example

Use `read_report()` to read any supported MGI report into R, e.g. to
read `MRK_List1.rpt`:

``` r
(markers <- read_report("marker_list1", n_max = 10L))
#> # A tibble: 10 × 15
#>    marker_status marker_type marker_id   marker_symbol  marker_name feature_type
#>    <fct>         <fct>       <chr>       <chr>          <chr>       <fct>       
#>  1 O             BAC/YAC end MGI:1341858 03B03F         DNA segmen… BAC/YAC end 
#>  2 O             BAC/YAC end MGI:1341869 03B03R         DNA segmen… BAC/YAC end 
#>  3 O             DNA Segment MGI:1337005 03.MMHAP34FRA… DNA segmen… DNA segment 
#>  4 W             Gene        <NA>        0610005A07Rik  <NA>        <NA>        
#>  5 O             Gene        MGI:1918911 0610005C13Rik  RIKEN cDNA… lncRNA gene 
#>  6 W             Gene        <NA>        0610005K03Rik  <NA>        <NA>        
#>  7 W             Gene        <NA>        0610005M07Rik  <NA>        <NA>        
#>  8 W             Gene        <NA>        0610006A03Rik  <NA>        <NA>        
#>  9 W             Gene        <NA>        0610006A11Rik  <NA>        <NA>        
#> 10 W             Gene        <NA>        0610006C01Rik  <NA>        <NA>        
#> # ℹ 9 more variables: chromosome <fct>, start <int>, end <int>, strand <fct>,
#> #   genetic_map_pos <dbl>, synonyms <list>, marker_id_now <chr>,
#> #   marker_symbol_now <chr>, note <chr>
```

``` r
# Report file source
report_source(markers)
#> [1] "https://www.informatics.jax.org/downloads/reports/MRK_List1.rpt"
```

``` r
# Report file last modification date
report_last_modified(markers)
#> [1] "2024-07-01 11:51:02 GMT"
```

## Code of Conduct

Please note that the `{mgi.report.reader}` project is released with a
[Contributor Code of
Conduct](https://www.pattern.institute/mgi.report.reader/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Disclaimer

The `{mgi.report.reader}` package is provided “as is” without any
guarantees or warranty. Although the authors have made every effort to
ensure the accuracy and reliability of the software and its
documentation, they are not responsible for any errors, omissions, or
misinterpretations. Users are advised to test the package thoroughly
before relying on it in critical applications. The authors disclaim all
liability for any damage or loss resulting from the use of this package.
Use of the `{mgi.report.reader}` package is at the user’s own risk.

Support for reports is an ongoing process, but we welcome pull requests
for quicker coverage.

## Citing this package

- Firstly, if you use this package please do not forget to start by
  citing the Mouse Genome Informatics (MGI) and Jackson Laboratory (JAX)
  as they are the original providers of the data here made accessible
  with these readers. For details on how to cite MGI resources, please
  refer to:
  <https://www.informatics.jax.org/mgihome/other/citation.shtml>.

- To cite us, see
  <https://www.pattern.institute/mgi.report.reader/authors.html#citation>.
