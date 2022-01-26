
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Reformating the function `total_price()`

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the development version of terribleCode from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("svalvaro/terribleCode")
```

## Example

``` r
library(terribleCode)
## basic example code

df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    price_USD = c(249,591,319,198,125)
    )

# 20 % discount for EUR
total_price(df, currency = 'EUR')
#> [1] 1036.8
```

``` r
(217+517+279+173+110)*0.8
#> [1] 1036.8
```

# Improvements

## Missing values

``` r
df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,NA,' ',173,110),
    price_USD = c(249,591,319,198,125)
    )

total_price(df, currency = 'EUR') # 20% discount
#> [1] 400
```

``` r
(217+173+110)*0.8
#> [1] 400
```

## Prices wrongly read as strings

``` r
df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    price_USD = c(249,'591','unknown','NA',125)
    )

total_price(df, currency = 'USD') # 25% discount
#> [1] 723.75
```

``` r
(249+591+125)*0.75
#> [1] 723.75
```

## Other currencies (No discount specified)

``` r
df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    price_USD = c(249,591,319,198,125),
    price_CZK = c(6122, 14530, 7843, 4868, 3073)
    )


total_price(df, currency = 'CZK')
#> [1] 36436
```

``` r
(6122+14530+7843+4688+3073)
#> [1] 36256
```

## Able to recognise different column names

``` r
df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    price_USD = c(249,591,319,198,125)
    )

df2 <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    USD_price = c(249,591,319,198,125)
    )

total_price(df, currency = 'USD') == total_price(df2, currency = 'USD')
#> [1] TRUE
```

## Error check if currency not found

``` r
df <- data.frame(
    product = c('smartwatch', 'laptop', 'monitor', 'headphones', 'printer'),
    price_EUR = c(217,517,279,173,110),
    price_USD = c(249,591,319,198,125)
    )

total_price(df, currency = 'CZK')
#> Error in total_price(df, currency = "CZK"): The prices for the provided currency were not found.
```

## Error if the input provided is not a data frame

``` r
vector <- c(217,517,279,173,110)
total_price(vector, currency = 'CZK')
#> Error in total_price(vector, currency = "CZK"): Data provided is not a data.frame
```

# Tests

A total of six different tests have been created for this function. They
are in the folder `/tests/testthat/`.
