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

echo_and_run cd "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_frontier"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/vivek/Documents/ROS/hw04/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/vivek/Documents/ROS/hw04/install/lib/python3/dist-packages:/home/vivek/Documents/ROS/hw04/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/vivek/Documents/ROS/hw04/build" \
    "/usr/bin/python3" \
    "/home/vivek/Documents/ROS/hw04/src/aro_frontier/aro_frontier/setup.py" \
     \
    build --build-base "/home/vivek/Documents/ROS/hw04/build/aro_frontier/aro_frontier" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/vivek/Documents/ROS/hw04/install" --install-scripts="/home/vivek/Documents/ROS/hw04/install/bin"
