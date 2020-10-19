Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D318F2922A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgJSGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgJSGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:52:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D3C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 23:52:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUP1e-000609-8B; Mon, 19 Oct 2020 08:52:10 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kUP1d-00025L-1N; Mon, 19 Oct 2020 08:52:09 +0200
Date:   Mon, 19 Oct 2020 08:52:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and its
 children
Message-ID: <20201019065208.x5k2zpuxjfhpmhdc@pengutronix.de>
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
 <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
 <0f0b7021e85a832afd42c6f9016158d6d8b0b28b.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rzuuvg6pobgnjjut"
Content-Disposition: inline
In-Reply-To: <0f0b7021e85a832afd42c6f9016158d6d8b0b28b.camel@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rzuuvg6pobgnjjut
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 05:26:56PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2020-10-16 at 09:38 -0500, Rob Herring wrote:
> > On Thu, Oct 15, 2020 at 6:43 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > 'simple-mfd' usage implies there might be some kind of resource shari=
ng
> > > between the parent device and its children.
> >=20
> > It does? No! The reason behind simple-mfd was specifically because
> > there was no parent driver or dependency on the parent. No doubt
> > simple-mfd has been abused.
>=20
> Fair enough, so we're doing things wrong. Just for the record, I'm lookin=
g at
> RPi=B4s firmware interface:
>=20
> 	firmware: firmware {
> 		compatible =3D "raspberrypi,bcm2835-firmware", "simple-mfd";
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		mboxes =3D <&mailbox>;
>=20
> 		firmware_clocks: clocks {
> 			compatible =3D "raspberrypi,firmware-clocks";
> 			#clock-cells =3D <1>;
> 		};
>=20
> 		reset: reset {
> 			compatible =3D "raspberrypi,firmware-reset";
> 			#reset-cells =3D <1>;
> 		};
> 		[...]
> 	};
>=20
> Note that "raspberrypi,bcm2835-firmware" has a driver, it's not just a
> placeholder. Consumer drivers get a handle to RPi's firmware interface th=
rough
> the supplier's API, rpi_firmware_get(). The handle to firmware becomes
> meaningless if it is unbinded, which I want to protect myself against.
>=20
> A simpler solution would be to manually create a device link between both
> devices ("raspberrypi,bcm2835-firmware" and "raspberrypi,firmware-clocks"=
 for
> example) upon calling rpi_firmware_get(). But I wanted to try addressing =
the
> problem in a generic way first.

IMHO rpi_firmware_get() should get a reference on the firmware device
(and call try_module_get()) which prevents unbinding it.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rzuuvg6pobgnjjut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+NN5YACgkQwfwUeK3K
7Aki0AgAjLJyOs/xZ2fiowS1XIvogiPdro0ZzP7TwE0RjW3JEcQeCDDT3TsF6oDP
+V9XNu55POukh7ynAQwoKJ1r3I5RGJ+2lxxv/LUl11BXYfmxIlTVFqF3JvGU2Fyl
M1SIY9M/tc2MWcwk5ez2z18bF5s67Qa97+oUL0idMq5RGtrFnzAXud7rtYxBiXJ1
V5CkoH2CQN9zcIEnXmBl3pjEk0xpqdOAFKc1YxVT4bqr7kWU12Raa/OxuGTCLM3Z
ww4CjZdFJryegpVs7OUHRFuCZLoT5oeuiAmVPi1cBHIUjZgSUqq/E+uBS74qzTS3
RmlD8JdC9+UFV0Fy9yS/IvT925kAIQ==
=F6Pz
-----END PGP SIGNATURE-----

--rzuuvg6pobgnjjut--
