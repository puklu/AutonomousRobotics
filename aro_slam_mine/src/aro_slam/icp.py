#!/usr/bin/env python3
from __future__ import absolute_import, division, print_function
from enum import Enum
from .clouds import e2p, normal, p2e, position, transform
import numpy as np
from numpy.lib.recfunctions import unstructured_to_structured
import rospy
from scipy.spatial import cKDTree
import unittest

__all__ = [
    'absolute_orientation',
    'icp',
    'IcpResult',
    'Loss',
]


class Loss(Enum):
    point_to_plane = 'point_to_plane'
    point_to_point = 'point_to_point'


def absolute_orientation(x, y):
    """Find transform R, t between x and y, such that the sum of squared
    distances ||R * x[:, i] + t - y[:, i]|| is minimum.

    :param x: Points to align, D-by-M array.
    :param y: Reference points to align to, D-by-M array.

    :return: Optimized transform from SE(D) as (D+1)-by-(D+1) array,
        T = [R t; 0... 1].
    """
    assert x.shape == y.shape, 'Inputs must be same size.'
    assert x.shape[1] > 0
    assert y.shape[1] > 0
    d = x.shape[0]
    T = np.eye(d + 1)

    # TODO: ARO homework 3: Implement absolute orientation.
    x_prime = []
    y_prime = []

    mean_x = np.mean(x)
    mean_y = np.mean(y)

    for i in range(0, d):
        x_prime[i].append(x[i] - mean_x)
        y_prime[i].append(y[i] - mean_y)

    H = np.dot(y_prime, np.transpose(x_prime))
    U, S, VT = np.linalg.svd(H, full_matrices=True)
    R_star = np.dot(np.transpose(VT), np.transpose(U))
    t_star = mean_x - R_star * mean_y

    T = np.hstack((R_star, np.transpose(t_star)))
    last_row = [0 for i in range(len(R_star[0]))]
    last_row = last_row.append(1)
    T = np.vstack((T, last_row))

    return T


class IcpResult(object):
    """ICP registration result."""

    def __init__(self, T=None, num_iters=None, idx=None, inliers=None,
                 x_inliers=None, y_inliers=None, mean_inlier_dist=None):
        """Initialize ICP registration result.

        @param T A 4-by-4 aligning transform array or None if registration failed.
        @param num_iters Number of iterations run.
        @param idx Nearest neighbors from descriptor matching.
        @param x_inliers Aligned M-by-3 position array of inliers.
        @param y_inliers Reference M-by-3 position array of inliers.
                In general, not original y for point-to-plane loss.
        @param inliers Inlier mask, use x[inliers] or y[idx[inliers]].
        @param mean_inlier_dist Mean point distance for inlier correspondences.
        """
        self.T = T
        self.num_iters = num_iters
        self.idx = idx
        self.x_inliers = x_inliers
        self.y_inliers = y_inliers
        self.inliers = inliers
        self.mean_inlier_dist = mean_inlier_dist


def index(seq, idx):
    return [seq[i] for i in idx]


def sample(seq, n):
    if len(seq) == 0:
        return []
    idx = np.unique(np.linspace(0, len(seq) - 1, n, dtype=int))
    s = index(seq, idx)
    return s


def icp(x_struct, y_struct, y_index=None,
        descriptor=position,
        T=None, max_iters=50,
        inlier_ratio=1.0, inlier_dist_mult=1.0, max_inlier_dist=float('inf'),
        loss=Loss.point_to_point):
    """Iterative closest point (ICP) algorithm, minimizing sum of squared
    point-to-point or point-to-plane distances.

    Input point clouds are structured arrays, with
    - position fields 'x', 'y', 'z', and
    - normal fields 'normal_x', 'normal_y', 'normal_z'.

    @param x_struct: Points to align, structured array.
    @param y_struct: Reference points to align to.
    @param y_index: NN search index for y_struct, cKDTree, which can be queried
            with descriptors(x_struct).
    @param descriptor: callable to create descriptors from structured array.
    @param max_iters: Maximum number of iterations.
    @param inlier_ratio: Ratio of inlier correspondences with lowest distances
            for which we optimize the criterion in given iteration. The inliers
            set may change each iteration.
    @param inlier_dist_mult: Multiplier of the maximum inlier distance found
            using inlier ratio above, enlarging or reducing the inlier set for
            optimization.
    @param max_inlier_dist: Maximum distance for inlier correspondence.
    @param T: Initial transform estimate from SE(D), defaults to identity.
    @return: IcpResult Optimized transform from SE(D) as (D+1)-by-(D+1) array,
            mean inlier distace from the last iteration, and
            boolean inlier mask from the last iteration, x[inl] are the
            inlier points.
    """
    assert isinstance(x_struct, np.ndarray) and x_struct.shape[0] > 0
    assert isinstance(y_struct, np.ndarray) and y_struct.shape[0] > 0
    assert y_index is None or isinstance(y_index, cKDTree)
    assert callable(descriptor)
    assert T is None or isinstance(T, np.ndarray)
    assert max_iters > 0
    assert 0.0 <= inlier_ratio <= 1.0
    assert 0.0 < inlier_dist_mult

    d = 3 if 'z' in x_struct.dtype.names else 2

    if y_index is None:
        y_desc = descriptor(y_struct)
        y_index = cKDTree(y_desc)

    if T is None:
        T = np.eye(d + 1)

    assert T.shape == (d + 1, d + 1)

    # Boolean inlier mask from current iteration.
    inl = np.zeros((x_struct.size,), dtype=np.bool)
    # Mean inlier distance history (to assess improvement).
    inl_errs = []

    idx = None
    x_inl = None
    y_inl = None

    # TODO: ARO homework 3: Implement point-to-point ICP.
    print("Hello from my implementation of ICP")
    # print(np.shape(x_struct))
    # print((np.shape(x_struct.T)))
    x_struct = transform(T, x_struct)


    for i in range(max_iters):

        nds, idx = y_index.query(np.transpose(x_struct))
        print("nds....")
        print(nds)
        print("idx....")
        print(idx)
        # nds : distance between nearest neighbours
        # idx : indices of nearest neighbours

        # reject outliers

        Q = np.quantile(nds, inlier_ratio)
        C = inlier_dist_mult * Q
        a = nds < C

        x_inl = x_struct[:, a]
        y_inl = y_struct[:, idx[a]]

        T = absolute_orientation(x_inl, y_inl)

        inl_errs = inl_errs.append(transform(T, x_inl) - y_inl)

        # updating
        x_struct = transform(T, x_inl)


    # TODO: ARO homework 3: Implement point-to-plane ICP.
    # plane defined by normal vector
    # TODO: ARO homework 3: Use custom descriptor.

    # x_inl = p2e(e2p(x_inl) @ T.T)

    return IcpResult(T=T, num_iters=iter, idx=idx, inliers=inl,
                     x_inliers=x_inl, y_inliers=y_inl,
                     mean_inlier_dist=inl_errs[-1] if inl_errs else float('nan'))
