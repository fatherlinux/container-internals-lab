#!/bin/bash

# Deletes the application objects
oc delete rc/wordpress rc/mysql pvc/claim-wp pvc/claim-mysql routes/wpfrontend svc/mysql svc/wpfrontend

# Deletes the storage objects. Can be commented out to maintain data between instantiations.
#oc delete pv/pv0001 pv/pv0002 pv/pv0003 pv/pv0004
