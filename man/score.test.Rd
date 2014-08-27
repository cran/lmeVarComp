\name{score.test}
\alias{score.test}
\title{
Linear Score Test for Zero Variance Components
}
\description{
\code{score.test} tests whether certain variance components are zeros
using linear score test. 
This function is a wrapper of the \code{varComp.test} function 
in the \code{varComp} package.
}
\usage{
score.test(Y, X, Z, Sigma, m0)
}
\arguments{
  \item{Y}{
  response vector of length \code{n}
  }
  \item{X}{
  fixed effects design matrix of dimension \code{n} by \code{p}
  }
  \item{Z}{
  a list of random effects design matrices. 
  Each matrix should have \code{n} rows.
  }
  \item{Sigma}{
  a list of random effects correlation structures.
  Each matrix should be symmetric and positive definite, and match
  the dimension of the corresponding random effects design matrix.
  }
  \item{m0}{
  an integer indicating the number of nuisance variance components.
  Should be between \code{0} and \code{length(Z) - 1}.
  The first \code{m0} variance components will be treated as nuisance.
  }
}
\details{
To be added.
}
\value{
A vector of the test statistic and the p-value of 
linear score test.
}
\references{
Qu, L., Guennel, T., and Marshall, S. L. (2013).
Linear score tests for variance components in linear mixed models and
  applications to genetic association studies.
\emph{Biometrics}, 69(4):883--892.
}
\author{
Yichi Zhang
}
\seealso{
\code{\link{rlr.test}}, \code{\link{pseudo.rlr.test}}
}
\examples{
# two-way random effects ANOVA
n1 <- 5L
n2 <- 6L
n0 <- 4L
n <- n1 * n2 * n0
X <- cbind(rep(1, n))
A <- gl(n1, n2 * n0)
Z1 <- model.matrix(~ -1 + A, contrasts.arg = contr.treatment)
B <- rep(gl(n2, n0), n1)
Z2 <- model.matrix(~ -1 + B, contrasts.arg = contr.treatment)
Z3 <- model.matrix(~ -1 + B : A, contrasts.arg = contr.treatment)
set.seed(1L)
Y <- (X \%*\% 1
  + Z1 \%*\% rnorm(ncol(Z1), 0, 0.7)
  + Z2 \%*\% rnorm(ncol(Z2), 0, 0.3)
  + Z3 \%*\% rnorm(ncol(Z3), 0, 0.5)
  + rnorm(n, 0, 1))
Z <- list(Z1, Z2, Z3)
Sigma <- lapply(Z, function(z) diag(ncol(z)))
# tests interaction effects
score.test(Y, X, Z, Sigma, 2L)
# tests overall effects
score.test(Y, X, Z, Sigma, 1L)
}
