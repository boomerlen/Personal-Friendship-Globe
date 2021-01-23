#!/bin/sh
#
# Deletes all Files of the ASEM-51 Package
# ========================================
#
# Attention:  Be sure to uninstall ASEM-51 under the same user-id
# ----------  you previously used for installation with install.sh!

VERSION=1.3

echo ""
if [ `id -u` -eq 0 ]
then
  PREFIX=/usr/local
  ASEM=$PREFIX/share/asem-51/$VERSION
  SBIN=/usr/sbin
  echo "Trying to uninstall ASEM-51 V$VERSION for the whole system ..."
else
  PREFIX=$HOME
  ASEM=$PREFIX/asem-51/$VERSION
  echo "Trying to uninstall ASEM-51 V$VERSION in your home directory ..."
fi

BIN=$PREFIX/bin
MAN=$PREFIX/man
MAN1=$MAN/man1

if [ ! -e $ASEM/asem ]
then
  echo "file $ASEM/asem not found"
  exit 1
fi

echo ""
echo "Deleting all ASEM-51 files in $ASEM ..."
rm -rf $ASEM || exit $?

echo "Deleting symbolic links to executables in $BIN ..."
rm -f $BIN/asem $BIN/hexbin $BIN/customiz $BIN/reset51 || exit $?
rm -f $BIN/boot $BIN/upload $BIN/upload.new $BIN/uninst51.sh || exit $?

if [ `id -u` -eq 0 ]
then
echo "Deleting symbolic links to executables in $SBIN ..."
rm -f $SBIN/uninst51.sh || exit $?
fi

echo "Deleting symbolic links to man-pages in $MAN1 ..."
rm -f $MAN1/asem.1 $MAN1/hexbin.1 || exit $?
rm -f $MAN1/customiz.1 $MAN1/reset51.1 $MAN1/boot.1 || exit $?

echo ""
echo "Done."
echo "ASEM-51 V$VERSION is uninstalled."
echo ""
