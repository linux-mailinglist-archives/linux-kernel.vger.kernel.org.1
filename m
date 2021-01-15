Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EB2F7892
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbhAOMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbhAOMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:16:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5644C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:16:09 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0O1L-0000Ek-6T; Fri, 15 Jan 2021 13:16:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0O1K-0003AG-30; Fri, 15 Jan 2021 13:16:02 +0100
Date:   Fri, 15 Jan 2021 13:16:01 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bus: sunxi-rsb: make remove callback return void
Message-ID: <20210115121601.4xw2kchnkcowxlga@pengutronix.de>
References: <20201126104142.2011756-1-u.kleine-koenig@pengutronix.de>
 <20210115081122.GE3975472@dell>
 <20210115104516.yvo77t4wz2o76byn@pengutronix.de>
 <20210115110543.GG3975472@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="csjyhvc4l5ccnrfb"
Content-Disposition: inline
In-Reply-To: <20210115110543.GG3975472@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--csjyhvc4l5ccnrfb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The driver core ignores the return value of struct device_driver::remove
because there is only little that can be done. To simplify the quest to
make this function return void, let struct sunxi_rsb_driver::remove
return void, too.

axp20x_device_remove() always returns 0, so there is no information
lost in axp20x_rsb_remove(). The only other sunxi-rsb driver doesn't
have a remove callback and so doesn't require adaption.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---

Hello Lee,

On Fri, Jan 15, 2021 at 11:05:43AM +0000, Lee Jones wrote:
> On Fri, 15 Jan 2021, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jan 15, 2021 at 08:11:22AM +0000, Lee Jones wrote:
> > > There are no dependencies between the MFD and Bus changes as far as I
> > > can tell.
> >=20
> > There are dependencies, because
> >=20
> > -static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
> > +static void axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
> >=20
> > in drivers/mfd/axp20x-rsb.c must be done together with
> >=20
> > --- a/include/linux/sunxi-rsb.h
> > +++ b/include/linux/sunxi-rsb.h
> > @@ -59,7 +59,7 @@ static inline void sunxi_rsb_device_set_drvdata(struc=
t sunxi_rsb_device *rdev,
> >  struct sunxi_rsb_driver {
> >  	struct device_driver driver;
> >  	int (*probe)(struct sunxi_rsb_device *rdev);
> > -	int (*remove)(struct sunxi_rsb_device *rdev);
> > +	void (*remove)(struct sunxi_rsb_device *rdev);
> >  };
> >  [...]
>=20
> Yes, this will need to be taken in with the MFD patch.
>=20
> > > For the sake of simplicity i.e. to avoid the requirement of
> > > immutable branch maintenance and an associated pull-request, it would
> > > be better to split this out into 2 separate patches.
> >=20
> > So the base for this statement is gone
>=20
> It still stands.

I don't understand this. Now I dropped the simplification and just kept
the part implementing the change of struct sunxi_rsb_driver::remove to
return void.

Is the need for an immutable branch in your eyes gone now? (If yes, I
don't understand what is the relevant difference compared to the
previous patch; and if not I don't understand why you wrote "For the
sake of simplicity [...] it would be better to split this out into 2
separate patches." if even only one of the two patches you requested
still needs coordination.)

> > and the following questions remain:
>=20
> >  - Do you insist on splitting out the change to axp20x_device_remove()?
>=20
> [0] Unless you gave give me a compelling reason why it shouldn't, yes.
>=20
> >  - Do you prefer to ack the mfd part to let the patch (or patches if
> >    they get split) go via the sunxi people or do you want to take the
> >    it (them) via mfd?
>=20
> I'd prefer the MFD (and header only affecting MFD) to go in via MFD.

ok.

> The Bus patch can do in via it's own tree.

I'm not sure what you mean saying "the Bus patch". This v2 that is
still touching drivers/mfd? Probably not, because above you wrote that
the prototype change "will need to be taken in with the MFD patch". /me
is confused.

> > Looking at next there are four patches touching drivers/bus/sunxi-rsb.c
> > and none touching drivers/mfd/axp20x* or include/linux/mfd/axp20x.h
> > which suggests that letting it go via sunxi might be more sensible. IMHO
> > an immutable branch is not necessary?!
>=20
> It's only -rc3 and you cannot tell the future.
>=20
> If you manage to satisfy [0] and they do end up going in together, I
> will insist on an immutable branch.

I look forward to your position regarding this patch.

If this patch is simple enough to not need coordination and if adding
the simplifcation (as a separate patch) brings back this need, I'd just
go with this patch only.

Best regards
Uwe

 drivers/bus/sunxi-rsb.c   | 4 +++-
 drivers/mfd/axp20x-rsb.c  | 4 ++--
 include/linux/sunxi-rsb.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1bb00a959c67..117716e23ffb 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -170,7 +170,9 @@ static int sunxi_rsb_device_remove(struct device *dev)
 {
 	const struct sunxi_rsb_driver *drv =3D to_sunxi_rsb_driver(dev->driver);
=20
-	return drv->remove(to_sunxi_rsb_device(dev));
+	drv->remove(to_sunxi_rsb_device(dev));
+
+	return 0;
 }
=20
 static struct bus_type sunxi_rsb_bus =3D {
diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index 4cdc79f5cc48..214bc0d84d44 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -49,11 +49,11 @@ static int axp20x_rsb_probe(struct sunxi_rsb_device *rd=
ev)
 	return axp20x_device_probe(axp20x);
 }
=20
-static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
+static void axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
 {
 	struct axp20x_dev *axp20x =3D sunxi_rsb_device_get_drvdata(rdev);
=20
-	return axp20x_device_remove(axp20x);
+	axp20x_device_remove(axp20x);
 }
=20
 static const struct of_device_id axp20x_rsb_of_match[] =3D {
diff --git a/include/linux/sunxi-rsb.h b/include/linux/sunxi-rsb.h
index 7e75bb0346d0..bf0d365f471c 100644
--- a/include/linux/sunxi-rsb.h
+++ b/include/linux/sunxi-rsb.h
@@ -59,7 +59,7 @@ static inline void sunxi_rsb_device_set_drvdata(struct su=
nxi_rsb_device *rdev,
 struct sunxi_rsb_driver {
 	struct device_driver driver;
 	int (*probe)(struct sunxi_rsb_device *rdev);
-	int (*remove)(struct sunxi_rsb_device *rdev);
+	void (*remove)(struct sunxi_rsb_device *rdev);
 };
=20
 static inline struct sunxi_rsb_driver *to_sunxi_rsb_driver(struct device_d=
river *d)
--=20
2.29.2


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--csjyhvc4l5ccnrfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABh34ACgkQwfwUeK3K
7An44Af8DQ/GlAghJC5y/MBmm/oEfZwa6b0qlFgCVg8wAwDUzEPh8YQHeTEMqtFn
84DUkfYxHwNgiywdvff8/pQ9Cj5gdSSNDZnO8e3Zx+RAhoeejA3XQK7idCn3coKX
2M4DD9JfdN8fsCRDAYt2GMgvgEQCCdXQHEwCUDRGRExDBNAcW94ZPFPLTKExteey
roEk4/s4DChJHheAiuXoVcyq9hkUsM4U0MLG0848RyjjVhZOac19r3jR+F0Mgfsv
u8ER/eB0+YGPZyw/Xe0aqsFhVXg3ZhBNKskthZb/ImGZaojn1sNoLERPvWP0SGop
NIfXuFCqWXRfDUzUkJD71D7mbdIKSg==
=uH7T
-----END PGP SIGNATURE-----

--csjyhvc4l5ccnrfb--
