Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E12FFDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbhAVIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:14:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:49838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbhAVIO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:14:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F202ABD6;
        Fri, 22 Jan 2021 08:13:43 +0000 (UTC)
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-3-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 2/4] drm/qxl: unpin release objects
Message-ID: <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de>
Date:   Fri, 22 Jan 2021 09:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120111240.2509679-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8lDQ2R8nzpd2PKtDZloK0uSHN2Cl2aRVD"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8lDQ2R8nzpd2PKtDZloK0uSHN2Cl2aRVD
Content-Type: multipart/mixed; boundary="DkAhTomUwaEiij7TgXImvKEG8i01RUXo9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
Message-ID: <a4187459-1dbd-e799-fba4-bf7021de831b@suse.de>
Subject: Re: [PATCH v3 2/4] drm/qxl: unpin release objects
References: <20210120111240.2509679-1-kraxel@redhat.com>
 <20210120111240.2509679-3-kraxel@redhat.com>
In-Reply-To: <20210120111240.2509679-3-kraxel@redhat.com>

--DkAhTomUwaEiij7TgXImvKEG8i01RUXo9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 20.01.21 um 12:12 schrieb Gerd Hoffmann:
> Balances the qxl_create_bo(..., pinned=3Dtrue, ...);
> call in qxl_release_bo_alloc().
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 0fcfc952d5e9..add979cba11b 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -166,6 +166,7 @@ qxl_release_free_list(struct qxl_release *release)
>   		entry =3D container_of(release->bos.next,
>   				     struct qxl_bo_list, tv.head);
>   		bo =3D to_qxl_bo(entry->tv.bo);
> +		bo->tbo.pin_count =3D 0; /* ttm_bo_unpin(&bo->tbo); */

This code looks like a workaround or a bug.

AFAICT the only place with pre-pinned BO is qdev->dumb_shadow_bo. Can=20
you remove the pinned flag entirely and handle pinning as part of=20
dumb_shadow_bo's code.

Otherwise maybe use

if (pin_count)
     ttm_bo_unpin();
WARN_ON(pin_count); /* should always be 0 now */

with a comment similar to the commit's description.

Best regards
Thomas

>   		qxl_bo_unref(&bo);
>   		list_del(&entry->tv.head);
>   		kfree(entry);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--DkAhTomUwaEiij7TgXImvKEG8i01RUXo9--

--8lDQ2R8nzpd2PKtDZloK0uSHN2Cl2aRVD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAKiTYFAwAAAAAACgkQlh/E3EQov+Db
ng/+IKIfMqKZFPcMiJWzE+ihESlVvBqmriFdyTyOZk/0lwMLZ+p9oS2KQ+Z/cSh4LMzdCYbcECAH
JXE+20bCFPgoNnE6Fsfh53gVKB1xe950iw/q/88trV8XS3ow2mPRyu63zl6q4UEibuaFDmnDNV85
M/3pD9NW75VVsenIRemaRRBJA0rAEJkQmud+QkhC6APefYSVKAwGo/3uoHLiiUx0fZVXdsF6HX/p
RyShmizdLnpOl11mNoAZM3cpMmsV0pHWc/GnfzS8BUuvvgqC3w9bDD6BnpfUwkmAnVcaRqkSonUa
NjiQszNqx7r643/OwFc5FAUgBmdqLUsvGlm1QsILkZWbR0pWTPUA5thR5HYBKYcbgIviJmQIREN/
T3wMCZvfvmuREypOeueVR9ODzx0HKY/kdY5KpJCB6gGc8Uzq9IPfhV7HkSij77HQQTEIi6qL5Zs+
RjUheJwyCheNvMeBPY9ME9s7p4Zqe7ODGwl8Rdjc8nl4+Ptd4z+HGHN5Ptf0AtehDfDEeyvE/VRZ
nLLY8hUyg6ZyXpo6kjDSexspN9e/tm5s3nwAGb7tjCESEmFshylT1f24meedFY7ydTgmq15Y68IG
XpUNmIJboON9lwlKkEZNwF4tliuFs2xMvr/fGDvVCRImx5fryhLc87Dk0+3XXycWFwcBPkVY36lE
o2I=
=zuLX
-----END PGP SIGNATURE-----

--8lDQ2R8nzpd2PKtDZloK0uSHN2Cl2aRVD--
