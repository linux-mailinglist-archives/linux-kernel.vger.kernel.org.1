Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE412D0B73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLGIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:04:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgLGIE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:04:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD0C0AC9A;
        Mon,  7 Dec 2020 08:03:46 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 1/2] drm/hisilicon: Use managed mode-config
 init
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
 <1607302172-60123-2-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ba38ae20-a041-6918-331a-09cf796b92a3@suse.de>
Date:   Mon, 7 Dec 2020 09:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1607302172-60123-2-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="80odkjGCcbfPDE9qIJkqNNKY3rNHialNG"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--80odkjGCcbfPDE9qIJkqNNKY3rNHialNG
Content-Type: multipart/mixed; boundary="rSeKpMEG8NxEtli9NgiqrkACXqpsKmn3V";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Message-ID: <ba38ae20-a041-6918-331a-09cf796b92a3@suse.de>
Subject: Re: [PATCH drm/hisilicon 1/2] drm/hisilicon: Use managed mode-config
 init
References: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
 <1607302172-60123-2-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1607302172-60123-2-git-send-email-tiantao6@hisilicon.com>

--rSeKpMEG8NxEtli9NgiqrkACXqpsKmn3V
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.12.20 um 01:49 schrieb Tian Tao:
> Using drmm_mode_config_init() sets up managed release of modesetting
> resources.
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 3687753..d631f82 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -96,7 +96,9 @@ static int hibmc_kms_init(struct hibmc_drm_private *p=
riv)
>   	struct drm_device *dev =3D &priv->dev;
>   	int ret;
>  =20
> -	drm_mode_config_init(dev);
> +	ret =3D drmm_mode_config_init(dev);
> +	if (ret)
> +		return ret;
>   	priv->mode_config_initialized =3D true;

I think mode_config_initialized is only required by hibmc_kms_finit(),=20
which you remove. You should remove this line and the field from struct=20
hibmc_drm_private.

Best regards
Thomas

>  =20
>   	dev->mode_config.min_width =3D 0;
> @@ -125,14 +127,6 @@ static int hibmc_kms_init(struct hibmc_drm_private=
 *priv)
>   	return 0;
>   }
>  =20
> -static void hibmc_kms_fini(struct hibmc_drm_private *priv)
> -{
> -	if (priv->mode_config_initialized) {
> -		drm_mode_config_cleanup(&priv->dev);
> -		priv->mode_config_initialized =3D false;
> -	}
> -}
> -
>   /*
>    * It can operate in one of three modes: 0, 1 or Sleep.
>    */
> @@ -262,7 +256,6 @@ static int hibmc_unload(struct drm_device *dev)
>   	drm_atomic_helper_shutdown(dev);
>  =20
>   	pci_disable_msi(dev->pdev);
> -	hibmc_kms_fini(priv);
>   	dev->dev_private =3D NULL;
>   	return 0;
>   }
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--rSeKpMEG8NxEtli9NgiqrkACXqpsKmn3V--

--80odkjGCcbfPDE9qIJkqNNKY3rNHialNG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/N4eEFAwAAAAAACgkQlh/E3EQov+Ai
0Q//eqJuBrVY30X+MZYNToSYM6gaSCN3C4Oz0YvhkPTMWkmbsHJK5GNiFAV2jCr9+cIuLey7nhmG
Of/+KCKZWYQsSKuVVaPaIiEXPtFLB71tNRQgBq5NXgZczBBw5tEE0cWTosli2QcWyXgkGOgM3HsO
Jh8idx33Z1sl8yKL5pBNZyik0t/1CBGcMqP9+pdRFKFVaUAxXViPj4hSeqCLce22svDxIUhGlfr5
nB9839dYMdOP0XNSnIruHFPuTBdCdxbwqk83lEVWaWZKJqTpLSHV7it7qNxQIYSgBpZgu6OFx/im
eMc7aF2OTkP8e1ze+fKz/dDZp3ag4Dy4rbgrLlLSGQnh8nhwJjJdCPyfbkGF4tizEqaPelIMUfag
cfsWGjOFxnWxlNwn3SX+anxwvRf/XmaCdrSu0tpDxoRtP5rofnlJwBlZ7vf4xt3iHjn7y4BY72MA
yfKrtJG5THxGdqOJ6C34C+vSH6XJBqAPvWa1JKzOzg7hCARvHoqs45bZGtJLvpkE1YP89lsbUH/9
4P8IjzIRj/RAJTzCEfeNI7dtdKtHaD8/95b7V5RVkoWLOJG9eV/o4VAZxRvX8R2SYw4rz6pol3C1
15ibP4Tj6KPzBdz+uUwpC0raGOzsRpSrcEsb+pKhFNRDxZb/jeSW6hcShPTBFKjHk7nbP2JsZP9w
ZmI=
=SSDP
-----END PGP SIGNATURE-----

--80odkjGCcbfPDE9qIJkqNNKY3rNHialNG--
