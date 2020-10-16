Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81E1290847
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410057AbgJPP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410005AbgJPP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C5F2AD87;
        Fri, 16 Oct 2020 15:26:58 +0000 (UTC)
Message-ID: <0f0b7021e85a832afd42c6f9016158d6d8b0b28b.camel@suse.de>
Subject: Re: [RFC] of/platform: Create device link between simple-mfd and
 its children
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Oct 2020 17:26:56 +0200
In-Reply-To: <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
References: <20201015114346.15743-1-nsaenzjulienne@suse.de>
         <CAL_JsqLvzsdAfx56jQqPSd1r=P20C8DURKKZ9kke-L2owqr0fg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qL4wvvXdx8WWS17CadgZ"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qL4wvvXdx8WWS17CadgZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-16 at 09:38 -0500, Rob Herring wrote:
> On Thu, Oct 15, 2020 at 6:43 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > 'simple-mfd' usage implies there might be some kind of resource sharing
> > between the parent device and its children.
>=20
> It does? No! The reason behind simple-mfd was specifically because
> there was no parent driver or dependency on the parent. No doubt
> simple-mfd has been abused.

Fair enough, so we're doing things wrong. Just for the record, I'm looking =
at
RPi=C2=B4s firmware interface:

	firmware: firmware {
		compatible =3D "raspberrypi,bcm2835-firmware", "simple-mfd";
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		mboxes =3D <&mailbox>;

		firmware_clocks: clocks {
			compatible =3D "raspberrypi,firmware-clocks";
			#clock-cells =3D <1>;
		};

		reset: reset {
			compatible =3D "raspberrypi,firmware-reset";
			#reset-cells =3D <1>;
		};
		[...]
	};

Note that "raspberrypi,bcm2835-firmware" has a driver, it's not just a
placeholder. Consumer drivers get a handle to RPi's firmware interface thro=
ugh
the supplier's API, rpi_firmware_get(). The handle to firmware becomes
meaningless if it is unbinded, which I want to protect myself against.

A simpler solution would be to manually create a device link between both
devices ("raspberrypi,bcm2835-firmware" and "raspberrypi,firmware-clocks" f=
or
example) upon calling rpi_firmware_get(). But I wanted to try addressing th=
e
problem in a generic way first.

Regards,
Nicolas


--=-qL4wvvXdx8WWS17CadgZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+Ju8AACgkQlfZmHno8
x/5rNgf/RWzw8B+m3lZjCQJdOUIVBcSgEtXTgg+1Rw64UrNVIYeCYwRa8GbiXN6Y
KzbRjnNiAIFLworJ8rpWKfKY52/Y39CJhgbXem0tM9BWJE7gLRZA8f+B0GfvXvzz
/bAFMkcywkakmPssQ94zslmWhgiE3zoYQD1sSVesYBV/0cqt/2TXt8wXsdyybzbD
zMLs+vkCHhQIVaYNmmB10wLmiBo9g7PMFRD9panuRsaQ1Yyrk+NvgPcOCYYtyRxS
NUBmVHMcbtYv+NvxGatfp8q5kyhTUeIubYmNHXgaovlo71Rg2HCWeWZkaj5TkX7s
6n7yNJPNKEE+DcmOcwM61NaI9aYurA==
=2J8u
-----END PGP SIGNATURE-----

--=-qL4wvvXdx8WWS17CadgZ--

