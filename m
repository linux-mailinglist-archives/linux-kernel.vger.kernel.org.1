Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03BF2D3C34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgLIHac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgLIHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:30:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211DEC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 23:29:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtv3-0001Wg-PL; Wed, 09 Dec 2020 08:29:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmtv3-0006m4-CI; Wed, 09 Dec 2020 08:29:49 +0100
Date:   Wed, 9 Dec 2020 08:29:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20201209072949.2ovbtwv64bitosve@pengutronix.de>
References: <20201205214616.e4one25o3oz5dhrp@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uzurj4fglhtue42y"
Content-Disposition: inline
In-Reply-To: <20201205214616.e4one25o3oz5dhrp@einstein.dilieto.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uzurj4fglhtue42y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 05, 2020 at 10:46:16PM +0100, Nicola Di Lieto wrote:
> Added Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
>=20
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> ---
> .../devicetree/bindings/pwm/pwm-gpio.yaml          | 42 +++++++++++++++++=
+++++
> 1 file changed, 42 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Docume=
ntation/devicetree/bindings/pwm/pwm-gpio.yaml
> new file mode 100644
> index 000000000000..2e021ac6ff4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic software PWM for modulating GPIOs
> +
> +maintainers:
> +  - Nicola Di Lieto <nicola.dilieto@gmail.com>
> +
> +properties:
> +  "#pwm-cells":
> +    description: |
> +      It must be 2. See pwm.yaml in this directory for a
> +      description of the cells format.

I think nowadays we prefer 3 here.

> +    const: 2
> +
> +  compatible:
> +    const: pwm-gpio
> +
> +  gpios:
> +    description:
> +      GPIO to be modulated
> +    maxItems: 1
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uzurj4fglhtue42y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/QfOoACgkQwfwUeK3K
7Al7xAf+KSy4Lb92gzGHro1rVxHq+lT8RccgvH+n5TT/3qgBzjBVL+BDm+W0Vvq0
owUwM7StJug3oyr7WKkQQJjEQS08GJGtjPGofb6wZQK8dw8vXker5jPnEy1WSqBy
ThZ9BEBDkh8mlSQ+KaGN33sCoIz7jbgIIlEc/Vtf9lIRK3IjIDsLVotGXl5j1FOX
3c+JQEB/M1RiQeZA9CyYMNXXZcKZJc9d4HYPqhb5GS8CiQXAlJXzxGgHvaZEhXDK
UV09SqL0hPbalm0LLwsywnlxtVi5fjBMwXa773GVlonzVVmJBNRutR4summqwkMg
gdrhLd45BY97wXNZppPSzMIFUIP04w==
=R2pM
-----END PGP SIGNATURE-----

--uzurj4fglhtue42y--
