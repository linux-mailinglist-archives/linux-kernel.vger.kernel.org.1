Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8D2C258F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgKXMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbgKXMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:19:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5AAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:19:53 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khXIQ-0001FJ-1W; Tue, 24 Nov 2020 13:19:46 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khXIO-0005Ik-NF; Tue, 24 Nov 2020 13:19:44 +0100
Date:   Tue, 24 Nov 2020 13:19:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] amba: Make the remove callback return void
Message-ID: <20201124121943.72etfmpubis6jw3l@pengutronix.de>
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de>
 <20201124103242.2971199-3-u.kleine-koenig@pengutronix.de>
 <CAK8P3a0xz8Yf37GVntdyP-npKJ5N7jKH16JdcYL-a214KsXaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zq5jbqs3ok2srepm"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0xz8Yf37GVntdyP-npKJ5N7jKH16JdcYL-a214KsXaEg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zq5jbqs3ok2srepm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 12:48:05PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 24, 2020 at 11:32 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Most amba drivers return 0 in their remove callback. Together with the
> > driver core ignoring the return value anyhow, it doesn't make sense to
> > return a value here.
> >
> > So add a warning to the only driver that could return an error code and
> > change the remove prototype to return void, which makes it explicit that
> > returning an error value doesn't work as expected. This simplifies chan=
ging
> > the core remove callback to return void, too.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Makes sense, I checked that the vfio driver cannot actually return an err=
or
> either, the 'if (vdev)' check seems to be done out of unnecessary caution,
> as the probe would never have succeeded if that was NULL.

Yes I thought this possible, but didn't tried to wrap my head around the
logic there. IMHO this warrants a cleanup, will address this in v2.

Thanks for your feedback,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zq5jbqs3ok2srepm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+8+lwACgkQwfwUeK3K
7Al8rwf/UqPq57uXKYh4PV+Y3o/wPKv35dYocyH9HfrXmi0+4MtUV4p2WRSj/w5y
SJwUJWSlCHHS4E/htNSAGeMU/4uWQ0hWCVDJeEenPaP7RFC8UZwePSwQw9XM7uL/
y+DL+yyCxIBtRX7+hbhmMOJqa2Dzmr1XzcFCzRddOOrtRriUQ2LA9tLI8Ql6fuMg
i/nb84oyw70yHBxqON9d3zOLNFDj+PHxjXaWuKP/GpjqpdcXLpnkn0yCndR6te8c
qLpsaDfp6/zA18K22t7yfQu251Qd9OUpbOnaCtTEDUeTJtQ6hzYH1QlZwaLwNCeu
+gxFJj3v0yXphIMpmUGRT3IlhTtbVA==
=qTCK
-----END PGP SIGNATURE-----

--zq5jbqs3ok2srepm--
