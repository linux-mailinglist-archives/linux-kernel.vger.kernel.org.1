Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A008D2F0D81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbhAKHuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:50:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:56324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbhAKHuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:50:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D896AD62;
        Mon, 11 Jan 2021 07:49:37 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Use drm_crtc_mask()
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1610335818-32895-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <adf7a7cb-ac91-5d46-6faf-f77362fa515c@suse.de>
Date:   Mon, 11 Jan 2021 08:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610335818-32895-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bseePHVaxwue1iMzXgJRiCtQnNMdi4Noi"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bseePHVaxwue1iMzXgJRiCtQnNMdi4Noi
Content-Type: multipart/mixed; boundary="FCC3G2ml740cYgBEccaqi4gPePszz46aU";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Message-ID: <adf7a7cb-ac91-5d46-6faf-f77362fa515c@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Use drm_crtc_mask()
References: <1610335818-32895-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1610335818-32895-1-git-send-email-tiantao6@hisilicon.com>

--FCC3G2ml740cYgBEccaqi4gPePszz46aU
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 11.01.21 um 04:30 schrieb Tian Tao:
> Use drm_crtc_mask() where appropriate.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Looks like the right thing to do.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index c76f996..1c5f2fa 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -96,6 +96,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>   	struct drm_device *dev =3D &priv->dev;
>   	struct hibmc_connector *hibmc_connector =3D &priv->connector;
>   	struct drm_encoder *encoder =3D &priv->encoder;
> +	struct drm_crtc *crtc =3D &priv->crtc;
>   	struct drm_connector *connector =3D &hibmc_connector->base;
>   	int ret;
>  =20
> @@ -105,7 +106,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)=

>   		return ret;
>   	}
>  =20
> -	encoder->possible_crtcs =3D 0x1;
> +	encoder->possible_crtcs =3D drm_crtc_mask(crtc);
>   	ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);=

>   	if (ret) {
>   		drm_err(dev, "failed to init encoder: %d\n", ret);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--FCC3G2ml740cYgBEccaqi4gPePszz46aU--

--bseePHVaxwue1iMzXgJRiCtQnNMdi4Noi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/8Aw8FAwAAAAAACgkQlh/E3EQov+Dg
4hAAlW8K/tpzqYx1MsSm0po+RLjHFvRThVyxAJKXUshohEwgwz8lWfhur2Mzq1pGvdLSt4LKq3T0
oEJXt8FF4uErucQ+GzTkz/ud6Y0YGk9oQXIUiQq2J9h3z/m7Nil/mC6Rwqf47E7jQVaiK8pizVm/
ZXDXUgEmGlVtqX1wRin2oJzWgrtO73O1n/esT6O73mp7bDtRCJ8UWx57ywMDGgUxp+YIuuHM8ADR
4XOAzBjvX8D4KSWmdwDP0JWCWIYk/7NOSnLIDCmy4h6jtDYDFfajtJqz71fQS29BNVM90CrIzXwQ
yxr86Xs2TJ3StTtP3bwvzHK2XuJgVwKFmFix0EvbtiIv4Io4BlyZwQVsEb0Ilcwd0V0cPUF6JtvV
mOedGweXIFpA5yjb3EBiCWZBwkJez6gT+VPuQ2sHeh9/F6PmtZhDmHMW0MSD2FCOJ1SUmw/3GTGI
LJIMNU36J6HV5E9zeRtDYPR+A9Oa+WPKizUpY+BW8Nsk3NZLAKchhwF6/YqCECWMrF9qJ/AOdYLO
9WyHNFJ4YeC1s/7lCJdAHkoN6R+nonZ3DVj33TWHketw5TwgM3A+bqcLsmsoG58MG4ulJQJZ4pU8
IDp+AH6tHtx0xLgwQslJNMRaZyihNKI34SpRZAek/PXCnvyyA1ly68V/mfvhz6XWxRz5X9bvy09b
dGU=
=tCxd
-----END PGP SIGNATURE-----

--bseePHVaxwue1iMzXgJRiCtQnNMdi4Noi--
