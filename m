Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614FB271B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIUHUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:47768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgIUHUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AB90ABB2;
        Mon, 21 Sep 2020 07:21:12 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon 1/3] drm/hisilicon: Support i2c driver
 algorithms for bit-shift adapters
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
 <1600658722-35945-2-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <cb55c4bb-95fe-3261-af09-669f89269d5b@suse.de>
Date:   Mon, 21 Sep 2020 09:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600658722-35945-2-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RQ10Zw4LXd14XkmpsMGMrrqxGTFCCDtHJ"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RQ10Zw4LXd14XkmpsMGMrrqxGTFCCDtHJ
Content-Type: multipart/mixed; boundary="MgVwYxxJ7sALsdRpUPgcIRGv8aiaRbR9z";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <cb55c4bb-95fe-3261-af09-669f89269d5b@suse.de>
Subject: Re: [PATCH drm/hisilicon 1/3] drm/hisilicon: Support i2c driver
 algorithms for bit-shift adapters
References: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
 <1600658722-35945-2-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600658722-35945-2-git-send-email-tiantao6@hisilicon.com>

--MgVwYxxJ7sALsdRpUPgcIRGv8aiaRbR9z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 21.09.20 um 05:25 schrieb Tian Tao:
> Adding driver implementation to support i2c driver algorithms for
> bit-shift adapters, so hibmc will using the interface provided by
> drm to read edid.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile        |  2 +-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 21 +++++-
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c | 98 +++++++++++++++++=
++++++++
>  3 files changed, 119 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm=
/hisilicon/hibmc/Makefile
> index f991327..684ef79 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -hibmc-drm-y :=3D hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc=
_ttm.o
> +hibmc-drm-y :=3D hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc=
_ttm.o hibmc_drm_i2c.o
> =20
>  obj-$(CONFIG_DRM_HISI_HIBMC) +=3D hibmc-drm.o
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 197485e..1b2edb3 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -14,11 +14,24 @@
>  #ifndef HIBMC_DRM_DRV_H
>  #define HIBMC_DRM_DRV_H
> =20
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/i2c.h>
> +
> +#include <drm/drm_edid.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
> =20
>  struct drm_device;
> =20
> +struct hibmc_connector {
> +	struct drm_connector base;
> +	struct drm_device  *dev;

dev is not required. There's already a dev field under base.

> +
> +	struct i2c_adapter adapter;
> +	struct i2c_algo_bit_data bit_data;
> +};
> +
>  struct hibmc_drm_private {
>  	/* hw */
>  	void __iomem   *mmio;
> @@ -31,10 +44,15 @@ struct hibmc_drm_private {
>  	struct drm_plane primary_plane;
>  	struct drm_crtc crtc;
>  	struct drm_encoder encoder;
> -	struct drm_connector connector;
> +	struct hibmc_connector connector;
>  	bool mode_config_initialized;
>  };
> =20
> +static inline struct hibmc_connector *to_hibmc_connector(struct drm_co=
nnector *connector)
> +{
> +	return container_of(connector, struct hibmc_connector, base);
> +}
> +
>  void hibmc_set_power_mode(struct hibmc_drm_private *priv,
>  			  unsigned int power_mode);
>  void hibmc_set_current_gate(struct hibmc_drm_private *priv,
> @@ -47,6 +65,7 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc);
>  void hibmc_mm_fini(struct hibmc_drm_private *hibmc);
>  int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>  		      struct drm_mode_create_dumb *args);
> +int hibmc_ddc_create(struct hibmc_connector *connector);
> =20
>  extern const struct drm_mode_config_funcs hibmc_mode_funcs;
> =20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> new file mode 100644
> index 0000000..0506846
> --- /dev/null
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Hisilicon Hibmc SoC drm driver
> + *
> + * Based on the bochs drm driver.
> + *
> + * Copyright (c) 2016 Huawei Limited.
> + *
> + * Author:
> + *      Tian Tao <tiantao6@hisilicon.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "hibmc_drm_drv.h"
> +
> +#define GPIO_DATA		0x0802A0
> +#define GPIO_DATA_DIRECTION	0x0802A4
> +
> +#define GPIO_SCL_MASK 0x1
> +#define GPIO_SDA_MASK  0x2

Weird indention.

