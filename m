Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E812CBA72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgLBKV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:21:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgLBKV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:21:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCAC3ACC2;
        Wed,  2 Dec 2020 10:21:14 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon v2 2/3] drm/irq: Add the new api to install
 irq
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1606901212-8214-1-git-send-email-tiantao6@hisilicon.com>
 <1606901212-8214-3-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <35960a70-2a8b-0c65-363a-07a97e4a083d@suse.de>
Date:   Wed, 2 Dec 2020 11:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606901212-8214-3-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YqPrIC7qzYvV2KRrgnosYvntFvi3uTV7K"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YqPrIC7qzYvV2KRrgnosYvntFvi3uTV7K
Content-Type: multipart/mixed; boundary="9GodstmtASbiFkqeCjEQCqdvflcDgAAe1";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <35960a70-2a8b-0c65-363a-07a97e4a083d@suse.de>
Subject: Re: [PATCH drm/hisilicon v2 2/3] drm/irq: Add the new api to install
 irq
References: <1606901212-8214-1-git-send-email-tiantao6@hisilicon.com>
 <1606901212-8214-3-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1606901212-8214-3-git-send-email-tiantao6@hisilicon.com>

--9GodstmtASbiFkqeCjEQCqdvflcDgAAe1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 02.12.20 um 10:26 schrieb Tian Tao:
> Add new api devm_drm_irq_install() to register interrupts,
> no need to call drm_irq_uninstall() when the drm module is removed.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_irq.c | 32 ++++++++++++++++++++++++++++++++
>   include/drm/drm_irq.h     |  2 +-
>   2 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> index 09d6e9e..803af4b 100644
> --- a/drivers/gpu/drm/drm_irq.c
> +++ b/drivers/gpu/drm/drm_irq.c
> @@ -214,6 +214,38 @@ int drm_irq_uninstall(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_irq_uninstall);
>  =20
> +static void devm_drm_irq_uninstall(void *data)
> +{
> +	drm_irq_uninstall(data);
> +}
> +
> +/**
> + * devm_drm_irq_install - install IRQ handler
> + * @dev: DRM device
> + * @irq: IRQ number to install the handler for
> + *
> + * devm_drm_irq_install is a  help function of drm_irq_install.
> + *
> + * if the driver uses devm_drm_irq_install, there is no need
> + * to call drm_irq_uninstall when the drm module get unloaded,
> + * as this will done automagically.
> + *
> + * Returns:
> + * Zero on success or a negative error code on failure.
> + */
> +int devm_drm_irq_install(struct drm_device *dev, int irq)
> +{
> +	int ret;
> +
> +	ret =3D drm_irq_install(dev, irq);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev->dev,
> +					devm_drm_irq_uninstall, dev);
> +}
> +EXPORT_SYMBOL(devm_drm_irq_install);
> +
>   #if IS_ENABLED(CONFIG_DRM_LEGACY)
>   int drm_legacy_irq_control(struct drm_device *dev, void *data,
>   			   struct drm_file *file_priv)
> diff --git a/include/drm/drm_irq.h b/include/drm/drm_irq.h
> index d77f6e6..631b22f 100644
> --- a/include/drm/drm_irq.h
> +++ b/include/drm/drm_irq.h
> @@ -28,5 +28,5 @@ struct drm_device;
>  =20
>   int drm_irq_install(struct drm_device *dev, int irq);
>   int drm_irq_uninstall(struct drm_device *dev);
> -
> +int devm_drm_irq_install(struct drm_device *dev, int irq);
>   #endif
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--9GodstmtASbiFkqeCjEQCqdvflcDgAAe1--

--YqPrIC7qzYvV2KRrgnosYvntFvi3uTV7K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/HapkFAwAAAAAACgkQlh/E3EQov+CO
aBAAiDWlTUZnACdAdqcF17cstOEpnthqezMnwV5ktnsrzo5+gV1GGB0fqy6Ub5zuHSa2UKZiYB4y
udQ0wVeNBWT4Wv7VYzoPsYFO7qpJ3ps/GHXyBVR4482ZRGDbp80ECwZBDnLcJn6F+0jyNOFdzXaI
avTdNSp8ZGxKrUCgO8NL4uT2h/AF3HL6Na/WdJicr60MFd0hGAKGN0TkTOAwu+TR4uUrBUjSXzjH
tTfgZObmIxaSiEykTVoFpzqBcMHz2IyC3N9kCvXCGQY5LRhlFMkXYqWz+X+uHIcOJNbOaiGPEO+q
EJ6aEWRTk1zijPpUlH//RLfbhgFdsMHpBWN2DT8hOreho8Yu9eq7/QxYWu4iLxJ08PJ/vLCJ+PKi
v5ZyzIJOB/AhEK6lQCmHfYcI0oPCzDs700s4w0RoU9NTyGUYw5ZWX2EDQ4qJmnB6wOFDACb/M2bo
yCXKfAPjnBRDk5sW2ouVNysqGncFXJJHBN1mLEjFSbzuNAKjTRPmCBcZYcZpbOLVM+DW9acQjFn4
aD10y5sN6BR2n8Q8zNyWeR9+A4axoxE4gjPhl3ADPIrL2hAqcXVaLQQLU1tJfYH+L6FqBjUP5Exe
NYHS9BpBWF272mPHUyuOJIKPAx6eYQEA0yERmy5EcEbPbbZUl0+LsThPtIPoHjTmRSuYhPEdDsxa
Xt4=
=2NbS
-----END PGP SIGNATURE-----

--YqPrIC7qzYvV2KRrgnosYvntFvi3uTV7K--
