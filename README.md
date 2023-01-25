# COBSCCOMP202P-001

Please change SWIFT_COMPILATION_MODE to wholemodule and SWIFT_OPTIMIZATION_LEVEL (both debug and release) to -O in Build Settings of Pods. Otherwise it gives an error when building (I found this solution on stackoverflow website).
