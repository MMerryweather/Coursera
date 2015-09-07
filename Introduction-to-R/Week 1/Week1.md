---
title: "Coursera Week 1"
author: "Mathew Merryweather"
date: "8 July 2015"
output: html_document
---

# Notes
##Textual Data Formats
The functions `dput` and `dget` are the input/output tools for a single object. 


```r
x = data.frame(a = 1, b = "b")
dput(x,file = "data.R")
rm(x)
x = dget("data.R")
x
```

```
##   a b
## 1 1 b
```

The functions `dump` and `source` are identical except that they can be used with multiple objects. `dump` is fed a vector containing the names of the objects to be dumped.


```r
y = "foo"
dump(c("x","y"), file = "dump.R")
rm(x,y)
source("dump.R")
x
```

```
##   a b
## 1 1 b
```

```r
y
```

```
## [1] "foo"
```
***
## Interfaces and connections
Connections can be to many data sources. Not often used but give you far more control than just `read.table`. This is particularly useful for compressed files or if you are reading lines.


* files: `file`
* gzip files: `gzfile`
* bzip2 files: `bzfile`
* URLs: `url` 

When you interrogate the structure of an object using `str()` the `open` parameter has a code.

* `r` is read only
* `w` is writing
* `a` is appending
* `rb, wb, ab` as above but in binary moder

readlines is used to interrogate textual data.

```r
con = gzfile("words.gz")
x = readLines(con, 10)
```

`writeLines` is the analagouss output function

Readlines can also be used to open webpages and store HTML code.

***

## Subsetting Data

* `[` always returns an object of the same class as the parent
* `[[` extracts elements. Not necessarily a list or data frame
* `$` is used to extract named elements. May not be the same class

Example addressing data with numerical index

```r
x = c("a","b","c","d")
x[1]
```

```
## [1] "a"
```

```r
x[1:4]
```

```
## [1] "a" "b" "c" "d"
```

Example of using a logical index

```r
u = x > "a"
u
```

```
## [1] FALSE  TRUE  TRUE  TRUE
```

```r
x[u]
```

```
## [1] "b" "c" "d"
```

## subsetting lists

```r
x = list(foo =1:4, bar= 0.6)
#Returns a list, same as original, element called foo
x[1]
```

```
## $foo
## [1] 1 2 3 4
```

```r
#Returns just a sequence of values
x[[1]]
```

```
## [1] 1 2 3 4
```

```r
#Returns element associated with bar
x$bar
```

```
## [1] 0.6
```

```r
#Same as
x[["bar"]]
```

```
## [1] 0.6
```

```r
# different to
x["bar"]
```

```
## $bar
## [1] 0.6
```

If you want more than one object, use the `[` operator only.
`[[` can be used with *computed* indices which is a big help.


```r
x = list(foo = 1:4, bar = 0.6, baz = "hello")
name = "foo"
#Pass the variable 'name' into the double bracket operator
#which will evalue the right index and return that element
x[[name]]
```

```
## [1] 1 2 3 4
```

```r
#This however evaluates to a null becase the $ operator requires literal values
x$name
```

```
## NULL
```
