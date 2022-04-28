#!/usr/bin/env python3
from __future__ import absolute_import, division, print_function
from enum import Enum
import numpy as np
from numpy.lib.recfunctions import structured_to_unstructured, unstructured_to_structured


__all__ = [
    'Channels',
    'DType',
    'e2p',
    'normal',
    'p2e',
    'position',
    'transform',
    'viewpoint'
]


class Channels(Enum):
    position = ['x', 'y', 'z']
    mean = ['mean_%s' % f for f in 'xyz']
    normal = ['normal_%s' % f for f in 'xyz']
    curvature = ['curvature']
    roughness = ['roughness']
    viewpoint = ['vp_%s' % f for f in 'xyz']
    projection = ['proj_%s' % f for f in 'xyz']


class DType(Enum):
    position = np.dtype([(f, 'f4') for f in Channels.position.value])
    mean = np.dtype([(f, 'f4') for f in Channels.mean.value])
    normal = np.dtype([(f, 'f4') for f in Channels.normal.value])
    curvature = np.dtype([(f, 'f4') for f in Channels.curvature.value])
    roughness = np.dtype([(f, 'f4') for f in Channels.roughness.value])
    viewpoint = np.dtype([(f, 'f4') for f in Channels.viewpoint.value])
    projection = np.dtype([(f, 'f4') for f in Channels.projection.value])


def position(x_struct):
    return structured_to_unstructured(x_struct[Channels.position.value])


def normal(x_struct):
    return structured_to_unstructured(x_struct[Channels.normal.value])


def viewpoint(x_struct):
    return structured_to_unstructured(x_struct[Channels.viewpoint.value])


def e2p(x, axis=-1):
    assert isinstance(x, np.ndarray)
    assert isinstance(axis, int)
    h_size = list(x.shape)
    h_size[axis] = 1
    h = np.ones(h_size, dtype=x.dtype)
    xh = np.concatenate((x, h), axis=axis)
    return xh


def p2e(xh, axis=-1):
    assert isinstance(xh, np.ndarray)
    assert isinstance(axis, int)
    if axis != -1:
        xh = xh.swapaxes(axis, -1)
    x = xh[..., :-1]
    if axis != -1:
        x = x.swapaxes(axis, -1)
    return x


def transform(T, x_struct):
    assert isinstance(T, np.ndarray)
    assert T.shape == (4, 4)
    assert isinstance(x_struct, np.ndarray)
    x_struct = x_struct.copy()
    fields_op = []
    for fs, dtype, op in ((Channels.position.value, DType.position.value, 'Rt'),
                   (Channels.viewpoint.value, DType.viewpoint.value, 'Rt'),
                   (Channels.normal.value, DType.normal.value, 'R')):
        if fs[0] in x_struct.dtype.fields:
            fields_op.append((fs, op))
    for fs, op in fields_op:
        x = structured_to_unstructured(x_struct[fs])
        if op == 'Rt':
            x = p2e(np.matmul(e2p(x), T.T))
        elif op == 'R':
            x = np.matmul(x, T[:-1, :-1].T)
        x_struct[fs] = unstructured_to_structured(x, dtype=dtype)
    return x_struct


