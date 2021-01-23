#!/bin/sh
#
# Installation of ASEM-51 under Linux
# ===================================

VERSION=1.3

echo ""
if [ `id -u` -eq 0 ]
then
  PREFIX=/usr/local
  ASEM=$PREFIX/share/asem-51/$VERSION
  SBIN=/usr/sbin
  echo "Trying to install ASEM-51 V$VERSION for the whole system ..."
else
  PREFIX=$HOME
  ASEM=$PREFIX/asem-51/$VERSION
  echo "Note: Installation should better be done as root!"
  echo "Trying to install ASEM-51 V$VERSION in your home directory ..."
fi

BIN=$PREFIX/bin
MAN=$PREFIX/man
MAN1=$MAN/man1
MCU=$ASEM/mcu
DOC=$ASEM/html

if [ ! -e ./asem ]
then
  echo "file ./asem not found"
  exit 1
fi

if [ ! -e ./mcu/8051.mcu ]
then
  echo "file ./mcu/8051.mcu not found"
  exit 1
fi

if [ ! -e ./html/docs.htm ]
then
  echo "file ./html/docs.htm not found"
  exit 1
fi

echo "Installing ASEM-51 in $ASEM ..."

mkdirhier $ASEM || exit $?
mkdirhier $BIN || exit $?
mkdirhier $MAN1 || exit $?

cp -Rp ./* $ASEM || exit $?

chmod -R a+r,u+w,og-w $ASEM/* || exit $?
chmod a+x $ASEM/asem $ASEM/hexbin $ASEM/customiz $ASEM/reset51 || exit $?
chmod a+x $ASEM/boot $ASEM/upload $ASEM/upload.new || exit $?
chmod og-x,u+x $ASEM/install.sh $ASEM/uninst51.sh || exit $?

if [ `id -u` -eq 0 ]
then
  chown -R root $ASEM/* || exit $?
  chgrp -R root $ASEM/* || exit $?
  chmod a+x,u+s $ASEM/reset51 || exit $?
else
  echo "Warning: reset51 has no direct access to I/O ports!"
fi

rm -f $BIN/asem $BIN/hexbin $BIN/customiz $BIN/reset51 || exit $?
rm -f $BIN/boot $BIN/upload $BIN/upload.new $BIN/uninst51.sh || exit $?
rm -f $MAN1/asem.1 $MAN1/hexbin.1 || exit $?
rm -f $MAN1/customiz.1 $MAN1/reset51.1 $MAN1/boot.1 || exit $?

if [ `id -u` -eq 0 ]
then
rm -f $SBIN/uninst51.sh || exit $?
ln -s $ASEM/uninst51.sh $SBIN/uninst51.sh || exit $?
fi

ln -s $ASEM/asem $BIN/asem || exit $?
ln -s $ASEM/hexbin $BIN/hexbin || exit $?
ln -s $ASEM/customiz $BIN/customiz || exit $?
ln -s $ASEM/reset51 $BIN/reset51 || exit $?
ln -s $ASEM/boot $BIN/boot || exit $?
ln -s $ASEM/upload $BIN/upload || exit $?
ln -s $ASEM/upload.new $BIN/upload.new || exit $?
ln -s $ASEM/uninst51.sh $BIN/uninst51.sh || exit $?
ln -s $ASEM/asem.1 $MAN1/asem.1 || exit $?
ln -s $ASEM/hexbin.1 $MAN1/hexbin.1 || exit $?
ln -s $ASEM/customiz.1 $MAN1/customiz.1 || exit $?
ln -s $ASEM/reset51.1 $MAN1/reset51.1 || exit $?
ln -s $ASEM/boot.1 $MAN1/boot.1 || exit $?

echo "(Nearly) done. :-)"
echo ""
echo "ASEM-51 V$VERSION is now installed in $ASEM."
if [ `id -u` -ne 0 ]
then
  echo "Please add $BIN to your PATH, if necessary."
fi
echo ""
echo "For easy access to the include files provided, you should define"
echo "an environment variable ASEM51INC=$MCU."
echo ""
echo "For a quick reference refer to the man-pages"
echo "asem(1), hexbin(1), customiz(1), reset51(1), and boot(1)."
if [ `id -u` -ne 0 ]
then
  echo "For this, be sure to add $MAN to your MANPATH."
fi
echo ""
echo "For detailed information refer to the documentation provided."
echo "To read the HTML manuals, invoke your web browser and bookmark"
echo "the index page $DOC/docs.htm."
