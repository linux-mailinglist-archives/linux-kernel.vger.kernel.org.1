Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69C2D0B76
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLGIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:04:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:56486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLGIEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:04:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECF37ACBD;
        Mon,  7 Dec 2020 08:04:13 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 2/2] drm/hisilicon: Delete unused local
 parameters
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
 <1607302172-60123-3-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <e08b33ab-f4b3-f23a-d5f7-56b4795875be@suse.de>
Date:   Mon, 7 Dec 2020 09:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1607302172-60123-3-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yTNrphBMLVt6EJudUhi1Cup7kx05pUiyF"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yTNrphBMLVt6EJudUhi1Cup7kx05pUiyF
Content-Type: multipart/mixed; boundary="AlD5cEhkJHuE5wznxlep4bgJ6blT1LVnz";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Message-ID: <e08b33ab-f4b3-f23a-d5f7-56b4795875be@suse.de>
Subject: Re: [PATCH drm/hisilicon 2/2] drm/hisilicon: Delete unused local
 parameters
References: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
 <1607302172-60123-3-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1607302172-60123-3-git-send-email-tiantao6@hisilicon.com>

--AlD5cEhkJHuE5wznxlep4bgJ6blT1LVnz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.12.20 um 01:49 schrieb Tian Tao:
> delete unused variable =E2=80=98priv=E2=80=99 to avoid warning.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index d631f82..772f58e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -251,12 +251,9 @@ static int hibmc_hw_init(struct hibmc_drm_private =
*priv)
>  =20
>   static int hibmc_unload(struct drm_device *dev)
>   {
> -	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> -
>   	drm_atomic_helper_shutdown(dev);
> -
>   	pci_disable_msi(dev->pdev);
> -	dev->dev_private =3D NULL;
> +
>   	return 0;
>   }
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--AlD5cEhkJHuE5wznxlep4bgJ6blT1LVnz--

--yTNrphBMLVt6EJudUhi1Cup7kx05pUiyF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/N4fwFAwAAAAAACgkQlh/E3EQov+Bk
ChAAzduUeYznzDwFqCNKeNR/zP2i4eHWBqLUXWD2PnbrrUoIwXgF+CQv30YE7AIlrGCFp9CcNAFW
68X9YjlkFmSRqelFHueSmimbGDd+NKVf9TaK0jAe2aLzh15butOcEsEnMkPZY3HAwM3PmRICHTIP
KuENgEQEESi8dABHdBl38QRz4ZAU/91EJHlaw/hLJTFAKpO6qyk68Ot82ypWku2s9OJGX6v13oW+
3+8RwrL3+rLCeax1YG+0KBovzdxhAZhAfBoOL6UQsExOs1migHfdNQ7+9q9vbMmOwntYuE73iCUE
bCZuKoFLlvU8tOaQZJyQ5mDAnamR+7hTia1Gya+ImMFZ/7fQTO9tYC623P7RfHKvbyD+xI1TBsSJ
KYR7srlm5a+kuCKb63F1PQX8cZ4h+JWMQX/wDy832Tbo8bbHl7AMJYjyzYIgMCQSOgKITt9v9yNi
vOEv0opv9rwYmqjFTMzpUUxm3qvLVAGkMS5nJUWFhS8N+QirLdn/OxMsAcUDEEH8SPt5hj4JdiSt
FHvvCtIK8kwT6Jol8VCFr/Qq5OIicAndyXkUeaD5B1dCscX3i6U6v59LJMplIONjP9J3fbycSs7k
CfvCWrC6QPpnsypKaBH1DzAW1sMbzH6a6+nPqbJtnwMzmWqlR9CkFOxlMq3+KeG0Q3IG7ovE4sOH
mNQ=
=xEsE
-----END PGP SIGNATURE-----

--yTNrphBMLVt6EJudUhi1Cup7kx05pUiyF--
