LIBRARY()

LICENSE(
    BSD3
)



NO_COMPILER_WARNINGS()

NO_LINT()

PEERDIR(
    contrib/libs/clapack
    contrib/python/numpy-1.11.1/numpy/core/src/multiarray
    contrib/python/numpy-1.11.1/numpy/core/src/umath
    contrib/python/numpy-1.11.1/numpy/fft
    contrib/python/numpy-1.11.1/numpy/linalg
    contrib/python/numpy-1.11.1/numpy/random/mtrand
)

ADDINCL(
    contrib/python/numpy-1.11.1/numpy/core
    GLOBAL contrib/python/numpy-1.11.1/numpy/core/include
    contrib/python/numpy-1.11.1/numpy/core/include/numpy
    contrib/python/numpy-1.11.1/numpy/core/src
    contrib/python/numpy-1.11.1/numpy/core/src/npymath
    contrib/python/numpy-1.11.1/numpy/core/src/npysort
    contrib/python/numpy-1.11.1/numpy/core/src/private
)

CFLAGS(
    -DHAVE_CBLAS
    -DHAVE_NPY_CONFIG_H=1
    -DNO_ATLAS_INFO=1
    -D_FILE_OFFSET_BITS=64
    -D_LARGEFILE64_SOURCE=1
    -D_LARGEFILE_SOURCE=1
)

