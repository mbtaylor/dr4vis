# dr4vis

Some scripts to do visualisation comparing Gaia DR4 to previous releases.

This is intended for DPAC use, since at time of writing it requires
password-protected access to embargoed (DR4) data.
Following the DR4 release on 2 Dec 2026 it could be adapted for
usage by anybody with a Gaia account.

## Usage

To generate the local data files and figures, just run `make build`.
However, for embargoed data you will need to have in this directory
files `username` and `password` containing your cosmos credentials,
authorized for access to (currently) DR4RC3.
These files should be user-read only (`chmod 600`).

At present the makefile in the top-level directory assembles various
local FITS files from TAP queries to one or more of the GACS TAP
services, and makes some experimental montages and other visuals
for Gaia DR1/2/3/4.

The subdirectory `ftp/` contains instructions for building the
particular images requested for DR4 outreach preparations.
It uses the data files assembled by the top-level directory.

To assemble the files used for uploading to the Gaia SFTP server
in accordance with the request:

* in the top-level directory `make build`
* in the `ftp/` directory: `make build uploads`

The files to upload will then be copied into the `ftp/upload` directory.
