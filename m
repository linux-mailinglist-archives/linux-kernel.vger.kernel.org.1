Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B402271BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIUH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgIUH0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:26:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C59D9B239;
        Mon, 21 Sep 2020 07:26:56 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 3/3] drm/hisilicon: Releasing Resources in
 the Destroy callback Function
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
 <1600658722-35945-4-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <8dffa9f6-40ba-4d6b-a754-e6fbe59b84dc@suse.de>
Date:   Mon, 21 Sep 2020 09:26:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600658722-35945-4-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="67QygkkIabChZqUlFH6ASlUm8DVPrKKWs"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--67QygkkIabChZqUlFH6ASlUm8DVPrKKWs
Content-Type: multipart/mixed; boundary="AVO1J07Y81GVQHDtXA6pjKA7OKms7BRkI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <8dffa9f6-40ba-4d6b-a754-e6fbe59b84dc@suse.de>
Subject: Re: [PATCH drm/hisilicon 3/3] drm/hisilicon: Releasing Resources in
 the Destroy callback Function
References: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
 <1600658722-35945-4-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600658722-35945-4-git-send-email-tiantao6@hisilicon.com>

--AVO1J07Y81GVQHDtXA6pjKA7OKms7BRkI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

The code looks correcet, but I think this patch should be merged into
patch 2. Anyone who initializes the i2c adapter certainly wants it
cleaned up as well :)

Best regards
Thomas


Am 21.09.20 um 05:25 schrieb Tian Tao:
> Rewrite the desrtoy callback function to release resources.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index e84d381..f1541ff 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -47,6 +47,14 @@ static enum drm_mode_status hibmc_connector_mode_val=
id(struct drm_connector *con
>  	return MODE_OK;
>  }
> =20
> +static void hibmc_connector_destroy(struct drm_connector *connector)
> +{
> +	struct hibmc_connector *hibmc_connector =3D to_hibmc_connector(connec=
tor);
> +
> +	i2c_del_adapter(&hibmc_connector->adapter);
> +	drm_connector_cleanup(connector);
> +}
> +
>  static const struct drm_connector_helper_funcs
>  	hibmc_connector_helper_funcs =3D {
>  	.get_modes =3D hibmc_connector_get_modes,
> @@ -55,7 +63,7 @@ static const struct drm_connector_helper_funcs
> =20
>  static const struct drm_connector_funcs hibmc_connector_funcs =3D {
>  	.fill_modes =3D drm_helper_probe_single_connector_modes,
> -	.destroy =3D drm_connector_cleanup,
> +	.destroy =3D hibmc_connector_destroy,
>  	.reset =3D drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_sta=
te,
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--AVO1J07Y81GVQHDtXA6pjKA7OKms7BRkI--

--67QygkkIabChZqUlFH6ASlUm8DVPrKKWs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9oVZsUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiOrRAgAkUJrhil+yGiFDo32tuJYH4QU/V/E
1LnmoviaQ6Tm9fmMNp+Q6xVZz5NB7Qt0SsNbSMJB1FiqwXi2H/Bt7AwXM1TckZCh
vsreTxnpkjV/MEasb904cdMHTyIzvB7Yn1oU+YRpL66PvX4mCkriKIsDBr3pF2eW
Q5vJH2FRSxKHmc9LmLbHELHSHyqedvA+9Xph64LDNydxpwvQIq4Dog6sSxqjNfCW
75IdA3Jl5sBCnC+MUBosG6rjTo+tHjLzovfFlNLurUy1ht6AXBS4/ipsD5/ZCoM4
iEfN6EBMS2KpWXI6GTVH1cgT8y/EcSTANQUPumEu+lTqwbXEyazlBJFClg==
=Ht2m
-----END PGP SIGNATURE-----

--67QygkkIabChZqUlFH6ASlUm8DVPrKKWs--
