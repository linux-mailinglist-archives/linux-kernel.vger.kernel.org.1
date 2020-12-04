Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04142CF6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 23:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLDWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 17:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgLDWax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 17:30:53 -0500
Date:   Fri, 4 Dec 2020 22:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607121012;
        bh=A5PDfegmsJU+jI11CZKuk4ET2s0/56XBFxg7Dke1AsY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAMqQH+IMxEyJwYPxR+S8ROZ2UotxOAVljhq1R9dBTmRmxY2RP0z7IsOhUmEowBY+
         QfxltaJWkJnn6KEVMntOu+AsdQ2OcXfmKVQbOkt4tyteO0rHMjibeAY6cuse+0f7+r
         d7GGLgIiVpC46xVRu715VrNZkrsfGrvFEUgX1kQ3pXN8QyblAGkEHqI/F92m4upUoy
         u9gOebncBxnZdunMR+sWGeLWae8E2wOhIKt+6EMWHC0R5D1EC1eFj4unhGb+WgdnG2
         dvwh/LTK4QF7XY35k3KVB/+lrgt6ehMk6DbvYpbAfEDiD8vf4p3sBa8x9wIR2mVM6i
         UGK3nq36b2Bhw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: ab8500: Decomission platform data header
Message-ID: <20201204223008.GH4558@sirena.org.uk>
References: <20201204140342.1640941-1-linus.walleij@linaro.org>
 <20201204140342.1640941-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <20201204140342.1640941-2-linus.walleij@linaro.org>
X-Cookie: Not a flying toy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2020 at 03:03:42PM +0100, Linus Walleij wrote:

> ---
>  drivers/regulator/ab8500-ext.c   |  13 ++-
>  drivers/regulator/ab8500.c       | 116 ++++++++++++++++++++++-
>  include/linux/regulator/ab8500.h | 156 -------------------------------
>  3 files changed, 127 insertions(+), 158 deletions(-)
>  delete mode 100644 include/linux/regulator/ab8500.h

There's also an include of the header in ab8500-core.c which isn't
removed by either this or the previous patch and needs to be handled
somehow.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/KuHAACgkQJNaLcl1U
h9AaRgf/ShdIC5H2zxVLdasIryvAxbCtZ06to3Id6p3T2lUHbvFeXLfgq5F/d43P
aUcpPacS4eSbDUAerwofYUd+qQ+XYl446qlREuFJ9RxDrmAcU3PYWoOHFdls545G
m0ihRvfGzRqC6kreyQeMiKuFYuIM8vPHj70R2K+rLNGB1BvXJtR9pDbjcSVP1X/O
ioCe7Z6TL0oqEmQz6Z7G2GJFyeM2usQhofwdNbvUDJVXxS3JWrX4iOGDtGsWhYZs
ixTWSIZJb8oUwZ3Ro/CeTxljbKGoaAxOTZ9ydjLenSN0R91+nKynxzEhRCoXmDgv
Meq/crT8RhOg28g/NVYkadFtP79Kqg==
=vvbQ
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--
