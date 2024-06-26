
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mgi.report.reader

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/mgi.report.reader)](https://CRAN.R-project.org/package=mgi.report.reader)
[![R-CMD-check](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/patterninstitute/mgi.report.reader/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`{mgi.report.reader}` provides readers for easy and consistent importing
of Mouse Genome Informatics (MGI) report files:
<https://www.informatics.jax.org/downloads/reports/index.html>.

Essentially, what this package provides is a single function
`read_report()` to import MGI reports. We try to use a consistent naming
scheme for variables across reports, use appropriate variable types,
e.g. factors for variables with small enumerations, convert disparate
missing values to `NA`, and other time-consuming tidying steps, so that
you don’t have to.

## Installation

``` r
install.packages("mgi.report.reader")
```

## Example

To read an MGI report into R use `read_report()`:

``` r
library(mgi.report.reader)

base_url <- "https://www.informatics.jax.org/downloads/reports"
marker_list1_rpt <- file.path(base_url, "MRK_List1.rpt")
coordinates_rpt <- file.path(base_url, "MGI_MRK_Coord.rpt")

# Import the Mouse Genetic Markers (including withdrawn marker symbols) Report
read_report(marker_list1_rpt, "MRK_List1", n_max = 10L)
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
read_report(coordinates_rpt, "MGI_MRK_Coord", n_max = 10L)
#> # A tibble: 10 × 12
#>    marker_id marker_type marker_symbol marker_name  genome_assembly chr    start
#>    <chr>     <fct>       <chr>         <chr>        <fct>           <fct>  <int>
#>  1 MGI:87853 Gene        a             nonagouti    GRCm39          2     1.55e8
#>  2 MGI:87854 Gene        Pzp           PZP, alpha-… GRCm39          6     1.28e8
#>  3 MGI:87881 Gene        Acp1          acid phosph… GRCm39          12    3.09e7
#>  4 MGI:87926 Gene        Adh7          alcohol deh… GRCm39          3     1.38e8
#>  5 MGI:87929 Gene        Adh5          alcohol deh… GRCm39          3     1.38e8
#>  6 MGI:87859 Gene        Abl1          c-abl oncog… GRCm39          2     3.16e7
#>  7 MGI:87882 Gene        Acp2          acid phosph… GRCm39          2     9.10e7
#>  8 MGI:87862 Gene        Scgb1b27      secretoglob… GRCm39          7     3.37e7
#>  9 MGI:87883 Gene        Acp5          acid phosph… GRCm39          9     2.20e7
#> 10 MGI:87930 Gene        Adk           adenosine k… GRCm39          14    2.11e7
#> # ℹ 5 more variables: end <int>, strand <fct>, feature_type <fct>,
#> #   provider <fct>, provider_display <fct>
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

## Citing this package

- Firstly, if you use this package please do not forget to start by
  citing the Mouse Genome Informatics (MGI) and Jackson Laboratory (JAX)
  as they are the original providers of the data here made accessible
  with these readers. For details on how to cite MGI resources, please
  refer to:
  <https://www.informatics.jax.org/mgihome/other/citation.shtml>.

- To cite us, see
  <https://www.pattern.institute/mgi.report.reader/authors.html#citation>.