PY_SRCS(
    TOP_LEVEL
    numpy/__config__.py
    numpy/__init__.py
    numpy/_import_tools.py
    numpy/add_newdocs.py
    numpy/compat/__init__.py
    numpy/compat/_inspect.py
    numpy/compat/py3k.py
    numpy/core/__init__.py
    numpy/core/_internal.py
    numpy/core/_methods.py
    numpy/core/arrayprint.py
    numpy/core/code_generators/generate_numpy_api.py
    numpy/core/cversions.py
    numpy/core/defchararray.py
    numpy/core/fromnumeric.py
    numpy/core/function_base.py
    numpy/core/getlimits.py
    numpy/core/info.py
    numpy/core/machar.py
    numpy/core/memmap.py
    numpy/core/numeric.py
    numpy/core/numerictypes.py
    numpy/core/records.py
    numpy/core/setup_common.py
    numpy/core/shape_base.py
    numpy/ctypeslib.py
    numpy/distutils/__config__.py
    numpy/distutils/__init__.py
    numpy/distutils/__version__.py
    numpy/distutils/ccompiler.py
    numpy/distutils/command/__init__.py
    numpy/distutils/command/autodist.py
    numpy/distutils/command/bdist_rpm.py
    numpy/distutils/command/build.py
    numpy/distutils/command/build_clib.py
    numpy/distutils/command/build_ext.py
    numpy/distutils/command/build_py.py
    numpy/distutils/command/build_scripts.py
    numpy/distutils/command/build_src.py
    numpy/distutils/command/config.py
    numpy/distutils/command/config_compiler.py
    numpy/distutils/command/develop.py
    numpy/distutils/command/egg_info.py
    numpy/distutils/command/install.py
    numpy/distutils/command/install_clib.py
    numpy/distutils/command/install_data.py
    numpy/distutils/command/install_headers.py
    numpy/distutils/command/sdist.py
    numpy/distutils/compat.py
    numpy/distutils/conv_template.py
    numpy/distutils/core.py
    numpy/distutils/cpuinfo.py
    numpy/distutils/environment.py
    numpy/distutils/exec_command.py
    numpy/distutils/extension.py
    numpy/distutils/fcompiler/__init__.py
    numpy/distutils/fcompiler/absoft.py
    numpy/distutils/fcompiler/compaq.py
    numpy/distutils/fcompiler/g95.py
    numpy/distutils/fcompiler/gnu.py
    numpy/distutils/fcompiler/hpux.py
    numpy/distutils/fcompiler/ibm.py
    numpy/distutils/fcompiler/intel.py
    numpy/distutils/fcompiler/lahey.py
    numpy/distutils/fcompiler/mips.py
    numpy/distutils/fcompiler/nag.py
    numpy/distutils/fcompiler/none.py
    numpy/distutils/fcompiler/pathf95.py
    numpy/distutils/fcompiler/pg.py
    numpy/distutils/fcompiler/sun.py
    numpy/distutils/fcompiler/vast.py
    numpy/distutils/from_template.py
    numpy/distutils/info.py
    numpy/distutils/intelccompiler.py
    numpy/distutils/lib2def.py
    numpy/distutils/line_endings.py
    numpy/distutils/log.py
    numpy/distutils/mingw32ccompiler.py
    numpy/distutils/misc_util.py
    numpy/distutils/msvc9compiler.py
    numpy/distutils/msvccompiler.py
    numpy/distutils/npy_pkg_config.py
    numpy/distutils/numpy_distribution.py
    numpy/distutils/pathccompiler.py
    numpy/distutils/system_info.py
    numpy/distutils/unixccompiler.py
    numpy/doc/__init__.py
    numpy/doc/basics.py
    numpy/doc/broadcasting.py
    numpy/doc/byteswapping.py
    numpy/doc/constants.py
    numpy/doc/creation.py
    numpy/doc/glossary.py
    numpy/doc/indexing.py
    numpy/doc/internals.py
    numpy/doc/misc.py
    numpy/doc/structured_arrays.py
    numpy/doc/subclassing.py
    numpy/doc/ufuncs.py
    numpy/dual.py
    numpy/lib/__init__.py
    numpy/lib/_datasource.py
    numpy/lib/_iotools.py
    numpy/lib/_version.py
    numpy/lib/arraypad.py
    numpy/lib/arraysetops.py
    numpy/lib/arrayterator.py
    numpy/lib/financial.py
    numpy/lib/format.py
    numpy/lib/function_base.py
    numpy/lib/index_tricks.py
    numpy/lib/info.py
    numpy/lib/nanfunctions.py
    numpy/lib/npyio.py
    numpy/lib/polynomial.py
    numpy/lib/recfunctions.py
    numpy/lib/scimath.py
    numpy/lib/shape_base.py
    numpy/lib/stride_tricks.py
    numpy/lib/twodim_base.py
    numpy/lib/type_check.py
    numpy/lib/ufunclike.py
    numpy/lib/user_array.py
    numpy/lib/utils.py
    numpy/ma/__init__.py
    numpy/ma/bench.py
    numpy/ma/core.py
    numpy/ma/extras.py
    numpy/ma/mrecords.py
    numpy/ma/testutils.py
    numpy/ma/timer_comparison.py
    numpy/ma/version.py
    numpy/matlib.py
    numpy/matrixlib/__init__.py
    numpy/matrixlib/defmatrix.py
    numpy/polynomial/__init__.py
    numpy/polynomial/_polybase.py
    numpy/polynomial/chebyshev.py
    numpy/polynomial/hermite.py
    numpy/polynomial/hermite_e.py
    numpy/polynomial/laguerre.py
    numpy/polynomial/legendre.py
    numpy/polynomial/polynomial.py
    numpy/polynomial/polyutils.py
    numpy/random/__init__.py
    numpy/random/info.py
    numpy/testing/__init__.py
    numpy/testing/decorators.py
    numpy/testing/noseclasses.py
    numpy/testing/nosetester.py
    numpy/testing/print_coercion_tables.py
    numpy/testing/utils.py
    numpy/version.py
)

SRCS(
    numpy/core/src/dummymodule.c
    numpy/core/src/npymath/halffloat.c
    numpy/core/src/npymath/ieee754.c
    numpy/core/src/npymath/npy_math.c
    numpy/core/src/npymath/npy_math_complex.c
    numpy/core/src/npysort/binsearch.c
    numpy/core/src/npysort/heapsort.c
    numpy/core/src/npysort/mergesort.c
    numpy/core/src/npysort/quicksort.c
    numpy/core/src/npysort/selection.c
    numpy/core/src/private/mem_overlap.c
    numpy/core/src/private/mem_overlap.c
)

END()
