
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

To read an MGI report into R use `read_report()`:

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
