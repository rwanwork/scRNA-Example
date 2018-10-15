#####################################################################
##  Global variables
##
##  Raymond Wan (raymondwan@ust.hk)
##  Organizations:
##    - Division of Life Science, 
##      Hong Kong University of Science and Technology
##      Hong Kong
##
##  Copyright (C) 2018, Raymond Wan, All rights reserved.
#####################################################################


#####################################################################
##  Variables related to paths
#####################################################################

from pathlib import Path
import os
import pwd

##  Determine the home directory
HOME_DIR = str (Path.home())

INPUT_DIR = "test"  ##  Input directory


#####################################################################
##  Other variables
#####################################################################

##  Get the login name -- needed to create the temporary directories
##  MY_LOGIN = os.getlogin ()
MY_LOGIN = pwd.getpwuid (os.geteuid ()).pw_name


