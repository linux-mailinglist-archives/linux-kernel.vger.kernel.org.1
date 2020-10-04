Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19A3282DD5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 23:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgJDV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 17:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgJDV4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 17:56:01 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9224206DD;
        Sun,  4 Oct 2020 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601848560;
        bh=J1ZTmhTh0VE3g9Eq7af3To3vo/Eh5KFJ4Gbjr0lyZEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3DRqR+mEweZY+RxVOkwC4+nSFfe+LcHzhiCxSI9qI1CPfotDXWq4q07pJOoH9xh5
         e0ozYaQcYufFXesjSP4137k5UDFt4/aiRVCRToSMswFy5uOhrW7K4dFJhePw/kTyGe
         5gIlSgfAb9IPLDl6OYYEekTT0FVtp+6e8M/D2d24=
Received: by earth.universe (Postfix, from userid 1000)
        id 5E2C03C0C87; Sun,  4 Oct 2020 23:55:58 +0200 (CEST)
Date:   Sun, 4 Oct 2020 23:55:58 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Akira Shimahara <akira215corp@gmail.com>
Subject: Re: [PATCH 1/3] w1: Constify struct w1_family_ops
Message-ID: <20201004215558.tx63d2twqh222vxo@earth.universe>
References: <20201004193202.4044-1-rikard.falkeborn@gmail.com>
 <20201004193202.4044-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gz6txsv2clopfftb"
Content-Disposition: inline
In-Reply-To: <20201004193202.4044-2-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gz6txsv2clopfftb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 04, 2020 at 09:32:00PM +0200, Rikard Falkeborn wrote:
> The fops field in the w1_family struct is never modified. Make it const
> to indicate that. Constifying the pointer makes it possible for drivers
> to declare static w1_family_ops structs const, which in turn will allow
> the compiler to put it in read-only memory.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/w1/w1.c    | 2 +-
>  include/linux/w1.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index e58c7592008d..6bd64bcb6316 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -613,7 +613,7 @@ static int w1_uevent(struct device *dev, struct kobj_=
uevent_env *env)
> =20
>  static int w1_family_notify(unsigned long action, struct w1_slave *sl)
>  {
> -	struct w1_family_ops *fops;
> +	const struct w1_family_ops *fops;
>  	int err;
> =20
>  	fops =3D sl->family->fops;
> diff --git a/include/linux/w1.h b/include/linux/w1.h
> index cebf3464bc03..949d3b10e531 100644
> --- a/include/linux/w1.h
> +++ b/include/linux/w1.h
> @@ -269,7 +269,7 @@ struct w1_family {
>  	struct list_head	family_entry;
>  	u8			fid;
> =20
> -	struct w1_family_ops	*fops;
> +	const struct w1_family_ops *fops;
> =20
>  	const struct of_device_id *of_match_table;
> =20
> --=20
> 2.28.0
>=20

--gz6txsv2clopfftb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl96ROsACgkQ2O7X88g7
+pqtqw//ThjNx+K3dBPwn0cFexIitCRlwfUE/EM3er8mtujC2cYiU2rYH6sVUiBX
x/7P3thxU3O3Uz3QN5klVJd2nHovFc5bV1yN28Zp+HkcTHpv04+UnlNsxslYDBQa
cNvrPSOzGxOOKrZ0PBLwmsGD5v6lQ6DoZ6MXY4ltfRxII7rDuqo9lb8sscevdNJD
MjfzUBO/GjKkwfQ0irZxhUZhlfDsW04Xb4CKoPn1dVEyipmdcSPcIpY/rDA3Ghqa
SpJMNUoKLff6Cknz4A6MQYNLDQkbM1qvorc4e1BgYgwQlcwPXxfcooxQXeUUGaKL
FZ60XpoOxS7t5ltva9wX0nTxORFR1sEXak8szI8PHDfAL9a8rUbPKlVHyo8bsrkM
Ap62y+Tk0oCeBBHjnVVPqf2L3WO2JOd/QCCk45kiuMd3/H85OsftJAMMnXDieTj+
tv8KQ0oKElwPc1uZSEUhVHYxczozierW4vYMhIuTkZ/EmLJU1NkQnVZIrxQRFciI
xGguw4YqiVAztB6CvEMm1BRNY6cqAaFnN5fG6AAz+Da5QQHlrVB0fiSd2BvT/hUE
6g9JGh237LcPt2cv6lGOcXEE2kH9+BUfodB28sHNyJ4snbYq59FZcWSZhNGEm8mu
NDMihn17Iiozxu21t9+2/WuHnVOOMk8Deo4eaKOcWKNwPUpfZRY=
=d43l
-----END PGP SIGNATURE-----

--gz6txsv2clopfftb--
