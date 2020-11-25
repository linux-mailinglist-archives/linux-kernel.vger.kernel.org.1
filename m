Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A142C39BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgKYHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgKYHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:06:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC2C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:06:32 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khoso-0004GJ-9h; Wed, 25 Nov 2020 08:06:30 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khosn-00010Q-Ig; Wed, 25 Nov 2020 08:06:29 +0100
Date:   Wed, 25 Nov 2020 08:06:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thorsten Scherer <thorsten.scherer@eckelmann.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] siox: Make remove callback return void
Message-ID: <20201125070627.ragkxfs56czkcrfv@pengutronix.de>
References: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
 <20201124141834.3096325-3-u.kleine-koenig@pengutronix.de>
 <20201124205845.jma7lay5tux6wiav@ws067.eckelmann.group>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cixxissz6k4lxedf"
Content-Disposition: inline
In-Reply-To: <20201124205845.jma7lay5tux6wiav@ws067.eckelmann.group>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cixxissz6k4lxedf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 09:58:45PM +0100, Thorsten Scherer wrote:
> Hello,
>=20
> On Tue, Nov 24, 2020 at 03:18:34PM +0100, Uwe Kleine-K=F6nig wrote:
> > The driver core ignores the return value of the remove callback, so
> > don't give siox drivers the chance to provide a value.
> >
> > All siox drivers only allocate devm-managed resources in
> > .probe, so there is no .remove callback to fix.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/siox/siox-core.c | 5 ++---
> >  include/linux/siox.h     | 2 +-
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> > index b56cdcb52967..1794ff0106bc 100644
> > --- a/drivers/siox/siox-core.c
> > +++ b/drivers/siox/siox-core.c
> > @@ -525,12 +525,11 @@ static int siox_remove(struct device *dev)
>=20
> Shouldn't this return void?

This is the callback used for struct device_driver::remove (and after
patch 2 struct bus_type::remove) which still has to return int. But in
the long run I want to change these to void, too.

Best regards and thanks for your feedback
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cixxissz6k4lxedf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl++Am0ACgkQwfwUeK3K
7AmNCAgAgcexh6x35DGDrKcMUYhkwLcKDlnYu2H7CWi8lQeDHo1C0PoFBIEcoR5Y
fU6zpkrQlysxf3A6Kgbes0PwD5T9xIGw4Umjmm1mnFRjdaAQW5HKP1gebxZ5wp/5
POcRPDO2NHO1h7XbBKTJsvB4sO0HC/es3gEx8q49INgBKhBkAKuqQ1kVkv8BywbK
vDK1AFbA241KBgP83iGj+zBuOrvOV9GKthAiE52APtPpw67mcHvbYmU5eUof6Y69
MpO1abp8T89CQdrNZ0Pssxs204Qw354qxJKdCPKB19AcGHCoZtAvhhmGL5rOzqnR
Anp1nBkWebGFBZlLwlTVATaPYy0nKg==
=PKyt
-----END PGP SIGNATURE-----

--cixxissz6k4lxedf--
