Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D82F9A34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbhARGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:33818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732707AbhARGyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:54:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91C2EAB9F;
        Mon, 18 Jan 2021 06:53:25 +0000 (UTC)
Subject: Re: [PATCH v3] drm: Improve the output_poll_changed description
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210118012246.1858892-1-zhangzhijie@loongson.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <fd296f78-86df-e933-78ff-4b66e978e730@suse.de>
Date:   Mon, 18 Jan 2021 07:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118012246.1858892-1-zhangzhijie@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VhyL3vz8qEWHObnNTNEQOeR0bQOY7EDIx"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VhyL3vz8qEWHObnNTNEQOeR0bQOY7EDIx
Content-Type: multipart/mixed; boundary="gC1mIDEOXuwC1y06MslxwJmA7j93gysPF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: "ZhiJie.Zhang" <zhangzhijie@loongson.cn>, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <fd296f78-86df-e933-78ff-4b66e978e730@suse.de>
Subject: Re: [PATCH v3] drm: Improve the output_poll_changed description
References: <20210118012246.1858892-1-zhangzhijie@loongson.cn>
In-Reply-To: <20210118012246.1858892-1-zhangzhijie@loongson.cn>

--gC1mIDEOXuwC1y06MslxwJmA7j93gysPF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.01.21 um 02:22 schrieb ZhiJie.Zhang:
> From: zhangzhijie <zhangzhijie@loongson.cn>
>=20
> this callback was used by drm_kms_helper_hotplug_event()
>=20
> V2: (Thanks for Daniel's suggestions)
> - remove the FIXME below.since with the drm_client
> - infrastructure and the generic fbdev emulation we've
> - resolved this all very neatly now.
>=20
> V3: Add comments that This hook is deprecated
> - new implementation methods instead of this hook
>=20
> Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
> ---
>   include/drm/drm_mode_config.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_confi=
g.h
> index ab424ddd7665..a084482d579a 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -103,14 +103,14 @@ struct drm_mode_config_funcs {
>   	 * Callback used by helpers to inform the driver of output configura=
tion
>   	 * changes.
>   	 *
> -	 * Drivers implementing fbdev emulation with the helpers can call
> -	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
> +	 * Drivers implementing fbdev emulation with the helpers. Drivers use=

> +	 * drm_kms_helper_hotplug_event() to call this hook to inform the fbd=
ev

I don't understand this. Maybe it's "Drivers implementing fbdev=20
emulation use drm_kms_helper_hotplug_event() to call ..." ?

Best regards
Thomas

>   	 * helper of output changes.
>   	 *
> -	 * FIXME:
> -	 *
> -	 * Except that there's no vtable for device-level helper callbacks
> -	 * there's no reason this is a core function.
> +	 * This hook is deprecated, drivers should instead use
> +	 * drm_fbdev_generic_setup() which takes care of any necessary
> +	 * hotplug event forwarding already without further involvement by
> +	 * the driver.
>   	 */
>   	void (*output_poll_changed)(struct drm_device *dev);
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--gC1mIDEOXuwC1y06MslxwJmA7j93gysPF--

--VhyL3vz8qEWHObnNTNEQOeR0bQOY7EDIx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAFMGQFAwAAAAAACgkQlh/E3EQov+DY
+hAAxI3avw1CTIm/TYGmuQq2i8BxkCSXQaU+ESTgzWKBv5pgUaNki9euaxatiKE3aURKyasj7U6l
ycMFd8yxL2V5mKOloV8ZyfCAKf2egExVrFQN92lt68FdmbQl9x+JTgHZP7dsavzDmHfuKZBGLvGs
bEKu+YqfFBGXzsBdAOzjQ9SaY8xF5OM5VsUztNeDDP/yz9QWPMRctLJNgSjfsC/8+Vwna6lZQSCS
fKYhEDV72Se6M6N7ZxtRAcn42GrCE59xcUJcCon1sCiWzlWcswva22PxuR6a27gECJk8b/CbC4Px
XlqJj19qI+HWRDYQz0fyL+Lhzhu02cbl2nN0k5Vp3FNUQLMAYmQiOmGy8S9wsHovQlWlfRa8KoZD
Qnwkam/pgde76zVQ2BL5VemoOxqkYF/1jqxH0y2auovtX92eeehemLBWezpTIESWWFJkAFGVK2qk
ysgWA7yxaHbnsJSOcx5RZnFZY8iZPvqdZDuavP/9EfaGCJsPb1wc6dlYLeIMZFSWQtuvpaZdv5JK
CbCHnDhmmhKiVFZX6fVbJ6vQs3Ss7eR4sFzuv7TQxE7a7VbS/PTLJqyAzogIWK0RFEzZsy2kKDA/
zuBbS0DrKuAYUxOOVPj5lUgaxYWaAxUkNmL7jDpTC5beoPYrJfjPVmuvzacXsVOKTVu3HyMiPrwI
ZqU=
=yTWw
-----END PGP SIGNATURE-----

--VhyL3vz8qEWHObnNTNEQOeR0bQOY7EDIx--
