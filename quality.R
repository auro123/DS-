> quality=read.csv("quality.csv")
> str(quality)
'data.frame':   131 obs. of  14 variables:
 $ MemberID            : int  1 2 3 4 5 6 7 8 9 10 ...
 $ InpatientDays       : int  0 1 0 0 8 2 16 2 2 4 ...
 $ ERVisits            : int  0 1 0 1 2 0 1 0 1 2 ...
 $ OfficeVisits        : int  18 6 5 19 19 9 8 8 4 0 ...
 $ Narcotics           : int  1 1 3 0 3 2 1 0 3 2 ...
 $ DaysSinceLastERVisit: num  731 411 731 158 449 ...
 $ Pain                : int  10 0 10 34 10 6 4 5 5 2 ...
 $ TotalVisits         : int  18 8 5 20 29 11 25 10 7 6 ...
 $ ProviderCount       : int  21 27 16 14 24 40 19 11 28 21 ...
 $ MedicalClaims       : int  93 19 27 59 51 53 40 28 20 17 ...
 $ ClaimLines          : int  222 115 148 242 204 156 261 87 98 66 ...
 $ StartedOnCombination: logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ AcuteDrugGapSmall   : int  0 1 5 0 0 4 0 0 0 0 ...
 $ PoorCare            : int  0 0 0 0 0 1 0 0 1 0 ...
> table(PoorCare)
Error in table(PoorCare) : object 'PoorCare' not found
> table(quality$PoorCare)

 0  1 
98 33 
> install.packages("caTools")
Installing package into ‘C:/Users/B N Pandey/Documents/R/win-library/3.3’
(as ‘lib’ is unspecified)
Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/src/contrib:
  Line starting '<html> ...' is malformed!
also installing the dependency ‘bitops’

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/bitops_1.0-6.zip'
Content type 'application/zip' length 36372 bytes (35 KB)
downloaded 35 KB

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/caTools_1.17.1.zip'
Content type 'application/zip' length 284179 bytes (277 KB)
downloaded 277 KB

