R_MODULE(
    catboostr
    EXPORTS
    catboostr.exports
)



SRCS(
    catboostr.cpp
)

PEERDIR(
    catboost/libs/algo
)

IF (OS_WINDOWS)
    LDFLAGS($CURDIR/R.lib)  # TODO: use EXTRALIBS
ENDIF()

END()
