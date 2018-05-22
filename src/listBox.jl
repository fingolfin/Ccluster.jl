#
#  Copyright (C) 2018 Remi Imbach
#
#  This file is part of Ccluster.
#
#  Ccluster is free software: you can redistribute it and/or modify it under
#  the terms of the GNU Lesser General Public License (LGPL) as published
#  by the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.  See <http://www.gnu.org/licenses/>.
#

type listBox
    _begin::Ptr{Void}
    _end::Ptr{Void}
    _size::Cint
    _clear::Ptr{Void}
    
    function listBox()
        z = new()
        ccall( (:compBox_list_init, :libccluster), 
             Void, (Ptr{listBox},), 
                    &z)
#         finalizer(z, _listBox_clear_fn)
        return z
    end
end

function _listBox_clear_fn(lc::listBox)
    ccall( (:compBox_list_clear, :libccluster), 
         Void, (Ptr{listBox},), 
                &lc)
end

function isEmpty( lc::listBox )
    res = ccall( (:compBox_list_is_empty, :libccluster), 
                  Cint, (Ptr{listBox},), 
                        &lc )
    return Bool(res)
end

function pop( lc::listBox )
    res = ccall( (:compBox_list_pop, :libccluster), 
                  Ptr{box}, (Ptr{listBox},), 
                                 &lc)                        
    resobj::box = unsafe_load(res)
    return resobj
end


function push( lc::listBox, cc::box )
    ccall( (:compBox_list_push, :libccluster), 
             Void, (Ptr{listBox}, Ptr{box}), 
                    &lc,               &cc)
end


