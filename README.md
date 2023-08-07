# corstars_ordinal
A correlation matrix with stars and the option to mix Pearson and Spearman correlations in R

`corstars` is an R function that computes a correlation matrix for a given dataset, supporting both Pearson and Spearman correlations. Specific indices can be used to denote different correlation methods.

## Usage

    corstars(x, ordinal_vars=NULL, removeTriangle=c("upper", "lower"),
             result=c("none", "html", "latex"), indecies=c(pearson="", spearman="(s)"))

### Parameters

- `x`: Your data matrix.
- `ordinal_vars`: Vector of column indices for ordinal variables that require Spearman correlation.
- `removeTriangle`: Specifies whether to remove the upper or lower triangle of the correlation matrix. Options include `"upper"` or `"lower"`.
- `result`: Specifies the output format. Options include `"none"`, `"html"`, and `"latex"`. `"none"` returns the result as a data frame, whereas `"html"` and `"latex"` print the result in the corresponding formats.
- `indecies`: Named list containing specific indices for Pearson and Spearman correlations, e.g. `c(pearson="", spearman="(s)")`.

## Example

Here's an example of how to use the function with a dataset that contains both continuous and ordinal variables:

```R
# Simulate some data
set.seed(123)
data <- data.frame(
  continuous_var1 = rnorm(100),
  continuous_var2 = rnorm(100),
  ordinal_var = sample(1:5, 100, replace = TRUE)
)

# Use the corstars function, specifying that the third column is ordinal
result <- corstars(data, ordinal_vars = 3, removeTriangle = "lower", result = "none")

# Print the result
print(result)
