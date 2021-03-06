
library(readxl) #package needed to read excel file 
Health_Outcomes <- read_xlsx("datafinal2.xlsx")

library(ggplot2) #package needed for Figure 1, Figure 2, Figure 3 and Figure 4 
library(effects) #package needed for Figure 2 
library(ggfortify) #package needed for Figure 3 and Figure 4 

model3 <- lm(log(NCD_P) ~ log(PM_25) + log(eTech) + log(DomHE) + HDI + I(HDI^2) , data = Health_Outcomes) #my model 



## Table 1
### Data Summary

\begin{table}[ht]
\centering
\begin{tabular}{rccccc}
\hline
&    NCD\_P &     PM\_2.5 &   eTech &     DomHE &      HDI \\ 
\hline
Minimum &    16.00   & 5.894   & 5.00   &   4.226   & 0.3650   \\ 
1st Quartile & 32.00   & 13.865   & 28.25   &  69.046   & 0.5920   \\ 
Median &   47.00   & 21.429   & 85.00   & 358.991   & 0.7330   \\ 
Mean  &  45.28   & 26.931   & 64.04   & 974.904   & 0.7111   \\ 
3rd Quartile & 57.75   & 33.338   & 95.00   & 1228.226   & 0.8335   \\ 
Maximum &    76.00   & 98.055   & 95.00   & 8077.926   & 0.9510   \\ 
Std. Deviation &  15.27 & 18.747 & 35.82 & 1372.518 & 0.1518 \\
\hline
\end{tabular}
\end{table}


## Table 2
### Summary Statistics with Robust Standard Errors 

\begin{table}[ht]
\centering
\begin{tabular}{rcccc}
\hline
& Estimate & Std. Error & Pr($>$$|$t$|$) &  95\% CI [LB,UB] \\ 
\hline
(Intercept) &      2.5952 & 0.3397  & $1.727e^{-12}$* & 1.9246, 3.2658 \\
log(PM\_25) &       0.1362 & 0.0459   & 0.003479*       &  0.0455, 0.2269 \\
log(eTech) & -0.0781 & 0.0279  & 0.005751*       & -0.1333, -0.0230 \\
log(DomHE) &     0.0428  & 0.0305  & 0.1634          & -0.0175,  0.1030 \\
HDI &             4.4156  & 0.7897  & $9.232^{e-08}$* & 2.8567, 5.9745 \\
$HDI^2$ & -4.4588 & 0.5763 & $9.795^{e-13}$* & -5.5963, -3.3212 \\
\hline 
\hline \\[-1.8ex] 
\textit{Note:}  & $^{*}$p$<$0.05 & & \\  
\hline 
\end{tabular}
\end{table}


## Table 3
### Variance Inflation Factors

\begin{table}[h!]
\centering
\begin{tabular}{ c c c c c c } 
\hline
&  log(PM\_2.5) & log(eTech) &  log(DomHE) &  HDI & $HDI^2$ \\
\hline
&    1.665224  & 5.850765 & 11.859549 & 144.527084 & 128.516761 \\ 

\hline
\end{tabular}
\end{table}


## Figure 1
### Histogram of the Ratio of premature deaths due to NCDs as a proportion of all NCD deaths

hist1 <- ggplot(Health_Outcomes, 
                aes(x=NCD_P)) + geom_histogram(binwidth = 8, color="black", fill="limegreen")

# to add axis, we must first save the plot as a vector, "hist1", for example 
# "binwidth" indicates how many bins
# "color" and "fill" indicate the border bin color and the bin fill color, respectively. 

hist1 + labs(title ="Histogram of NCD_P", x = "NCD_P", y = "Frequency") + 
  
  theme(plot.title = element_text(lineheight=.8, face="bold"))

# "lineheight" and "face" indicates the size and weight, respectively, of the title, in this figure


## Figure 2
### Residuals vs Fitted Plot

RF1 <- autoplot(model3, which = 1, colour = 'black',  smooth.colour = 'limegreen',
                smooth.linetype = 'solid', ad.colour = 'blue' )

# to add axis, we must first save the plot as a vector, "RF1", for example 
# "colour" indicates the color of the plotted residuals
# "smooth.colour" indicates the color of the residuals trend line
# "smooth.linetype" indicates the pattern of the residuals trend line
# "ad.colour" indicates the color of the "0.0 horizontal line"

RF1 + labs(title ="Residuals vs Fitted Plot") + 
  
  theme(plot.title = element_text(lineheight=.8, face="bold"))

# "lineheight" and "face" indicates the size and weight, respectively, of the title, in this figure


## Figure 3
### "Health 'Kuznets' Curve

plot(effect("HDI", model3), colors = "limegreen", ylab = "Health Inequality", xlab= "Human Development Index", main = "Health 'Kuznets' Curve")


## Figure 4
### Q-Q plot

QQ1 <- autoplot(model3, which = 2, colour = 'limegreen', 
                ad.colour = 'blue')

# to add axis, we must first save the plot as a vector, "QQ1", for example 

# "colour" indicates the color of the plotted residuals; "ad.colour" indicates the color of the normal distribution line

QQ1 + labs(title ="Q-Q Plot of Regression Residuals", x = "Theoretical Quartiles", y = "Sample Quartiles") +
  
  theme(plot.title = element_text(lineheight=.8, face="bold"))

# "lineheight" and "face" indicates the size and weight, respectively, of the title, in this figure

