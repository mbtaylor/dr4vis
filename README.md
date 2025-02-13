# dr4vis

Some scripts to do visualisation comparing Gaia DR4 to previous releases.

This is intended for DPAC use, since at time of writing it requires
password-protected access to embargoed data.

To generate the local data files and figures, just run `make build`.
However, for embargoed data you will need to have in this directory
files `username` and `password` containing your cosmos credentials,
authorized for access to (currently) DR4INT4B.
These files should be user-read only (`chmod 600`).
