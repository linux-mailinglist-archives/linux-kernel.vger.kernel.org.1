Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8F1A4256
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 07:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDJFyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 01:54:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:35347 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJFyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:54:45 -0400
IronPort-SDR: ynbHn0OZQEf6/IbWgb4DejDaRHB2+0xaYb9NZFsXM8Su+ffUQXvVhBB4Ht8dZeJ2RQM8P03LnR
 gMvp+y5pKi7w==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 22:54:44 -0700
IronPort-SDR: neQ7V9BrtVs+lpG9al2irFFnbVHHjZ/ITmulTc10fSr/Ts1diyctt1UOZJ8ozUdvILKsu1W89J
 v9yq1WSKecDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; 
   d="asc'?scan'208";a="255386528"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2020 22:54:41 -0700
Date:   Fri, 10 Apr 2020 13:41:08 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/i915: remove gvt/Makefile
Message-ID: <20200410054108.GK11247@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200409150627.29205-1-masahiroy@kernel.org>
 <20200409150627.29205-2-masahiroy@kernel.org>
 <87h7xsgw3r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <87h7xsgw3r.fsf@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.04.10 00:58:16 +0300, Jani Nikula wrote:
> On Fri, 10 Apr 2020, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > Including subdirectory Makefile from the driver main Makefile does not
> > buy us much because this is not real isolation.
>=20
> The isolation it does buy us is that gvt/ subdirectory is developed and
> maintained on a separate mailing list and separate git repo. I think at
> some point there were plans to make it an actual module too.
>=20
> So while you could quip about Conway's law here, I think it might be
> better to keep this as it is.
>=20
> Zhenyu, Zhi, what do you think?

Yeah, I have the same feeling, maybe we can add some comment in gvt Makefile
to state that point.

Thanks

> >
> > Having a single Makefile at the top of the module is clearer, and
> > it is what this driver almost does.
> >
> > Move all gvt objects to the i915 main Makefile.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  drivers/gpu/drm/i915/Makefile     | 28 ++++++++++++++++++++++++----
> >  drivers/gpu/drm/i915/gvt/Makefile |  8 --------
> >  2 files changed, 24 insertions(+), 12 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/i915/gvt/Makefile
> >
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makef=
ile
> > index 6cd1f6253814..74e965882a98 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -275,10 +275,30 @@ i915-$(CONFIG_DRM_I915_SELFTEST) +=3D \
> >  # virtual gpu code
> >  i915-y +=3D i915_vgpu.o
> > =20
> > -ifeq ($(CONFIG_DRM_I915_GVT),y)
> > -i915-y +=3D intel_gvt.o
> > -include $(src)/gvt/Makefile
> > -endif
> > +i915-$(CONFIG_DRM_I915_GVT) +=3D \
> > +	intel_gvt.o \
> > +	gvt/gvt.o \
> > +	gvt/aperture_gm.o \
> > +	gvt/handlers.o \
> > +	gvt/vgpu.o \
> > +	gvt/trace_points.o \
> > +	gvt/firmware.o \
> > +	gvt/interrupt.o \
> > +	gvt/gtt.o \
> > +	gvt/cfg_space.o \
> > +	gvt/opregion.o \
> > +	gvt/mmio.o \
> > +	gvt/display.o \
> > +	gvt/edid.o \
> > +	gvt/execlist.o \
> > +	gvt/scheduler.o \
> > +	gvt/sched_policy.o \
> > +	gvt/mmio_context.o \
> > +	gvt/cmd_parser.o \
> > +	gvt/debugfs.o \
> > +	gvt/fb_decoder.o \
> > +	gvt/dmabuf.o \
> > +	gvt/page_track.o
> > =20
> >  obj-$(CONFIG_DRM_I915) +=3D i915.o
> >  obj-$(CONFIG_DRM_I915_GVT_KVMGT) +=3D gvt/kvmgt.o
> > diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/g=
vt/Makefile
> > deleted file mode 100644
> > index 4d70f4689479..000000000000
> > --- a/drivers/gpu/drm/i915/gvt/Makefile
> > +++ /dev/null
> > @@ -1,8 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0
> > -GVT_DIR :=3D gvt
> > -GVT_SOURCE :=3D gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o f=
irmware.o \
> > -	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
> > -	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o deb=
ugfs.o \
> > -	fb_decoder.o dmabuf.o page_track.o
> > -
> > -i915-y					+=3D $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXpAG9AAKCRCxBBozTXgY
J5rLAJ45nWTbStFQsqc5yvlIr+XX8Ig8YACdFQ67J8jqCGmeYx/Y196ZAH2skGM=
=Zhzu
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
