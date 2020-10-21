Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C488E294BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442035AbgJULfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:35:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:52026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410774AbgJULfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:35:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E17FABE3;
        Wed, 21 Oct 2020 11:35:43 +0000 (UTC)
Message-ID: <704546dadc3c1d39d260a29e850ae100fdf47fba.camel@suse.de>
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and
 its children
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Oct 2020 13:35:41 +0200
In-Reply-To: <20201019065208.x5k2zpuxjfhpmhdc@pengutronix.de>
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
         <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
         <0f0b7021e85a832afd42c6f9016158d6d8b0b28b.camel@suse.de>
         <20201019065208.x5k2zpuxjfhpmhdc@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y+CDlaV1ZewhdsGwsFAA"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y+CDlaV1ZewhdsGwsFAA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,
Sorry for the late reply, got distracted with other stuff.

On Mon, 2020-10-19 at 08:52 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Oct 16, 2020 at 05:26:56PM +0200, Nicolas Saenz Julienne wrote:
> > On Fri, 2020-10-16 at 09:38 -0500, Rob Herring wrote:
> > > On Thu, Oct 15, 2020 at 6:43 AM Nicolas Saenz Julienne
> > > <nsaenzjulienne@suse.de> wrote:
> > > > 'simple-mfd' usage implies there might be some kind of resource sha=
ring
> > > > between the parent device and its children.
> > >=20
> > > It does? No! The reason behind simple-mfd was specifically because
> > > there was no parent driver or dependency on the parent. No doubt
> > > simple-mfd has been abused.
> >=20
> > Fair enough, so we're doing things wrong. Just for the record, I'm look=
ing at
> > RPi=C2=B4s firmware interface:
> >=20
> > 	firmware: firmware {
> > 		compatible =3D "raspberrypi,bcm2835-firmware", "simple-mfd";
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		mboxes =3D <&mailbox>;
> >=20
> > 		firmware_clocks: clocks {
> > 			compatible =3D "raspberrypi,firmware-clocks";
> > 			#clock-cells =3D <1>;
> > 		};
> >=20
> > 		reset: reset {
> > 			compatible =3D "raspberrypi,firmware-reset";
> > 			#reset-cells =3D <1>;
> > 		};
> > 		[...]
> > 	};
> >=20
> > Note that "raspberrypi,bcm2835-firmware" has a driver, it's not just a
> > placeholder. Consumer drivers get a handle to RPi's firmware interface =
through
> > the supplier's API, rpi_firmware_get(). The handle to firmware becomes
> > meaningless if it is unbinded, which I want to protect myself against.
> >=20
> > A simpler solution would be to manually create a device link between bo=
th
> > devices ("raspberrypi,bcm2835-firmware" and "raspberrypi,firmware-clock=
s" for
> > example) upon calling rpi_firmware_get(). But I wanted to try addressin=
g the
> > problem in a generic way first.
>=20
> IMHO rpi_firmware_get() should get a reference on the firmware device
> (and call try_module_get()) which prevents unbinding it.

Yes, it seems the way to go. Just one last question WRT this, since
'drv->remove(dev)' can't fail should I just block until the reference count
hits zero?

Regards,
Nicolas


--=-y+CDlaV1ZewhdsGwsFAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+QHQ0ACgkQlfZmHno8
x/7PvAf/YPL3B9XkRBQ4azT4+l5kztL5y0A2T8nT+JN7jHnDZm7XYQKh9QFVm9Wg
8u8MpGUcAnv1W59qbbCznJDRtKIOQjM3YEB3b0g0uELCfOaAFk1WI4I9zsspRqPE
DaSFl0Xbp5p3FwnCKyJQUMghMtXixC1zxvB9xkxBbupRIBtezLjl2okW2X2drNeg
HLKbyTXZovJkF0EpY/44Z1haP8SryoxoALLvfmF6G8e3EE9qmcbY9nmxltKGqUfr
YRmMH2Q8648cGNjV5vy9cT2i6dc85VOOuYZuESGHTcGTrPcJxugC5wydDpsOGEUG
ZtHLJLGw50uiGJ8Tgb2kMwdNwFEf6A==
=OwyT
-----END PGP SIGNATURE-----

--=-y+CDlaV1ZewhdsGwsFAA--

