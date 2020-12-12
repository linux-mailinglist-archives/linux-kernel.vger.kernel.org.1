Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231E72D8A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 22:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407929AbgLLVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 16:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 16:09:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBACCC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 13:09:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koC8U-0000ZG-LR; Sat, 12 Dec 2020 22:09:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koC8T-00069O-Jn; Sat, 12 Dec 2020 22:09:01 +0100
Date:   Sat, 12 Dec 2020 22:09:01 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: platform: don't oops on unbound devices
Message-ID: <20201212210901.ecmhdn3jqg74jodw@pengutronix.de>
References: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
 <X9SsbBfL81PmcJXH@kroah.com>
 <20201212153929.yn47oz4fm37ysrry@pengutronix.de>
 <CAA8EJpqwJKwYS=9o5Vtqwmi5qGd33woK_q4NO5h6mh-f3G+NtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxdwzsc2e5vgushe"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqwJKwYS=9o5Vtqwmi5qGd33woK_q4NO5h6mh-f3G+NtA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxdwzsc2e5vgushe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Sat, Dec 12, 2020 at 11:49:26PM +0300, Dmitry Baryshkov wrote:
> On Sat, 12 Dec 2020 at 18:39, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sat, Dec 12, 2020 at 12:41:32PM +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Dec 12, 2020 at 04:14:26AM +0300, Dmitry Baryshkov wrote:
> > > > Platform code stopped checking if the device is bound to the actual
> > > > platform driver, thus calling non-existing drv->shutdown(). Verify =
that
> > > > _dev->driver is not NULL before calling remove/shutdown callbacks.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions=
")
> > > > ---
> > > >  drivers/base/platform.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > > index 0358dc3ea3ad..93f44e69b472 100644
> > > > --- a/drivers/base/platform.c
> > > > +++ b/drivers/base/platform.c
> > > > @@ -1342,7 +1342,7 @@ static int platform_remove(struct device *_de=
v)
> > > >     struct platform_device *dev =3D to_platform_device(_dev);
> > > >     int ret =3D 0;
> > > >
> > > > -   if (drv->remove)
> > > > +   if (_dev->driver && drv->remove)
> > > >             ret =3D drv->remove(dev);
> > > >     dev_pm_domain_detach(_dev, true);
> > >
> > > I don't object to this, but it always feels odd to be doing pointer m=
ath
> > > on a NULL value, wait until the static-checkers get ahold of this and
> > > you get crazy emails saying you are crashing the kernel (hint, they a=
re
> > > broken).
> >
> > I think you refer to the line
> >
> >         struct platform_driver *drv =3D to_platform_driver(_dev->driver=
);
> >
> > which when _dev->driver is NULL results in drv being something really
> > big?!
>=20
> Yes. To remove pointer math on NULL value I can move the check for
> _dev->driver before calculating drv.

Yeah, that would be good.

> > Accoding to my understanding platform_remove() shouldn't be called if
> > the device isn't bound to a driver.
> >
> > > But, I don't see why this check is needed?  If a driver is not bound =
to
> > > a device, shouldn't this whole function just not be called?  Or error
> > > out at the top?
> > >
> > > Uwe, I'd really like your review/ack of this before taking it.
> >
> > So I agree and have the same question. So I wonder: @Dmitry, did you see
> > a crash? When did it happen?
>=20
> The crash happens in the platform_shutdown() function, which gets
> called for unbound devices after commit 9c30921fe ("driver core:
> platform: use bus_type functions").
> I can include crash trace into v2.

Ah, now I understood. I didn't look too closely on your patch, only on
what Greg quoted. So you added a check to platform_remove (which should
be unnecessary) and to platform_shutdown (where I agree the check is
necessary).

> I added a check to platform_remove() as a safety measure. All current
> calls for dev->bus->remove() in dd.c seem to happen only when
> dev->driver is set, but I thought that it might be a good check. I can
> drop it if you'd like.

Yes, I'd like you to drop this. .remove isn't called for devices without
drivers.

Best regards and thanks for cleaning up after me,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hxdwzsc2e5vgushe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/VMWoACgkQwfwUeK3K
7AlWWAf+LkepaAchotHxOkQmY2bipqfFA9PCqpfsj7rEhlKmm0DXkQvoHnN3RGqV
We8u5FUnNtEzkkEXPmJW/vnTfhE5z75Bxx2mFcZ03EnnD2GCL7QK9BNytOKWhhJd
IirtUpMfZVHbGQo85ADRKQYRE5zgGjJK8tYY4qxZoahdP97FucngMMkMMNZV4XPp
zUIjoMErUIAj5mjTzYLNJfoXoBEobG+pjVjvU+ro2sd6E9ZpE5ZdYCViH/6k0zdl
4XP3fdfjG68eFFLTTUKpEy2KS8nTJjN2Fu+rrosJotQDBdpmPQaH1TRn3vw5+zBv
KYKmus4uS64ycBUuAl9Q3knddbxnqw==
=Shg2
-----END PGP SIGNATURE-----

--hxdwzsc2e5vgushe--
