Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6232D8758
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 16:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394620AbgLLPkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLLPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 10:40:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F9C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 07:39:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ko6zd-00062E-5q; Sat, 12 Dec 2020 16:39:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ko6zc-0003nz-Gy; Sat, 12 Dec 2020 16:39:32 +0100
Date:   Sat, 12 Dec 2020 16:39:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: don't oops on unbound devices
Message-ID: <20201212153929.yn47oz4fm37ysrry@pengutronix.de>
References: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
 <X9SsbBfL81PmcJXH@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cw6bd6at635tlnsl"
Content-Disposition: inline
In-Reply-To: <X9SsbBfL81PmcJXH@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cw6bd6at635tlnsl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 12, 2020 at 12:41:32PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Dec 12, 2020 at 04:14:26AM +0300, Dmitry Baryshkov wrote:
> > Platform code stopped checking if the device is bound to the actual
> > platform driver, thus calling non-existing drv->shutdown(). Verify that
> > _dev->driver is not NULL before calling remove/shutdown callbacks.
> >=20
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
> > ---
> >  drivers/base/platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 0358dc3ea3ad..93f44e69b472 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1342,7 +1342,7 @@ static int platform_remove(struct device *_dev)
> >  	struct platform_device *dev =3D to_platform_device(_dev);
> >  	int ret =3D 0;
> > =20
> > -	if (drv->remove)
> > +	if (_dev->driver && drv->remove)
> >  		ret =3D drv->remove(dev);
> >  	dev_pm_domain_detach(_dev, true);
>=20
> I don't object to this, but it always feels odd to be doing pointer math
> on a NULL value, wait until the static-checkers get ahold of this and
> you get crazy emails saying you are crashing the kernel (hint, they are
> broken).

I think you refer to the line

	struct platform_driver *drv =3D to_platform_driver(_dev->driver);

which when _dev->driver is NULL results in drv being something really
big?!

Accoding to my understanding platform_remove() shouldn't be called if
the device isn't bound to a driver.

> But, I don't see why this check is needed?  If a driver is not bound to
> a device, shouldn't this whole function just not be called?  Or error
> out at the top? =20
>=20
> Uwe, I'd really like your review/ack of this before taking it.

So I agree and have the same question. So I wonder: @Dmitry, did you see
a crash? When did it happen?

For one of the bus types I changed recently
(arch/powerpc/platforms/ps3/system-bus.c) the bus's shutdown function
does:

	if (drv->shutdown)
		drv->shutdown(dev);
	else if (drv->remove) {
		dev_dbg(&dev->core, ...
		drv->remove(dev);
	} ...

but for the platform bus I'm not aware that remove is used in absence of
a shutdown callback.

Relevant callers of bus->remove are all in drivers/base/dd.c, and for
all of them dev->driver should be set.

I look forward to an explaination about why this patch was created.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cw6bd6at635tlnsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/U5C4ACgkQwfwUeK3K
7AkvMgf/awBgMMr2WlX2W/GI7g7Kyg8EtWqyKJl3fIrGVFTmc/B1vNA+4AhLQKx3
0GyKetmpDI9TNY0LyHsETt1ovKKfeNlaJ1+uw+vsPhqtyCWRUZSqqJy8FOHVF8en
9XGpXIMnaQuOAF7QbnnGzKpTI18Mj9BXo1bhrYE9gOJ854qeqIX24mIcGzeOD7HT
B0WpnAT4ihtFek7NSM3Xq/FEdfagGdyVL30Uv6wMoWFOqvZIILm15r4gYQqz5oOt
UlGP6jIR4SB6WvvuBt9l0Na8HcwCK7RJdOhPrOm+PHNv4mwSmCDUoyvzd6v5QCS0
J6DC38uU4ez6gr68Tvbg0pDRlPNHIA==
=59qz
-----END PGP SIGNATURE-----

--cw6bd6at635tlnsl--
