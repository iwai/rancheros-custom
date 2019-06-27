################################################################################
#
# google-authenticator-libpam
#
################################################################################

GOOGLE_AUTHENTICATOR_LIBPAM_VERSION = 1.06
GOOGLE_AUTHENTICATOR_LIBPAM_SITE = https://github.com/google/google-authenticator-libpam
GOOGLE_AUTHENTICATOR_LIBPAM_SITE_METHOD = git

GOOGLE_AUTHENTICATOR_LIBPAM_AUTORECONF = YES
GOOGLE_AUTHENTICATOR_LIBPAM_AUTORECONF_OPTS = -i

$(eval $(autotools-package))
