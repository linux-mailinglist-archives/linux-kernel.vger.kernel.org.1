Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E862DA1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503242AbgLNUmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503257AbgLNUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:42:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EBC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:41:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koueM-0001AA-Q3; Mon, 14 Dec 2020 21:40:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1koueF-0007oy-5s; Mon, 14 Dec 2020 21:40:47 +0100
Date:   Mon, 14 Dec 2020 21:40:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/5] amba: Make the remove callback return void
Message-ID: <20201214204046.xopipytz4ws7j72f@pengutronix.de>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org>
 <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4tairbvh5lrnswh"
Content-Disposition: inline
In-Reply-To: <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4tairbvh5lrnswh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 02:01:41PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> [This is a resend because somehow my MUA failed to parse the To: list
> and dropped it without me noticing it. Sorry to those who got it twice
> now.]
>=20
> On Tue, Nov 24, 2020 at 02:31:38PM +0100, Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > All amba drivers return 0 in their remove callback. Together with the
> > driver core ignoring the return value anyhow, it doesn't make sense to
> > return a value here.
> >=20
> > Change the remove prototype to return void, which makes it explicit that
> > returning an error value doesn't work as expected. This simplifies chan=
ging
> > the core remove callback to return void, too.
> >=20
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/amba/bus.c                                 | 5 ++---
> >  drivers/char/hw_random/nomadik-rng.c               | 3 +--
> >  drivers/dma/pl330.c                                | 3 +--
> >  drivers/gpu/drm/pl111/pl111_drv.c                  | 4 +---
> >  drivers/hwtracing/coresight/coresight-catu.c       | 3 +--
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c  | 4 +---
> >  drivers/hwtracing/coresight/coresight-cti-core.c   | 4 +---
> >  drivers/hwtracing/coresight/coresight-etb10.c      | 4 +---
> >  drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 +---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 +---
> >  drivers/hwtracing/coresight/coresight-funnel.c     | 4 ++--
> >  drivers/hwtracing/coresight/coresight-replicator.c | 4 ++--
> >  drivers/hwtracing/coresight/coresight-stm.c        | 4 +---
> >  drivers/hwtracing/coresight/coresight-tmc-core.c   | 4 +---
> >  drivers/hwtracing/coresight/coresight-tpiu.c       | 4 +---
> >  drivers/i2c/busses/i2c-nomadik.c                   | 4 +---
> >  drivers/input/serio/ambakmi.c                      | 3 +--
> >  drivers/memory/pl172.c                             | 4 +---
> >  drivers/memory/pl353-smc.c                         | 4 +---
> >  drivers/mmc/host/mmci.c                            | 4 +---
> >  drivers/rtc/rtc-pl030.c                            | 4 +---
> >  drivers/rtc/rtc-pl031.c                            | 4 +---
> >  drivers/spi/spi-pl022.c                            | 5 ++---
> >  drivers/tty/serial/amba-pl010.c                    | 4 +---
> >  drivers/tty/serial/amba-pl011.c                    | 3 +--
> >  drivers/vfio/platform/vfio_amba.c                  | 3 +--
> >  drivers/video/fbdev/amba-clcd.c                    | 4 +---
> >  drivers/watchdog/sp805_wdt.c                       | 4 +---
> >  include/linux/amba/bus.h                           | 2 +-
> >  sound/arm/aaci.c                                   | 4 +---
> >  30 files changed, 34 insertions(+), 80 deletions(-)
>=20
> I failed to Cc: the relevant maintainers before, so that's why I'm
> adressing you now. The idea is to let this series (completely available at
> https://lore.kernel.org/linux-arm-kernel/20201124133139.3072124-1-uwe@kle=
ine-koenig.org/)
> go in via Russell King's tree, so an Ack from you would be great. If you
> want the original in your mailbox, just tell me and I can send you a
> bounce (or use b4 on the above link).

Technically there are still some maintainers' ack missing but I'd really
like to get this series applied.  As I don't want to make people angry
I'm asking once more for your Acks.

Or is the stuff outside of drivers/amba trivial enough to merge it even
without each maintainer's ack? (It's changing some functions from
returning int to void and dropping "return 0;".)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p4tairbvh5lrnswh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/XzcsACgkQwfwUeK3K
7AkwMQgAoD9Xq3aTP2IbzhLbHR7AzBM7m70POXMKJIT8EOsyFtk4eh1Olh+5A5vH
NfpldngpsNMPbRPFohlpd90aHvCohTB8KpYa2nIQAJeF8JkRLDHUlZysr9A3xwtI
MgFEFuBRgunJvxPNnFiY0rLZlx7sjslj+f+3vl3W9CRRNPhwOZLDxz81o5aoeeEx
JR9l1giz+/mwMeToYIfyozpxu6MookmrZzpeCpWcsv/AmQQLZ9z0BERS0jNQoRRU
rwhPEs69tQ5qFRdKhP1O2ulQT1QwSvZeOSez5ilEJ1T2j+vIfoEKGLZ0LlRDSySx
VhA4RzGQ9xEae93aZD0rJI8UftUamw==
=8Rca
-----END PGP SIGNATURE-----

--p4tairbvh5lrnswh--
