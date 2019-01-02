from cython.operator cimport dereference as deref
from libcpp.map cimport map
import logging
import numpy as np
cimport cython
cimport numpy as np

@cython.boundscheck(False)
@cython.wraparound(False)
def replace_values_inplace(np.ndarray[np.uint64_t, ndim=1, mode='c'] array, values_map):

    cdef Py_ssize_t i = 0
    cdef Py_ssize_t n = array.size
    cdef np.npy_uint64* a = &array[0]
    cdef map[np.npy_uint64, np.npy_uint64] cmap = values_map

    for i in range(n):
        it = cmap.find(a[i])
        if it == cmap.end():
            continue
        a[i] = deref(it).second
