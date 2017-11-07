* Encoding: UTF-8.
* ============================================.
* N736 - LESSON 20
* Poisson Regression and Negative Binomial Regression
*
* Melinda Higgins, PhD
* dated 11/5/2017
*
* working with the helpmkh dataset
* ============================================.

* ============================================.
* look at distribution of d1
* number of times hospitalized for medical problems
* this is a good count variable
* check mean and standard deviation
* SD > mean indicates overdispersion
* ============================================.

FREQUENCIES VARIABLES=d1
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* ============================================.
* look at correlations of d1 with demographics
* and other predictors - we'll focus on pcs
* ============================================.

CORRELATIONS
  /VARIABLES=d1 age female pss_fr pcs mcs indtot sexrisk
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=d1 age female pss_fr pcs mcs indtot sexrisk
  /PRINT=BOTH TWOTAIL NOSIG
  /MISSING=PAIRWISE.

* ============================================.
* run Poisson regression - intercept only model
* this is the NULL model - no predictors
* ============================================.

* Generalized Linear Models.
GENLIN d1
  /MODEL INTERCEPT=YES
 DISTRIBUTION=POISSON LINK=LOG
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION (EXPONENTIATED).

* ============================================.
* Poisson Regression - pcs as predictor for d1
* ============================================.

* Generalized Linear Models.
GENLIN d1 WITH pcs
  /MODEL pcs INTERCEPT=YES
 DISTRIBUTION=POISSON LINK=LOG
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION (EXPONENTIATED).

* ============================================.
* Negative Binomial Regression - pcs as predictor for d1
* compare goodness of fit stats
* ============================================.

* Generalized Linear Models.
GENLIN d1 WITH pcs
  /MODEL pcs INTERCEPT=YES
 DISTRIBUTION=NEGBIN(MLE) LINK=LOG
  /CRITERIA METHOD=FISHER(1) SCALE=1 COVB=MODEL MAXITERATIONS=100 MAXSTEPHALVING=5 
    PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 CITYPE=WALD 
    LIKELIHOOD=FULL
  /MISSING CLASSMISSING=EXCLUDE
  /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION (EXPONENTIATED).
