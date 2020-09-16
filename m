Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70E26CC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgIPUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:40:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgIPRFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:05:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 9357629166C
Date:   Wed, 16 Sep 2020 13:05:16 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/3] drm/panfrost: add Amlogic integration quirks
Message-ID: <20200916170516.GB2543@kevin>
References: <20200916150147.25753-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20200916150147.25753-1-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

series r-b, nice!
On Wed, Sep 16, 2020 at 05:01:44PM +0200, Neil Armstrong wrote:
> The T820, G31 & G52 GPUs integrated by Amlogic in the respective GXM, G12=
A/SM1 & G12B
> SoCs needs a quirk in the PWR registers at the GPU reset time.
>=20
> This serie adds the necessary quirks for the Amlogic integrated GPUs only.
>=20
> Changes since v1 at [1]:
> - removed the BROKEN_SH quirk after [2] was sent by robin
> - rebased on top of [3] by steven and moved the vendor quirk in the prope=
r quirk function
> - added PWR_KEY unlock definition, and cleaned definition
>=20
> [1] https://lkml.kernel.org/r/20200908151853.4837-1-narmstrong@baylibre.c=
om
> [2] https://lkml.kernel.org/r/cover.1600213517.git.robin.murphy@arm.com
> [3] https://lkml.kernel.org/r/20200909122957.51667-1-steven.price@arm.com
>=20
> Neil Armstrong (3):
>   drm/panfrost: add support for vendor quirk
>   drm/panfrost: add amlogic reset quirk callback
>   drm/panfrost: add Amlogic GPU integration quirks
>=20
>  drivers/gpu/drm/panfrost/panfrost_device.h |  3 +++
>  drivers/gpu/drm/panfrost/panfrost_drv.c    | 11 +++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    | 15 +++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_regs.h   |  4 ++++
>  5 files changed, 35 insertions(+)
>=20
> --=20
> 2.22.0
>=20

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl9iRcwACgkQ/v5QWgr1
WA16Ww//cCG6HDblemm8T2W/m5FqeFuVtTwp2eNVCNN2pyJPT9FzLLtGMWPeAozs
6c4+3NCIJJX9ysEz9L1q5g7a5DbaN+4C7Z6FRJ3Ss1sNi/PmAlh0donBt5oiHAyJ
hptyz1bSM7ZyUDYuH564so9MpQRaBcR7Iz1gexVyhDO8Yi/rG133BgPOQ30EokTy
Kj42cVrmGxQg8rb64NTlDLf3nOYmSSWQN5z87v1mFMEzeZCWmm7gtbOicSQ8xV8a
xqCrm6he8ZHE6/3Ddmkw/IBeRrpD20d7TTcnzsvYtJeIGhTwzmlF8i/3ULYNsVvn
lCP7TMXxv50LUZM96wgSXetEOmZVDAWQG11Dxr7pTBx/DqYHOiGrqjqN87+g6wK7
TFsb4HbJRYguALvLaxLFhLUlMExYuiXJFkAYULJ/YudmVhBRwl/ZZfYNjeAyjzPd
TZ+aWkMrLaf3tXwV2h73EiqGrMb/48AJzOxntUCz9dFmEqPZLmjcX3uHb1HbYsdK
RdcIGA6Lr4M8ImKmBzJPnJ5G0QWFM2JzZAFWoiZvAEk2vSIHx2Tcou1zGXzJF6oH
O/jXUB8CL3D+lCF8z4eDv77dTiZ/W1qlTJmpQ2aFx4Kf3Q/sS4R+MG0e168cOGK4
yfGXfv1CWz9wPd4GSgcSed+SYWMqKzGGL0LCDgtdoEiez2X+KLA=
=7+0X
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
