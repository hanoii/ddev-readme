setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-readme
  mkdir -p $TESTDIR
  export PROJNAME=test-readme
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  echo -e "# ddev-readme test\n\n"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

health_checks() {
  # Do something useful here that verifies the add-on
  echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam viverra magna et ipsum rhoncus mollis eu et nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Phasellus cursus sit amet augue facilisis eleifend. Aenean commodo lacus et nulla sodales, eu dictum arcu ullamcorper. In non mollis nulla. Nunc vitae massa luctus nisl varius commodo eget quis elit. Suspendisse vestibulum, ligula sed venenatis molestie, leo mi rutrum ligula, eget pharetra dui magna vitae risus. Morbi vulputate sem at imperdiet sagittis." > ${TESTDIR}/README.md
  local _readme_lines_before=$(cat ${TESTDIR}/README.md | wc -l)
  # Just giving time for the watch project to edit README
  sleep 2
  local _readme_lines_after=$(cat ${TESTDIR}/README.md | wc -l)
  # If all good, lines after should be different (more).
  [[ "$_readme_lines_before" != "$_readme_lines_after" ]]
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  health_checks
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get hanoii/ddev-readme with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get hanoii/ddev-readme
  ddev restart >/dev/null
  health_checks
}

