Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741F92154AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGFJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 05:24:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgGFJYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D39F8AAF1;
        Mon,  6 Jul 2020 09:23:59 +0000 (UTC)
Subject: Re: [PATCH v3] drm/hisilicon: Code refactoring for hibmc_drv_vdac
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1593680081-60313-1-git-send-email-tiantao6@hisilicon.com>
 <8aac2194-e122-e4bb-dbd1-e6530fc77427@suse.de>
Message-ID: <d8a0ca1d-0941-a640-2060-433073897eca@suse.de>
Date:   Mon, 6 Jul 2020 11:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8aac2194-e122-e4bb-dbd1-e6530fc77427@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="izG3D42C2jxKggzm9TaHG21QjGx4GJk7g"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--izG3D42C2jxKggzm9TaHG21QjGx4GJk7g
Content-Type: multipart/mixed; boundary="AtTw58yqFNxjIu71QxwyahvrsJAE6H1aL";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
 airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
 alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <d8a0ca1d-0941-a640-2060-433073897eca@suse.de>
Subject: Re: [PATCH v3] drm/hisilicon: Code refactoring for hibmc_drv_vdac
References: <1593680081-60313-1-git-send-email-tiantao6@hisilicon.com>
 <8aac2194-e122-e4bb-dbd1-e6530fc77427@suse.de>
In-Reply-To: <8aac2194-e122-e4bb-dbd1-e6530fc77427@suse.de>

--AtTw58yqFNxjIu71QxwyahvrsJAE6H1aL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 02.07.20 um 12:12 schrieb Thomas Zimmermann:
> Thanks!
>=20
> Am 02.07.20 um 10:54 schrieb Tian Tao:
>> code refactoring for hibmc_drv_vdac.c, no actual function changes.
>>
>> v2:
>> remove the debug message.
>>
>> v3:
>> embedding connector and encoder in struct hibmc_drm_private.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> Maybe others want to comment on the patch, so I'll give it a few more
> days before I add it to drm-misc-next. Don't hesitate to ping me if I
> forget about it.

I've added the patch to drm-misc-next

>=20
> Best regards
> Thomas
>=20
>> ---
>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
>>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 52 +++++----------=
---------
>>  2 files changed, 13 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index 50a0c1f..6097687 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -29,6 +29,8 @@ struct hibmc_drm_private {
>> =20
>>  	/* drm */
>>  	struct drm_device  *dev;
>> +	struct drm_encoder encoder;
>> +	struct drm_connector connector;
>>  	bool mode_config_initialized;
>>  };
>> =20
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/driver=
s/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 678ac2e..2ca69c3 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -52,32 +52,6 @@ static const struct drm_connector_funcs hibmc_conne=
ctor_funcs =3D {
>>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,=

>>  };
>> =20
>> -static struct drm_connector *
>> -hibmc_connector_init(struct hibmc_drm_private *priv)
>> -{
>> -	struct drm_device *dev =3D priv->dev;
>> -	struct drm_connector *connector;
>> -	int ret;
>> -
>> -	connector =3D devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL)=
;
>> -	if (!connector) {
>> -		DRM_ERROR("failed to alloc memory when init connector\n");
>> -		return ERR_PTR(-ENOMEM);
>> -	}
>> -
>> -	ret =3D drm_connector_init(dev, connector,
>> -				 &hibmc_connector_funcs,
>> -				 DRM_MODE_CONNECTOR_VGA);
>> -	if (ret) {
>> -		DRM_ERROR("failed to init connector: %d\n", ret);
>> -		return ERR_PTR(ret);
>> -	}
>> -	drm_connector_helper_add(connector,
>> -				 &hibmc_connector_helper_funcs);
>> -
>> -	return connector;
>> -}
>> -
>>  static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
>>  				   struct drm_display_mode *mode,
>>  				   struct drm_display_mode *adj_mode)
>> @@ -105,23 +79,10 @@ static const struct drm_encoder_funcs hibmc_encod=
er_funcs =3D {
>>  int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>  {
>>  	struct drm_device *dev =3D priv->dev;
>> -	struct drm_encoder *encoder;
>> -	struct drm_connector *connector;
>> +	struct drm_encoder *encoder =3D &priv->encoder;
>> +	struct drm_connector *connector =3D &priv->connector;
>>  	int ret;
>> =20
>> -	connector =3D hibmc_connector_init(priv);
>> -	if (IS_ERR(connector)) {
>> -		DRM_ERROR("failed to create connector: %ld\n",
>> -			  PTR_ERR(connector));
>> -		return PTR_ERR(connector);
>> -	}
>> -
>> -	encoder =3D devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>> -	if (!encoder) {
>> -		DRM_ERROR("failed to alloc memory when init encoder\n");
>> -		return -ENOMEM;
>> -	}
>> -
>>  	encoder->possible_crtcs =3D 0x1;
>>  	ret =3D drm_encoder_init(dev, encoder, &hibmc_encoder_funcs,
>>  			       DRM_MODE_ENCODER_DAC, NULL);
>> @@ -131,6 +92,15 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv=
)
>>  	}
>> =20
>>  	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
>> +
>> +	ret =3D drm_connector_init(dev, connector, &hibmc_connector_funcs,
>> +				 DRM_MODE_CONNECTOR_VGA);
>> +	if (ret) {
>> +		DRM_ERROR("failed to init connector: %d\n", ret);
>> +		return ret;
>> +	}
>> +	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
>> +
>>  	drm_connector_attach_encoder(connector, encoder);
>> =20
>>  	return 0;
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--AtTw58yqFNxjIu71QxwyahvrsJAE6H1aL--

--izG3D42C2jxKggzm9TaHG21QjGx4GJk7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl8C7a4UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiM0vQf+OlfARWLP0IaR9nwRnDefB4Q32Gu4
qlGrTq+sXsrKcUPPO488EfmKNGVxHz6AC4itqdJUNWFgupabeZF557SA5AkstBXj
khqzsLxIN5gqczxQPvIV8JTFj5B8r5QiNZpKcFclynMvh0FaDwWAjpMp2gkMuWgQ
XrR6lioiwBd/ag5Eza1v5X0wFFqG5HPPkLUOJGr4n/30oJEebYwaAsX2TDJK4XvW
7Ir6/s4mOTXn4JSCCBjYhkuKw0eMGVA/07wGuCce+Ah2o8V2seoqn1ZlmTIMvCG+
dkxy7J5DDS3IePRNLKdvgzr0T9DW94VOXSPoNFoiUxHuU+U2EjDxPbc6ew==
=155B
-----END PGP SIGNATURE-----

--izG3D42C2jxKggzm9TaHG21QjGx4GJk7g--
