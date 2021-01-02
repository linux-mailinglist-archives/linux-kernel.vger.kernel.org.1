Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B572E8601
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 01:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbhABAog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 19:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbhABAof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 19:44:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3BC62151B;
        Sat,  2 Jan 2021 00:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609548234;
        bh=owlaR9KANyawFUUa98YH8smNm8K7oBTLr4GIwtXfXOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HjZ/qOwTJ5NVHOd0CEVuqmhrOQiBae7grNfqG6sejyUYnK/D4/ymoBXGN2QPKxr/2
         BZ+1xKGi3dVIi2NwYLoA+YWxnny3/txqjJFZAM2aHRLxRfaM3Md93NCMB87dE5XmRm
         0BnhXe+0ufHdY+LKrFegNXyJY/6FOTaDdn3QnKQdVijoCkRFhhK72i28mrz1FAS92f
         hmghSN7vo3UqUK/28IXe/bQvRuol5ext6p5WHwVrzjCt9S/6ef0vcm24o75brKmCLP
         /QzY7w/kRyC7EGb36FfLeKw/GGQw3uhnlh7HCF3JZoipjc57fuRds+quu6o5IZ7p1I
         Fxpz69ndinMuQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 8ABA73C0C94; Sat,  2 Jan 2021 01:43:52 +0100 (CET)
Date:   Sat, 2 Jan 2021 01:43:52 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     gustavoars@kernel.org, carlos.chinea@nokia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: Fix PM usage counter unbalance in ssi_hw_init
Message-ID: <20210102004352.z5yh3i25bftnx7ap@earth.universe>
References: <20201123101827.3863792-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gtdvmmddep46fz4i"
Content-Disposition: inline
In-Reply-To: <20201123101827.3863792-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtdvmmddep46fz4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 23, 2020 at 06:18:27PM +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter
> even it failed. Forgetting to putting operation will
> result in reference leak here. We fix it by replacing
> it with pm_runtime_resume_and_get to keep usage counter
> balanced.
>=20
> Fixes: b209e047bc743 ("HSI: Introduce OMAP SSI driver")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index fa69b94debd9..b4ac2f8cb9f9 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -424,7 +424,7 @@ static int ssi_hw_init(struct hsi_controller *ssi)
>  	struct omap_ssi_controller *omap_ssi =3D hsi_controller_drvdata(ssi);
>  	int err;
> =20
> -	err =3D pm_runtime_get_sync(ssi->device.parent);
> +	err =3D pm_runtime_resume_and_get(ssi->device.parent);
>  	if (err < 0) {
>  		dev_err(&ssi->device, "runtime PM failed %d\n", err);
>  		return err;
> --=20
> 2.25.4
>=20

--gtdvmmddep46fz4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/vwcEACgkQ2O7X88g7
+poLcA/+MyQSUe8vFe0A+uOc8Ia/hrDDWoFI7GzKQ1+F0Mj02Hy4uPHH/MCVqDd9
ql9iiRlwBUknCVRdBz74uVHfs9a0J/ZTtJwVeCmBzM9PhyV2cDo7yQCKFR3w7d+T
3Fl6rxwKa8TVyTrSXK7ixyMmrKOFo3KiAoUyawrF1O7Bb529Kfueo3cHbL6iuDFg
D1aAYDFndlHFGY4THQE9xUaOqL0K7h20MhrLsxbv3TAkNmb2pawe2eKWgtRM+xdc
I9zcXGPvRh/h8AlwltetGWMA2oMdF9RYhC6ISzcVWCdZvAr+os2n+6EB7/hGunSd
cRZAfierpf06nk1KCE1m4pvczRLZY6cdX0OHEXTt4dXMypv2J2L2cAklX3X7WeIr
uELJIYs+frN2BNPhDpCynhJtvZpQPoAroVz+f46kHYeH21y+PzntEigETu6sBsxp
+zhb0ABXQ9qXshkeTfm1sojpB5xXlAZcYUdmMBG4srTaJZtUtV1N3l8tKISaVpLR
uwxpr0BSXENbSuj+Xpea7rxgFqGXWWvOGk8WIJh4ApOueyw1pnTYiPiQT6vHQL6G
dD3EdvY9lKvjKDmTTfUAoIrk7MLKyMtuJZlBcf12+lNX2Rz1ZMAl6LlRYjooMss7
56xtx6kepm+W6+HQDqC1vhqDRTn5Qt0Zf6S1FRZR4N2Hyc8OlaI=
=JT1L
-----END PGP SIGNATURE-----

--gtdvmmddep46fz4i--
