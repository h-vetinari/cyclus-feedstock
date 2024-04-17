#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  # other
  libext=".dylib"
  export LDFLAGS="-rpath ${PREFIX}/lib ${LDFLAGS}"
  export LINKFLAGS="${LDFLAGS}"
  skiprpath="-DCMAKE_SKIP_RPATH=TRUE"
else
  libext=".so"
  skiprpath=""
fi

# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py --prefix="${PREFIX}" \
  --build_type="Release" \
  --allow-milps \
  ${skiprpath} \
  -DCMAKE_C_COMPILER=${GCC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  --clean-build -j "${CPU_COUNT}"
