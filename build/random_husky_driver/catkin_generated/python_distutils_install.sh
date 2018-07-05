#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/tom/ros101/src/random_husky_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tom/ros101/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tom/ros101/install/lib/python2.7/dist-packages:/home/tom/ros101/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tom/ros101/build" \
    "/usr/bin/python" \
    "/home/tom/ros101/src/random_husky_driver/setup.py" \
    build --build-base "/home/tom/ros101/build/random_husky_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/tom/ros101/install" --install-scripts="/home/tom/ros101/install/bin"
