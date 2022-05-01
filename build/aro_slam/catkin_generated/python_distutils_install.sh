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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/vivek/Documents/ROS/sw01/src/aro_slam"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/vivek/Documents/ROS/sw01/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/vivek/Documents/ROS/sw01/install/lib/python3/dist-packages:/home/vivek/Documents/ROS/sw01/build/aro_slam/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/vivek/Documents/ROS/sw01/build/aro_slam" \
    "/usr/bin/python3" \
    "/home/vivek/Documents/ROS/sw01/src/aro_slam/setup.py" \
     \
    build --build-base "/home/vivek/Documents/ROS/sw01/build/aro_slam" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/vivek/Documents/ROS/sw01/install" --install-scripts="/home/vivek/Documents/ROS/sw01/install/bin"
