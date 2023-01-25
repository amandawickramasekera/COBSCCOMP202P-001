# COBSCCOMP202P-001

Please change values for SWIFT_COMPILATION_MODE to wholemodule and value for SWIFT_OPTIMIZATION_LEVEL (for both debug and release) to -O in Build Settings of Pods. Otherwise it gives an error when building (I found this solution on stackoverflow website).