package ‘bitops’ successfully unpacked and MD5 sums checked
package ‘caTools’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\B N Pandey\AppData\Local\Temp\Rtmpct3gDw\downloaded_packages
> libraray(caTools)
Error: could not find function "libraray"
> library(caTools)
> split=split.sample(quality$PoorCare,SplitRatio=0.75)
Error: could not find function "split.sample"
> split=sample.split(quality$PoorCare,SplitRatio=0.75)
> split
  [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE
 [15]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [29]  TRUE  TRUE FALSE  TRUE FALSE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [43]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
 [57] FALSE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [71] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE
 [85]  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
 [99]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE
[113] FALSE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
[127]  TRUE FALSE FALSE  TRUE  TRUE
> qualitytest=subset(quality,split==FALSE)
> qualitytrain=subset(quality,split==TRUE)
> qualitylog=glm(PoorCare~OfficeVisits+Narcotics,data=qualitytrain,family=binomial)
> summary(qualitylog)

Call:
glm(formula = PoorCare ~ OfficeVisits + Narcotics, family = binomial, 
    data = qualitytrain)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-1.89349  -0.65752  -0.54484  -0.09626   2.07368  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  -2.35266    0.48849  -4.816 1.46e-06 ***
OfficeVisits  0.06099    0.02714   2.248   0.0246 *  
Narcotics     0.07172    0.03153   2.275   0.0229 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 111.888  on 98  degrees of freedom
Residual deviance:  93.642  on 96  degrees of freedom
AIC: 99.642

Number of Fisher Scoring iterations: 4

> predicttrain(qualitylog,type="response")
Error: could not find function "predicttrain"
> predicttrain=predict(qualitylog,type="response")
> tapply(predicttrain,qualitytrain$PoorCare,mean)
        0         1 
0.2012473 0.4043081 
> qualitylog1=glm(PoorCare~StartedOnCombination+ProviderCount,data=qualitytrain,family=binomial)
> summary(qualitylog1)

Call:
glm(formula = PoorCare ~ StartedOnCombination + ProviderCount, 
    family = binomial, data = qualitytrain)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.9242  -0.6885  -0.5983  -0.1228   2.0072  

Coefficients:
                         Estimate Std. Error z value Pr(>|z|)    
(Intercept)              -2.14761    0.52112  -4.121 3.77e-05 ***
StartedOnCombinationTRUE  2.75739    1.14738   2.403   0.0163 *  
ProviderCount             0.03453    0.01746   1.978   0.0480 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 111.89  on 98  degrees of freedom
Residual deviance:  98.18  on 96  degrees of freedom
AIC: 104.18

Number of Fisher Scoring iterations: 4

> qualitylog1=glm(PoorCare~StartedOnCombination+ProviderCount,data=qualitytrain,family=binomial)
> summary(qualitylog1)

Call:
glm(formula = PoorCare ~ StartedOnCombination + ProviderCount, 
    family = binomial, data = qualitytrain)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.9242  -0.6885  -0.5983  -0.1228   2.0072  

Coefficients:
                         Estimate Std. Error z value Pr(>|z|)    
(Intercept)              -2.14761    0.52112  -4.121 3.77e-05 ***
StartedOnCombinationTRUE  2.75739    1.14738   2.403   0.0163 *  
ProviderCount             0.03453    0.01746   1.978   0.0480 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 111.89  on 98  degrees of freedom
Residual deviance:  98.18  on 96  degrees of freedom
AIC: 104.18

Number of Fisher Scoring iterations: 4

> qualitylog1=glm(PoorCare ~ StartedOnCombination + ProviderCount, data=qualitytrain, family=binomial)
> summary(qualitylog1)

Call:
glm(formula = PoorCare ~ StartedOnCombination + ProviderCount, 
    family = binomial, data = qualitytrain)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.9242  -0.6885  -0.5983  -0.1228   2.0072  

Coefficients:
                         Estimate Std. Error z value Pr(>|z|)    
(Intercept)              -2.14761    0.52112  -4.121 3.77e-05 ***
StartedOnCombinationTRUE  2.75739    1.14738   2.403   0.0163 *  
ProviderCount             0.03453    0.01746   1.978   0.0480 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 111.89  on 98  degrees of freedom
Residual deviance:  98.18  on 96  degrees of freedom
AIC: 104.18

Number of Fisher Scoring iterations: 4

> table(qualitytrain$PoorCare,predictTrain>0.5)
Error in table(qualitytrain$PoorCare, predictTrain > 0.5) : 
  object 'predictTrain' not found
> table(qualitytrain$PoorCare,predicttrain>0.5)
   
    FALSE TRUE
  0    71    3
  1    16    9
> table(qualitytrain$PoorCare,predicttrain>0.7)
   
    FALSE TRUE
  0    73    1
  1    21    4
> table(qualitytrain$PoorCare,predicttrain>0.2)
   
    FALSE TRUE
  0    50   24
  1    10   15
> install.package("ROCR")
Error: could not find function "install.package"
> install.packages("ROCR")
Installing package into ‘C:/Users/B N Pandey/Documents/R/win-library/3.3’
(as ‘lib’ is unspecified)
Warning: unable to access index for repository http://www.stats.ox.ac.uk/pub/RWin/src/contrib:
  Line starting '<html> ...' is malformed!
also installing the dependencies ‘gtools’, ‘gdata’, ‘gplots’

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/gtools_3.5.0.zip'
Content type 'application/zip' length 144200 bytes (140 KB)
downloaded 140 KB

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/gdata_2.17.0.zip'
Content type 'application/zip' length 1177954 bytes (1.1 MB)
downloaded 1.1 MB

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/gplots_3.0.1.zip'
Content type 'application/zip' length 511800 bytes (499 KB)
downloaded 499 KB

trying URL 'https://wbc.upm.edu.my/cran/bin/windows/contrib/3.3/ROCR_1.0-7.zip'
Content type 'application/zip' length 152152 bytes (148 KB)
downloaded 148 KB

package ‘gtools’ successfully unpacked and MD5 sums checked
package ‘gdata’ successfully unpacked and MD5 sums checked
package ‘gplots’ successfully unpacked and MD5 sums checked
package ‘ROCR’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\B N Pandey\AppData\Local\Temp\Rtmpct3gDw\downloaded_packages
> library(ROCR)
Loading required package: gplots

Attaching package: ‘gplots’

The following object is masked from ‘package:stats’:

    lowess

> rocrpred=prediction(predicttrain,qualitytrain$PoorCare)
> rocrperf=performance(rocrpred,"tpr","fpr")
> plot(rocrperf,colorize=TRUE,print.cutoff.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))
> 
> plot(rocrperf,colorize=TRUE)
> plot(rocrperf,colorize=TRUE,print.cutoff.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))
> plot(rocrperf,colorize=TRUE,print.cutoffs.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))