> +
> +static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
> +{
> +	struct hibmc_connector *hibmc_connector =3D data;
> +	struct hibmc_drm_private *priv =3D hibmc_connector->dev->dev_private;=


Oh, hibmc is still using dev_private. dev_private is on it's way out.

The least thing to do is to make little function that wraps the
conversion from struct drm_device to hibmc_drm_private. And then convert
over all uses of dev_private over to the function. That's for another
patchset.


That's all just nits, so

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

> +	u32 tmp_dir =3D readl(priv->mmio + GPIO_DATA_DIRECTION);
> +
> +	if (value) {
> +		tmp_dir &=3D ~mask;
> +		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
> +	} else {
> +		u32 tmp_data =3D readl(priv->mmio + GPIO_DATA);
> +
> +		tmp_data &=3D ~mask;
> +		writel(tmp_data, priv->mmio + GPIO_DATA);
> +
> +		tmp_dir |=3D mask;
> +		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
> +	}
> +}
> +
> +static int hibmc_get_i2c_signal(void *data, u32 mask)
> +{
> +	struct hibmc_connector *hibmc_connector =3D data;
> +	struct hibmc_drm_private *priv =3D hibmc_connector->dev->dev_private;=

> +	u32 tmp_dir =3D readl(priv->mmio + GPIO_DATA_DIRECTION);
> +
> +	if ((tmp_dir & mask) !=3D mask) {
> +		tmp_dir &=3D ~mask;
> +		writel(tmp_dir, priv->mmio + GPIO_DATA_DIRECTION);
> +	}
> +
> +	return (readl(priv->mmio + GPIO_DATA) & mask) ? 1 : 0;
> +}
> +
> +static void hibmc_ddc_setsda(void *data, int state)
> +{
> +	hibmc_set_i2c_signal(data, GPIO_SDA_MASK, state);
> +}
> +
> +static void hibmc_ddc_setscl(void *data, int state)
> +{
> +	hibmc_set_i2c_signal(data, GPIO_SCL_MASK, state);
> +}
> +
> +static int hibmc_ddc_getsda(void *data)
> +{
> +	return hibmc_get_i2c_signal(data, GPIO_SDA_MASK);
> +}
> +
> +static int hibmc_ddc_getscl(void *data)
> +{
> +	return hibmc_get_i2c_signal(data, GPIO_SCL_MASK);
> +}
> +
> +int hibmc_ddc_create(struct hibmc_connector *connector)
> +{
> +	connector->adapter.owner =3D THIS_MODULE;
> +	connector->adapter.class =3D I2C_CLASS_DDC;
> +	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
> +	connector->adapter.dev.parent =3D &connector->dev->pdev->dev;
> +	i2c_set_adapdata(&connector->adapter, connector);
> +	connector->adapter.algo_data =3D &connector->bit_data;
> +
> +	connector->bit_data.udelay =3D 20;
> +	connector->bit_data.timeout =3D usecs_to_jiffies(2000);
> +	connector->bit_data.data =3D connector;
> +	connector->bit_data.setsda =3D hibmc_ddc_setsda;
> +	connector->bit_data.setscl =3D hibmc_ddc_setscl;
> +	connector->bit_data.getsda =3D hibmc_ddc_getsda;
> +	connector->bit_data.getscl =3D hibmc_ddc_getscl;
> +
> +	return i2c_bit_add_bus(&connector->adapter);
> +}
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--MgVwYxxJ7sALsdRpUPgcIRGv8aiaRbR9z--

--RQ10Zw4LXd14XkmpsMGMrrqxGTFCCDtHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9oVEMUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiO8OAf9G4Cy2uNGZz+dTfontnXbg0gcRxjW
Z/A6kYMPYlWGQCffZDE/6x6ZEcKnbkeipYlYVxKnyHJWF39OfSn2nOUrHrdtl2Bp
VwRlobP8ssydMRo0ud2s9djGHwk3HHy2oNbkn3sMD4jZLhgSztIt/ccJ/phaI5MH
NI5hCvhFjMY/Gpb74I4JTrifjkltEoTUbI+U+WJeVfqoRfNt0h+ymi9NEc7uiVvS
MVDesXtUN7IQd/7lap/rKeJCXPKZrOM+zhZzvwTntBtsFpPe64mMpRAseBbQRcre
l77LPsW9O11m9aWLewfCn+37mGacHX8jBurN3d6a2GrDrPjAMmzOgAT7eg==
=A7eb
-----END PGP SIGNATURE-----

--RQ10Zw4LXd14XkmpsMGMrrqxGTFCCDtHJ--
