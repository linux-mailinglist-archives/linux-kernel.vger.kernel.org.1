Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57CB2B150C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 05:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMEQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 23:16:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:44490 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMEQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 23:16:30 -0500
IronPort-SDR: vS+CLk3u0ttEtZr0yQ5uYkNzTVk21NUwZaGFhy5T+tHM9p8DHE65fM6QH4gLP8nxlDZglwbv+g
 SvYiroCb0QcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="188436104"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="asc'?scan'208";a="188436104"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 20:16:21 -0800
IronPort-SDR: V9PKPP4pGn768q/bpv+VGB/U90M8zzH2YWRMptBq7vAlf95WLn2zXDhE1zfpNrwZHFJ7l6hvRW
 KTv8zdptWNbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="asc'?scan'208";a="366823985"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2020 20:16:17 -0800
Date:   Fri, 13 Nov 2020 12:01:57 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, chenzhou10@huawei.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, zhenyuw@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/gvt: return error when failing to take the
 module reference
Message-ID: <20201113040157.GC1239@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1605187352-51761-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <1605187352-51761-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.11.12 21:22:32 +0800, Xiongfeng Wang wrote:
> When we fail to take the module reference, we go to the 'undo*' branch and
> return. But the returned variable 'ret' has been set as zero by the
> above code. Change 'ret' to '-ENODEV' in this situation.
>=20
> Fixes: 9bdb073464d6 ("drm/i915/gvt: Change KVMGT as self load module")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index ad8a9df..778eb8c 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -829,8 +829,10 @@ static int intel_vgpu_open(struct mdev_device *mdev)
>  	/* Take a module reference as mdev core doesn't take
>  	 * a reference for vendor driver.
>  	 */
> -	if (!try_module_get(THIS_MODULE))
> +	if (!try_module_get(THIS_MODULE)) {
> +		ret =3D -ENODEV;
>  		goto undo_group;
> +	}
> =20
>  	ret =3D kvmgt_guest_init(mdev);
>  	if (ret)
> --=20

Thanks for the fix!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--=20

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCX64FNQAKCRCxBBozTXgY
J45NAJ0VnPJIl47zMeVco/AbAnMwTEJOYwCglU9+zHkgsgnFxJR5VKwxpu7ag0I=
=JW7h
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
