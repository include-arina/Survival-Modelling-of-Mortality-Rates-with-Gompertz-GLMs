# Survival-Modelling-of-Mortality-Rates-with-Gompertz-GLMs
This project analyses age-specific mortality rates across ages 25–80 using R and Gompertz-based generalised linear models with binomial errors and a logit link. Observed crude death rates are plotted on the logit scale to examine the relationship between age and mortality, before fitting a linear age predictor weighted by population exposures.

Model suitability is assessed by comparing observed and fitted rates and examining Pearson residuals. Although the fitted line broadly follows the mortality pattern, systematic structure in the residuals indicates that the linear specification does not fully capture the age-related variation.

A second model introduces centred age and a quadratic term to allow curvature in the fitted relationship. The models are compared visually and using the Akaike Information Criterion (AIC), calculated from their maximised log-likelihoods and parameter counts. The quadratic specification achieves a lower AIC—620.98 compared with 634.54—supporting its selection over the linear model while accounting for the additional complexity.

## Project Report
[View full report](Survival_Models-Project.pdf)

## License
This project is provided for viewing and evaluation purposes only.
Reuse, modification, or distribution is not permitted without explicit permission.
