Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C42CD2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgLCJkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:40:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:46142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbgLCJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA0C5AC55;
        Thu,  3 Dec 2020 09:39:59 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Deletted the entire file hibmc_ttm.c
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
References: <1606986347-54007-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <4ce462b2-cd48-0e80-0c09-15f0d42f9c55@suse.de>
Date:   Thu, 3 Dec 2020 10:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606986347-54007-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t4Qn74Rwal5QuoY0zMtUs386QKrdEaNfI"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t4Qn74Rwal5QuoY0zMtUs386QKrdEaNfI
Content-Type: multipart/mixed; boundary="xWYLecE0OUB0aM4nVXbFiASUR1YBykoHS";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Message-ID: <4ce462b2-cd48-0e80-0c09-15f0d42f9c55@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Deletted the entire file hibmc_ttm.c
References: <1606986347-54007-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1606986347-54007-1-git-send-email-tiantao6@hisilicon.com>

--xWYLecE0OUB0aM4nVXbFiASUR1YBykoHS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 03.12.20 um 10:05 schrieb Tian Tao:
> Deletted the entire file hibmc_ttm.c. drmm_vram_helper_init() can be

Deletted -> Delete

Here and in the subject line.

> called directly from hibmc_load(). hibmc_dumb_create() and
> hibmc_mode_funcs can go to hibmc_drm_drv.c
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Code changes look good.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/hisilicon/hibmc/Makefile        |  2 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 21 ++++++++++-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  4 --
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     | 50 ----------------=
---------
>   4 files changed, 20 insertions(+), 57 deletions(-)
>   delete mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm=
/hisilicon/hibmc/Makefile
> index 684ef79..d25c75e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -hibmc-drm-y :=3D hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc=
_ttm.o hibmc_drm_i2c.o
> +hibmc-drm-y :=3D hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc=
_drm_i2c.o
>  =20
>   obj-$(CONFIG_DRM_HISI_HIBMC) +=3D hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 5aea2e9..3687753 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -16,6 +16,7 @@
>  =20
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_gem_vram_helper.h>
>   #include <drm/drm_irq.h>
>   #include <drm/drm_managed.h>
> @@ -43,6 +44,12 @@ static irqreturn_t hibmc_drm_interrupt(int irq, void=
 *arg)
