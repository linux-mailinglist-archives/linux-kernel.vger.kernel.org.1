Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316DB2AE66B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKKC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:29:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:27634 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgKKC3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:29:12 -0500
IronPort-SDR: +/bxyo4U6UntLs6kGqAGmPKDiW46Fbc1VVWG8VAMnKzBmLXazKxixqGSwRNmm48/FCz2nJTaVq
 IUdGQkjcqSzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="166574342"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="asc'?scan'208";a="166574342"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 18:29:11 -0800
IronPort-SDR: 5X9dokFnhpEvAFBUB2K5/8AZV96m5qV4k5OKyjc2wLc4dd3Z3lIL1Lg2SzwpqMV5ZFmVXPMvMZ
 /3tQpWRC4wKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="asc'?scan'208";a="356431843"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by fmsmga004.fm.intel.com with ESMTP; 10 Nov 2020 18:29:09 -0800
Date:   Wed, 11 Nov 2020 10:14:54 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: replace idr_init() by idr_init_base()
Message-ID: <20201111021454.GP1239@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20201104121532.GA48202@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <20201104121532.GA48202@localhost>
User-Agent: Mutt/1.10.0 (2018-05-17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.11.04 17:45:32 +0530, Deepak R Varma wrote:
> idr_init() uses base 0 which is an invalid identifier. The new function
> idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> all lookups that otherwise starts from 0 since 0 is always unused.
>=20
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
>=20
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/gvt.c  | 2 +-
>  drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gv=
t.c
> index c7c561237883..45b492edbb19 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.c
> +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> @@ -312,7 +312,7 @@ int intel_gvt_init_device(struct drm_i915_private *i9=
15)
> =20
>  	gvt_dbg_core("init gvt device\n");
> =20
> -	idr_init(&gvt->vgpu_idr);
> +	idr_init_base(&gvt->vgpu_idr, 1);
>  	spin_lock_init(&gvt->scheduler.mmio_context_lock);
>  	mutex_init(&gvt->lock);
>  	mutex_init(&gvt->sched_lock);
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/v=
gpu.c
> index f6d7e33c7099..1c8e63f84134 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -393,7 +393,7 @@ static struct intel_vgpu *__intel_gvt_create_vgpu(str=
uct intel_gvt *gvt,
>  	mutex_init(&vgpu->dmabuf_lock);
>  	INIT_LIST_HEAD(&vgpu->dmabuf_obj_list_head);
>  	INIT_RADIX_TREE(&vgpu->page_track_tree, GFP_KERNEL);
> -	idr_init(&vgpu->object_idr);
> +	idr_init_base(&vgpu->object_idr, 1);
>  	intel_vgpu_init_cfg_space(vgpu, param->primary);
>  	vgpu->d3_entered =3D false;
> =20
> --=20

Looks good to me. Thanks!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--=20

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCX6tJHgAKCRCxBBozTXgY
Jyv8AJ0ZLKM2ez02e517XOPfJGtsLxANrwCeITSsq29wK0WjSZLfMr4lr6t1kwA=
=0VA9
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
