Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3822D2545
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgLHH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:59:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgLHH7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:59:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 875CEAD6B;
        Tue,  8 Dec 2020 07:58:40 +0000 (UTC)
Subject: Re: [PATCH] drm/drv: switch to using devm_add_action_or_reset()
To:     Tian Tao <tiantao6@hisilicon.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1607303055-5199-1-git-send-email-tiantao6@hisilicon.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <84176f0f-56e2-c8dd-2f4d-651ec4abe435@suse.de>
Date:   Tue, 8 Dec 2020 08:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1607303055-5199-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OBOk2NzH9KUjppU08qVTZvjsi2x5bTcac"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OBOk2NzH9KUjppU08qVTZvjsi2x5bTcac
Content-Type: multipart/mixed; boundary="swqm5MMhWIed7od01E2Dqsm0Nt5PbPvnu";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Tian Tao <tiantao6@hisilicon.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <84176f0f-56e2-c8dd-2f4d-651ec4abe435@suse.de>
Subject: Re: [PATCH] drm/drv: switch to using devm_add_action_or_reset()
References: <1607303055-5199-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1607303055-5199-1-git-send-email-tiantao6@hisilicon.com>

--swqm5MMhWIed7od01E2Dqsm0Nt5PbPvnu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 07.12.20 um 02:04 schrieb Tian Tao:
> switch to using devm_add_action_or_reset() instead of devm_add_action.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

I'm surprised that devm_drm_dev_init() didn't already use=20
devm_add_action_or_reset(). But it doesn't look special, so

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_drv.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 7343038..b92f7fd 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -675,11 +675,8 @@ static int devm_drm_dev_init(struct device *parent=
,
>   	if (ret)
>   		return ret;
>  =20
> -	ret =3D devm_add_action(parent, devm_drm_dev_init_release, dev);
> -	if (ret)
> -		devm_drm_dev_init_release(dev);
> -
> -	return ret;
> +	return devm_add_action_or_reset(parent,
> +					devm_drm_dev_init_release, dev);
>   }
>  =20
>   void *__devm_drm_dev_alloc(struct device *parent,
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--swqm5MMhWIed7od01E2Dqsm0Nt5PbPvnu--

--OBOk2NzH9KUjppU08qVTZvjsi2x5bTcac
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAl/PMi8FAwAAAAAACgkQlh/E3EQov+BE
9BAAmMZPjUjeeWxDYuc6FgJrELz9Ip1vR9sOpN9vVRc6Gb6oeZQrAUHQZER8dfHuNJyBez10q6G9
FlyX/WMc3p4viih51xU826TEWomOChZyzrNG325VjKH1wpXdJv5h36EOPzu+VjDrI5SG+obwPsBY
XnPNO+JWey7Q3l59g9hfcGhKahKVwdyAb0ymasP1o8eD1YeOgFENP0fz2+q8IdY4YpsamuSMixKY
TxEt6VqTxKBJXrTzgHMIM/VBtCSACg3SwWj40RKgo1vvTR4IPzd33ys7Q/OJ8tqVKslWU/X7J8ij
vwsv/2IzvoK+eam3deWVVyhqc3fu2xW76xgJbSch2i1sjuiecLhl9aFlVkvzirHy0MMSwoj7Hi5S
6r+QA9PhUsL8eHcziNzTt7wa1g4v/wyVzqY7HzAQywKPRCsA350ePbUebvrQbELI5kb8SKxfFs27
/oTOyxuAcT/6KQIuzPQts4KDo406TcHOTTJmB6u4ZqUVYHfZ4oao7ROciq0ib85JlLVYHK6Ihnyl
RX8KBZQp11jwZKxNTt+U8Mrk/SQpSoWd/fNyLZe6HCdF6o5fVy/HIKdr4DjY0GPd5DFdgsaA7CHO
C8nvRS/ymdIUm4QkhNPmkTovoG2ElyhKUcrMUCAKMRJ6hij+Voe/8RNgYWmTDH8xd8QD+veJZfHQ
8V0=
=+YfB
-----END PGP SIGNATURE-----

--OBOk2NzH9KUjppU08qVTZvjsi2x5bTcac--
