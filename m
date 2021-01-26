Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3853C304DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbhAZXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:15:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:61097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbhAZFZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:25:48 -0500
IronPort-SDR: TJQpT4MYSAJotnUotqi6mG6pkcroWnk637aB9abt2/Iea8NHhDEv9xWYrVVQ7CR9q7ARjIwj5p
 Fz5Q4YFCTzCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176339202"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="asc'?scan'208";a="176339202"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:23:57 -0800
IronPort-SDR: eaBlv4AGGijngGP3ws/b3rP3NdBkcHvxQf2pWxo6jNO0z+G6Pw5uviBojrjszIlien2DQ2S0Pf
 zWsQp+kD/zbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="asc'?scan'208";a="573943834"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2021 21:23:54 -0800
Date:   Tue, 26 Jan 2021 13:09:01 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH] drm/i915/gvt: fix uninitialized return in
 intel_gvt_update_reg_whitelist()
Message-ID: <20210126050901.GF1538@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <YA6F3oF8mRaNQWjb@mwanda>
 <161156789392.31416.7341729779003502151@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <161156789392.31416.7341729779003502151@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.01.25 09:44:53 +0000, Chris Wilson wrote:
> Quoting Dan Carpenter (2021-01-25 08:48:30)
> > Smatch found an uninitialized variable bug in this code:
> >=20
> >     drivers/gpu/drm/i915/gvt/cmd_parser.c:3191 intel_gvt_update_reg_whi=
telist()
> >     error: uninitialized symbol 'ret'.
> >=20
> > The first thing that Smatch complains about is that "ret" isn't set if
> > we don't enter the "for_each_engine(engine, &dev_priv->gt, id) {" loop.
> > Presumably we always have at least one engine so that's a false
> > positive.
> >=20
> > But it's definitely a bug to not set "ret" if i915_gem_object_pin_map()
> > fails.
>=20
> True.
> =20
> > Let's fix the bug and silence the false positive.
> >=20
> > Fixes: 493f30cd086e ("drm/i915/gvt: parse init context to update cmd ac=
cessible reg whitelist")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks, Dan & Chris! Queued this up.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYA+j6AAKCRCxBBozTXgY
J5cJAJ9sFEZY0fDpLiQtUxokU7lBHau3GQCePa3i/LHx5XYBX6y/5g6zbXsx+DQ=
=ooGI
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
