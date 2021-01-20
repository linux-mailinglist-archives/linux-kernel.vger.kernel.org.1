Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42672FCF94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbhATLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:28 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37295 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388239AbhATKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:52:17 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 316EF20008;
        Wed, 20 Jan 2021 10:50:30 +0000 (UTC)
Date:   Wed, 20 Jan 2021 11:50:30 +0100
From:   "paul.kocialkowski@bootlin.com" <paul.kocialkowski@bootlin.com>
To:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: ohci: Default to per-port over-current
 protection
Message-ID: <YAgK9mZppnAYQVvP@aptenodytes>
References: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
 <X+huemxT9XOeDi5E@aptenodytes>
 <20210109212608.GB1136657@rowland.harvard.edu>
 <83ed9f3929bd064b54bb9903cd489adde442e1c7.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OySCGVbEh1Xz1OCy"
Content-Disposition: inline
In-Reply-To: <83ed9f3929bd064b54bb9903cd489adde442e1c7.camel@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OySCGVbEh1Xz1OCy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 19 Jan 21, 01:09, Hamish Martin wrote:
> On Sat, 2021-01-09 at 16:26 -0500, Alan Stern wrote:
> > On Sun, Dec 27, 2020 at 12:22:34PM +0100, Paul Kocialkowski wrote:
> > > Hi,
> >=20
> > Sorry it has taken so long to respond to this.  The holidays
> > intervened,=20
> > but that's no excuse.
> I'm sorry too, same reason/non-excuse. Thanks for your thorough report
> on the issue my changes caused and pass on my apologies to your Mom!

Aaaand sorry for the delay here as well, I've been busy with other things
lately. No problem at all :)

> > > On Fri 11 Sep 20, 09:25, Hamish Martin wrote:
> > > > Some integrated OHCI controller hubs do not expose all ports of
> > > > the hub
> > > > to pins on the SoC. In some cases the unconnected ports generate
> > > > spurious over-current events. For example the Broadcom
> > > > 56060/Ranger 2 SoC
> > > > contains a nominally 3 port hub but only the first port is wired.
> > > >=20
> > > > Default behaviour for ohci-platform driver is to use global over-
> > > > current
> > > > protection mode (AKA "ganged"). This leads to the spurious over-
> > > > current
> > > > events affecting all ports in the hub.
> > > >=20
> > > > We now alter the default to use per-port over-current protection.
> > >=20
> > > This specific patch lead to breaking OHCI on my mom's laptop (whom
> > > was about
> > > to buy a new one thinking the hardware had failed). I get no OHCI
> > > interrupt at
> > > all and no USB 1 device is ever detected.
> > >=20
> > > I haven't really found a reasonable explanation about why that is,
> > > but here
> > > are some notes I was able to collect:
> > > - The issue showed up on 5.8,18 and 5.9.15, which don't include the
> > > patch
> > >   from this series that sets distrust_firmware =3D false; This
> > > results in the NPS
> > >   bit being set via OHCI_QUIRK_HUB_POWER.
> > > - Adding val &=3D ~RH_A_PSM; (as was done before this change) solves
> > > the issue
> > >   which is weird because the bit is supposed to be inactive when
> > > NPS is set;
> > > - Setting ohci_hcd.distrust_firmware=3D0 in the cmdline results in
> > > not setting
> > >   the NPS bit and also solves the issue;
> > > - The initial value of the register at function entry is 0x1001104
> > > (PSM bit
> > >   is set, NPS is unset);
> > > - The OHCI controller is the following:
> > > 00:03.0 USB controller: Silicon Integrated Systems [SiS] USB 1.1
> > > Controller (rev 0f) (prog-if 10 [OHCI])
> > > 	Subsystem: ASUSTeK Computer Inc. Device 1aa7
> >=20
> > Great reporting -- thanks.
> >=20
> > > Does that make any sense to you?
> > >=20
> > > I really wonder what a proper fix could be and here are some
> > > suggestions:
> > > - Adding a specific quirk to clear the PSM bit for this hardware
> > > which seems to
> > >   consider the bit regardless of NPS;
> >=20
> > We don't need a quirk for this.  There shouldn't be anything wrong
> > with=20
> > _always_ clearing PSM whenever NPS is set, since the controller is=20
> > supposed to ignore PSM under that condition.
> >=20
> > Would you like to submit a patch for this?
> Yes, I think that looks reasonable too.

Agreed, I'll craft a patch in this direction and have you CC-ed.

> > > - Adding the patch that sets distrust_firmware =3D false to stable
> > > branches;
> >=20
> > That's certainly reasonable.  Nobody has reported any problems caused
> > by=20
> > that patch, so adding it to the stable branches should be safe
> > enough.
> >=20
> Yes, that is probably a good idea. I've carried both patches locally
> for my systems.

Thanks for requesting it :)

Cheers,

Paul

> > > What do you think?
> >=20
> > We could even do both.  That would help if, for example, somebody=20
> > decided to set ohci_hcd.distrust_firmware=3Dtrue explicitly.
> I think both might be best.
>=20
> >=20
> > Greg, in the meantime can we have commit c4005a8f65ed ("usb: ohci:
> > Make=20
> > distrust_firmware param default to false") added to all the stable=20
> > kernels which have back-ported versions of commit b77d2a0a223b?
> >=20
> > Alan Stern
> I second that.
>=20
> Thanks,
> Hamish Martin
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--OySCGVbEh1Xz1OCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAICvYACgkQ3cLmz3+f
v9FrSQf+LFYcO3wfTOl8abvNBEaLSA9FYypMnm17gOEPVfvVivfzX1KASkP/1Vw9
p0ml4+VPSnpIybsP461XOE4tXgad2g4Y1FL/gLzPQpYhJl+khiFVQnFyOMerv+q7
DAES5mh79PriBntIyYWjzJg96bjVHTfDQwslsQe3kr2QXYXcJSEkXb5lF+CAlqea
JbqHPEghypoZEQ7vf7Dab4MnIOn8Hw/UiTTpgYgTv49NQqTLGxZKRwm776xxw6wy
BMzGxnSYsBetjxSEImc9tQ5p5ydObGWH7K+mMgTLEeYGC+yH0p+vtbcF8XR/9Cp5
qnNnqbtjwuhGRo5Mw/ICM0vK7YvpWw==
=GwoA
-----END PGP SIGNATURE-----

--OySCGVbEh1Xz1OCy--
