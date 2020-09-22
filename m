Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E9273BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgIVHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:20:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgIVHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:20:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EF17ACD5;
        Tue, 22 Sep 2020 07:20:43 +0000 (UTC)
Subject: Re: [PATCH drm/hisilicon v2 2/2] drm/hisilicon: Features to support
 reading resolutions from EDID
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1600758230-13389-1-git-send-email-tiantao6@hisilicon.com>
 <1600758230-13389-3-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <d131f54d-a237-b965-5805-42dd124c0c52@suse.de>
Date:   Tue, 22 Sep 2020 09:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600758230-13389-3-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qcM0yluvcKlYflO6Y78Os1bpRhFqmDWsk"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qcM0yluvcKlYflO6Y78Os1bpRhFqmDWsk
Content-Type: multipart/mixed; boundary="vTr4qUSbo1lZAfAmS3BeajPKCTtMw6QZI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <d131f54d-a237-b965-5805-42dd124c0c52@suse.de>
Subject: Re: [PATCH drm/hisilicon v2 2/2] drm/hisilicon: Features to support
 reading resolutions from EDID
References: <1600758230-13389-1-git-send-email-tiantao6@hisilicon.com>
 <1600758230-13389-3-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600758230-13389-3-git-send-email-tiantao6@hisilicon.com>

--vTr4qUSbo1lZAfAmS3BeajPKCTtMw6QZI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 22.09.20 um 09:03 schrieb Tian Tao:
> Use drm_get_edid to get the resolution, if that fails, set it to
> a fixed resolution. Rewrite the desrtoy callback function to release
> resources.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 38 ++++++++++++++++=
+++++---
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 376a05d..c6999ed 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -21,12 +21,24 @@
>  static int hibmc_connector_get_modes(struct drm_connector *connector)
>  {
>  	int count;
> +	void *edid;
> +	struct hibmc_connector *hibmc_connector =3D to_hibmc_connector(connec=
tor);
> +
> +	edid =3D drm_get_edid(connector, &hibmc_connector->adapter);
> +	if (edid) {
> +		drm_connector_update_edid_property(connector, edid);
> +		count =3D drm_add_edid_modes(connector, edid);
> +		if (count)
> +			goto out;
> +	}
> =20
>  	count =3D drm_add_modes_noedid(connector,
>  				     connector->dev->mode_config.max_width,
>  				     connector->dev->mode_config.max_height);
>  	drm_set_preferred_mode(connector, 1024, 768);
> =20
> +out:
> +	kfree(edid);
>  	return count;
>  }
> =20
> @@ -36,6 +48,14 @@ static enum drm_mode_status hibmc_connector_mode_val=
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
> @@ -44,7 +64,7 @@ static const struct drm_connector_helper_funcs
> =20
>  static const struct drm_connector_funcs hibmc_connector_funcs =3D {
>  	.fill_modes =3D drm_helper_probe_single_connector_modes,
> -	.destroy =3D drm_connector_cleanup,
> +	.destroy =3D hibmc_connector_destroy,
>  	.reset =3D drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_sta=
te,
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
> @@ -77,10 +97,17 @@ static const struct drm_encoder_funcs hibmc_encoder=
_funcs =3D {
>  int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  {
>  	struct drm_device *dev =3D priv->dev;
> +	struct hibmc_connector *hibmc_connector =3D &priv->connector;
>  	struct drm_encoder *encoder =3D &priv->encoder;
> -	struct drm_connector *connector =3D &priv->connector;
> +	struct drm_connector *connector =3D &hibmc_connector->base;
>  	int ret;
> =20
> +	ret =3D hibmc_ddc_create(dev, hibmc_connector);
> +	if (ret) {
> +		drm_err(dev, "failed to create ddc: %d\n", ret);
> +		return ret;
> +	}
> +
>  	encoder->possible_crtcs =3D 0x1;
>  	ret =3D drm_encoder_init(dev, encoder, &hibmc_encoder_funcs,
>  			       DRM_MODE_ENCODER_DAC, NULL);
> @@ -91,12 +118,15 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv=
)
> =20
>  	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
> =20
> -	ret =3D drm_connector_init(dev, connector, &hibmc_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VGA);
> +	ret =3D drm_connector_init_with_ddc(dev, connector,
> +					  &hibmc_connector_funcs,
> +					  DRM_MODE_CONNECTOR_VGA,
> +					  &hibmc_connector->adapter);
>  	if (ret) {
>  		drm_err(dev, "failed to init connector: %d\n", ret);
>  		return ret;
>  	}
> +
>  	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
> =20
>  	drm_connector_attach_encoder(connector, encoder);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--vTr4qUSbo1lZAfAmS3BeajPKCTtMw6QZI--

--qcM0yluvcKlYflO6Y78Os1bpRhFqmDWsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9ppaYUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiOX1gf8CCF68v9CYLr34WWyMX6JIG4t4Ytt
BfVUZIFNaVgnK1B3MTV1mq5T0fldPbDG2aqeVkdj3r+iSPd4zLcXaDYQgaLch65Y
nNYzJ6WfhNXaIGp6dwz9A6KiI8dtUL7DZMbYeWjIKkyPV/tUTjA4TOAfgn3Q3AmF
lfYN+7jNjvCif6BLk2YCqeVBdfoP7PRh+NVGKAkzHFYoc2+FxfUqzMUXp/C9Hsg6
HKzT9O1IOyhobe1KXM+pyq4GJ9SSxJA3DHWk/8uJ6bPmQ3j/ZOjrpAUMxgjoAYOH
4HJ31lkiDV8mp0srngmkN8jR/HwQKH/EHDPbQcOiLHWfYPfLWUwYq1CSvA==
=5c6L
-----END PGP SIGNATURE-----

--qcM0yluvcKlYflO6Y78Os1bpRhFqmDWsk--