>   	return IRQ_HANDLED;
>   }
>  =20
> +static int hibmc_dumb_create(struct drm_file *file, struct drm_device =
*dev,
> +			     struct drm_mode_create_dumb *args)
> +{
> +	return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
> +}
> +
>   static const struct drm_driver hibmc_driver =3D {
>   	.driver_features	=3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>   	.fops			=3D &hibmc_fops,
> @@ -77,6 +84,13 @@ static const struct dev_pm_ops hibmc_pm_ops =3D {
>   				hibmc_pm_resume)
>   };
>  =20
> +static const struct drm_mode_config_funcs hibmc_mode_funcs =3D {
> +	.mode_valid =3D drm_vram_helper_mode_valid,
> +	.atomic_check =3D drm_atomic_helper_check,
> +	.atomic_commit =3D drm_atomic_helper_commit,
> +	.fb_create =3D drm_gem_fb_create,
> +};
> +
>   static int hibmc_kms_init(struct hibmc_drm_private *priv)
>   {
>   	struct drm_device *dev =3D &priv->dev;
> @@ -262,9 +276,12 @@ static int hibmc_load(struct drm_device *dev)
>   	if (ret)
>   		goto err;
>  =20
> -	ret =3D hibmc_mm_init(priv);
> -	if (ret)
> +	ret =3D drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, 0),
> +				    priv->fb_size);
> +	if (ret) {
> +		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
>   		goto err;
> +	}
>  =20
>   	ret =3D hibmc_kms_init(priv);
>   	if (ret)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 2786de5..a49c10e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -64,10 +64,6 @@ int hibmc_de_init(struct hibmc_drm_private *priv);
>   int hibmc_vdac_init(struct hibmc_drm_private *priv);
>  =20
>   int hibmc_mm_init(struct hibmc_drm_private *hibmc);
> -int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
> -		      struct drm_mode_create_dumb *args);
>   int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connect=
or *connector);
>  =20
> -extern const struct drm_mode_config_funcs hibmc_mode_funcs;
> -
>   #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/=
drm/hisilicon/hibmc/hibmc_ttm.c
> deleted file mode 100644
> index 892d566..0000000
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/* Hisilicon Hibmc SoC drm driver
> - *
> - * Based on the bochs drm driver.
> - *
> - * Copyright (c) 2016 Huawei Limited.
> - *
> - * Author:
> - *	Rongrong Zou <zourongrong@huawei.com>
> - *	Rongrong Zou <zourongrong@gmail.com>
> - *	Jianhua Li <lijianhua@huawei.com>
> - */
> -
> -#include <linux/pci.h>
> -
> -#include <drm/drm_atomic_helper.h>
> -#include <drm/drm_gem.h>
> -#include <drm/drm_gem_framebuffer_helper.h>
> -#include <drm/drm_gem_vram_helper.h>
> -#include <drm/drm_print.h>
> -
> -#include "hibmc_drm_drv.h"
> -
> -int hibmc_mm_init(struct hibmc_drm_private *hibmc)
> -{
> -	int ret;
> -	struct drm_device *dev =3D &hibmc->dev;
> -
> -	ret =3D drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, 0),
> -				    hibmc->fb_size);
> -	if (ret) {
> -		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
> -		      struct drm_mode_create_dumb *args)
> -{
> -	return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
> -}
> -
> -const struct drm_mode_config_funcs hibmc_mode_funcs =3D {
> -	.mode_valid =3D drm_vram_helper_mode_valid,
> -	.atomic_check =3D drm_atomic_helper_check,
> -	.atomic_commit =3D drm_atomic_helper_commit,
> -	.fb_create =3D drm_gem_fb_create,
> -};
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--xWYLecE0OUB0aM4nVXbFiASUR1YBykoHS--

--t4Qn74Rwal5QuoY0zMtUs386QKrdEaNfI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/Ism4FAwAAAAAACgkQlh/E3EQov+AC
fhAAhFjNclNFVa882U241bIruWM91XLLR0nwZXFFdwCmojGySOuigMMaAmkfSKcIk2YMkb9zm0No
HYc5PL6S+jBPuAkdVExOAR4apOPxjlpovK7vlKLkm3SZR8dBH0Kt/S1GQGZB5oPR5e094qwPJg9p
dBr6zvjkEaACEteyA+tDfVptcaOftYg/nICND3RLNKtrAhcb/wmCGFgD5luNZ/YqCU5kZ8z59ma1
D3gLHCCyXtNnOpw+SE2jZravk6CPGpdNKS3oG2Q0j3o9nNLm8QdP8eLU9kzOTy3W+tEZGKLngbcl
xzUNITp+IHCsm07ZQ+P+mdTPzzXwtD+SuuXFjUEOVyk8Qv501o2GK8n+/JVyBAyw2Igvn5mMbkit
apQUcnPXx7oZsm9K8MIi1Rfsd/ScDCjcGKv6rgcwXl7LyL1SO7m5OLuZtH9ucXfE5N9UL2noHGbJ
Np1YNfv46apcXpXsLSbn4/6pNPXQ8UsSSAXZqw4HLhJjJqYNv7lQj/sduNsvjhcPls1CERMvnzt2
GieXNmFFHlXiF3VtFtVjMD8eWUgrtbO9dVxyzWgxGM+t5FkmBGc5qDt+Ep4bHhUbeyMJkaLkoFHW
/EwFxhuro/w9ZDE94zvZiBT1hZn2by03iyUZXAPNvXPfpVpW01PCn9AFUECiqQYxLuJS/0pMLqlu
YE4=
=Cizf
-----END PGP SIGNATURE-----

--t4Qn74Rwal5QuoY0zMtUs386QKrdEaNfI--
