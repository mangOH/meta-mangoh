## Using the meta-mangoh yocto layer steps are as follows:

* Please download the tarball for the WP76xx Linux Distribution

* git clone at the top level - i.e. should get a meta-mangoh at the same level as the meta-swi layer

* make image_{bin,src} depending on your license. Or do bitbake kernel recipe
    commands directly.

* Add all your patches and config fragments based on the Yocto manuals
    to recipes-kernel/linux/files.

* If you need Yocto variables for use by the meta-mangoh layer please add them
    to conf/layer.conf.

* We have a couple of violations of Yocto based on the SWI Yocto system - if it
    is fixed we will follow the proper Yocto way in the future (comments are in
    recipes-kernel/linux/linux-quic_git.bbappend

