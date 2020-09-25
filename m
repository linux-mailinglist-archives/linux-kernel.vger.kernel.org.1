Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2027810B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIYHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:02:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgIYHCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:02:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B20EAE0C;
        Fri, 25 Sep 2020 07:02:38 +0000 (UTC)
Subject: Re: [PATCH] drm/hisilicon: Deleted the drm_device declaration
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, kraxel@redhat.com, alexander.deucher@amd.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        xinliang.liu@linaro.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1601016580-5937-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5db712e8-d6cb-3de9-f48e-c2060442e4e0@suse.de>
Date:   Fri, 25 Sep 2020 09:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601016580-5937-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WJyAY9mgk22MS0izZdpsBgwmaRuY6OqcU"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJyAY9mgk22MS0izZdpsBgwmaRuY6OqcU
Content-Type: multipart/mixed; boundary="7HjCsCUqS7d21irtESSAsWMbj8NdCyHqv";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie, daniel@ffwll.ch,
 kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
 dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
 linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com
Message-ID: <5db712e8-d6cb-3de9-f48e-c2060442e4e0@suse.de>
Subject: Re: [PATCH] drm/hisilicon: Deleted the drm_device declaration
References: <1601016580-5937-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1601016580-5937-1-git-send-email-tiantao6@hisilicon.com>

--7HjCsCUqS7d21irtESSAsWMbj8NdCyHqv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

just a few nits.

Am 25.09.20 um 08:49 schrieb Tian Tao:
> drm_framebuffer.h contains drm/drm_device.h and struct drm_device is

contains -> includes

> already declared in this file, so there is no need to declare struct

declared -> defined

> drm_device in hibm_drm_drv.h.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 87d2aad..6a63502 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -22,8 +22,6 @@
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
> =20
> -struct drm_device;
> -
>  struct hibmc_connector {
>  	struct drm_connector base;
> =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--7HjCsCUqS7d21irtESSAsWMbj8NdCyHqv--

--WJyAY9mgk22MS0izZdpsBgwmaRuY6OqcU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl9tlgwUHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiMTsAf/bvEpfoZuwQbLKkxb4fEx2XKegFL0
2rE1UM32l7OZKsratrfcVi1PMdunPaciUqlgiq+SoSoqSxyfYOckhn2ZE6YiHgmd
FTA9PAZIgBT3ZJRjA3bFhVvZMBZ07xRQKwQt3HwORG4eNySa0DkGrygSA5SKmu/l
riDvo3IuqapPxoiaxsYbnf9SMnvTHoTZ9FCrQHjox+ypGLwyLjKbLtmezG/tKdtI
G7tYqXC39r6oMHzjoKU+ZGg1o5t3753jlZAewPp0HKkXukMQJshhOWWAYP7/9Zsd
nWAcnQ9XQN7fe17ziG0pknylRuFLfESo1hgMJxHvzArreOYqwEsBjV891A==
=PzKt
-----END PGP SIGNATURE-----

--WJyAY9mgk22MS0izZdpsBgwmaRuY6OqcU--
