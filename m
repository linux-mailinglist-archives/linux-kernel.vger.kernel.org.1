Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083802B015E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKLIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:51:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:51:15 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd8K2-0001Lp-7D; Thu, 12 Nov 2020 09:51:14 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd8K1-00030Z-QE; Thu, 12 Nov 2020 09:51:13 +0100
Date:   Thu, 12 Nov 2020 09:51:12 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v1] drivers: make struct device_driver::remove return void
Message-ID: <20201112085112.mpp74wcpgs35lhvp@pengutronix.de>
References: <20201110150723.1592682-1-u.kleine-koenig@pengutronix.de>
 <X6r4ikS3SBPLqjZ1@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="245btghlb76nuk2s"
Content-Disposition: inline
In-Reply-To: <X6r4ikS3SBPLqjZ1@kroah.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--245btghlb76nuk2s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Tue, Nov 10, 2020 at 09:31:06PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 10, 2020 at 04:07:23PM +0100, Uwe Kleine-K=F6nig wrote:
> > The driver core doesn't check the return value of the remove callback
> > because there is only little software can do when hardware disappears.
> >=20
> > So change the callback to not return a value at all and adapt all users.
> > The motivation for this change is that some driver authors have a
> > misconception about failures in the remove callback. Making it void
> > makes it pretty obvious that there is no error handling to be expected.
> >=20
> > Most drivers were easy to convert as they returned 0 unconditionally, I
> > added a warning to code paths that returned an error code (that was
> > ignored already before).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > I expect that there are still a few driver that need adaption as I only
> > build tested allmodconfig on ARM and amd64.
> >=20
> > Best regards
> > Uwe
> >=20
> >  drivers/acpi/processor_driver.c         | 10 ++++------
> >  drivers/amba/bus.c                      |  7 ++++---
> >  drivers/base/platform.c                 | 13 +++++++------
> >  drivers/bus/fsl-mc/fsl-mc-bus.c         |  7 ++-----
> >  drivers/bus/mhi/core/init.c             |  6 ++----
> >  drivers/char/hw_random/optee-rng.c      |  4 +---
> >  drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++++----
> >  drivers/firmware/broadcom/tee_bnxt_fw.c |  4 +---
> >  drivers/fsi/fsi-master-hub.c            |  4 +---
> >  drivers/fsi/fsi-sbefifo.c               |  4 +---
> >  drivers/fsi/fsi-scom.c                  |  4 +---
> >  drivers/gpu/drm/drm_mipi_dsi.c          |  7 +++++--
> >  drivers/gpu/host1x/bus.c                | 11 +++++++----
> >  drivers/greybus/core.c                  |  4 +---
> >  drivers/hsi/clients/cmt_speech.c        |  4 +---
> >  drivers/hsi/clients/hsi_char.c          |  4 +---
> >  drivers/hsi/clients/nokia-modem.c       |  4 +---
> >  drivers/hsi/clients/ssi_protocol.c      |  4 +---
> >  drivers/i2c/busses/i2c-fsi.c            |  4 +---
> >  drivers/input/rmi4/rmi_bus.c            |  4 +---
> >  drivers/input/rmi4/rmi_driver.c         |  4 +---
> >  drivers/input/touchscreen/wm97xx-core.c |  7 +++----
> >  drivers/mfd/ucb1400_core.c              |  3 +--
> >  drivers/net/ethernet/3com/3c509.c       |  5 ++---
> >  drivers/net/ethernet/3com/3c59x.c       |  3 +--
> >  drivers/net/ethernet/dec/tulip/de4x5.c  |  4 +---
> >  drivers/net/fddi/defxx.c                |  5 ++---
> >  drivers/net/phy/mdio_device.c           |  4 +---
> >  drivers/net/phy/phy_device.c            |  4 +---
> >  drivers/pci/pcie/portdrv_core.c         |  5 ++---
> >  drivers/scsi/advansys.c                 |  3 +--
> >  drivers/scsi/aha1740.c                  |  4 +---
> >  drivers/scsi/aic7xxx/aic7770_osm.c      |  3 +--
> >  drivers/scsi/ch.c                       |  3 +--
> >  drivers/scsi/sd.c                       |  6 ++----
> >  drivers/scsi/ses.c                      |  3 +--
> >  drivers/scsi/sim710.c                   |  3 +--
> >  drivers/scsi/sr.c                       |  6 ++----
> >  drivers/scsi/st.c                       |  5 ++---
> >  drivers/siox/siox-core.c                |  6 ++++--
> >  drivers/soundwire/bus_type.c            | 13 +++++++------
> >  drivers/spi/spi.c                       |  8 +++++---
> >  drivers/usb/core/driver.c               |  7 ++-----
> >  drivers/visorbus/visorbus_main.c        |  5 +----
> >  include/linux/device/driver.h           |  2 +-
> >  sound/core/seq/oss/seq_oss_synth.c      |  6 ++----
> >  sound/core/seq/oss/seq_oss_synth.h      |  2 +-
> >  sound/core/seq/seq_midi.c               |  6 +++---
> >  sound/drivers/opl3/opl3_seq.c           | 10 ++++++----
> >  sound/drivers/opl4/opl4_seq.c           |  9 +++++----
> >  sound/hda/ext/hdac_ext_bus.c            |  9 +++++++--
> >  sound/isa/sb/emu8000_synth.c            |  5 ++---
> >  sound/pci/emu10k1/emu10k1_synth.c       |  5 ++---
> >  sound/pci/hda/hda_bind.c                | 11 +++++++----
> >  54 files changed, 129 insertions(+), 172 deletions(-)
>=20
> First off, that's a lot of drivers with a "raw" remove function, why is
> anyone doing that?  It should all be wrapped up in the bus that the
> drivers are on.
>=20
> In digging, ugh, looks like there's some sound driver abuse here that
> should be fixed up first, which will cause you to get these "for free",
> and some busses should be fixed up as well.
>=20
> This type of patch should only have to bus code, if things are right,
> not individual drivers.  It's not your fault, but fixing that up will
> make this patch easier as it will be in bisectable pieces :)

I don't understand how this gets more bisectable. The desired cleanups
won't look considerably different, will they? Also irrespective of their
order the intermediate steps will build and run just fine?!

I agree that there are quite some strange drivers, but given my limited
time to work on this now (and expecting to have to rework this patch if
I pick it up again for the next or even after-next merge window) I would
like to see this breed in next already now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--245btghlb76nuk2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+s930ACgkQwfwUeK3K
7Anzewf/QRBLF2K8fO9rdCSo03DKA/v7vWwHf40fgzgeRR46U1hWdogJP5dw+kP/
CEP6Ct66752CHOOHT5A2fxielrV9ZA+m+n7Pq6o7rjwiATbMo/kw9YCkmYJWLaqp
MaJwNmWjaGWKmBwwcaqYugd318qFfg2I3e8kmXMQ27ucg/4v/JXewgsGLYbug3fC
1wt46nbcfO2hpYnYgb213vK3ifUbGvhd5Z8T2RYUlTsbK+8oFvMf+t2GoAVymiR0
iozj/DpPoUaqRMYskAB7G3MASFaZfyVsJ82LrSzAq6gm1ULdubuJfxnPwMKZTq8T
hxhofayQMEKCvGSgBziOlX2T5IqnCg==
=DOaY
-----END PGP SIGNATURE-----

--245btghlb76nuk2s--
