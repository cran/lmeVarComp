\name{pseudo.rlr.test}
\alias{pseudo.rlr.test}
\title{
Pseudo Restricted Likelihood Ratio Test for Zero Variance Components
}
\description{
\code{pseudo.rlr.test} tests whether certain variance components are zeros
using pseudo restricted likelihood ratio test,
assuming the variance components of interest are equal.
This function is a wrapper of the \code{RLRTSim} function 
in the \code{RLRsim} package.
}
\usage{
pseudo.rlr.test(Y, X, Z, Sigma, m0, nsim = 5000L, seed = 130623L)
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
  \item{nsim}{
  number of simulations from the null distribution. 
  If zero, REML estimates are computed but tests are not performed.
  }
  \item{seed}{
  a seed to be set before simulating from the null distribution.
  }
}
\value{
A vector of the test statistic and the p-value of 
pseudo restricted likelihood ratio test.
}
\references{
Greven, S., Crainiceanu, C. M., Kuchenhoff, H., and Peters, A. (2008).
Restricted likelihood ratio testing for zero variance components in
  linear mixed models.
\emph{Journal of Computational and Graphical Statistics}, 17(4):870--891.
}
\author{
Yichi Zhang
}
\seealso{
\code{\link{rlr.test}}, \code{\link{score.test}}
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
pseudo.rlr.test(Y, X, Z, Sigma, 2L, 2000L, 2L)
# tests overall effects
pseudo.rlr.test(Y, X, Z, Sigma, 1L, 2000L, 3L)
}
