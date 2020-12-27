Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6F2E30E8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL0LXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 06:23:20 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43973 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgL0LXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 06:23:19 -0500
Received: from aptenodytes (lns-bzn-59-82-252-129-67.adsl.proxad.net [82.252.129.67])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F2D05200002;
        Sun, 27 Dec 2020 11:22:35 +0000 (UTC)
Date:   Sun, 27 Dec 2020 12:22:34 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: ohci: Default to per-port over-current
 protection
Message-ID: <X+huemxT9XOeDi5E@aptenodytes>
References: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Smv2TijY037QtWlE"
Content-Disposition: inline
In-Reply-To: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Smv2TijY037QtWlE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 11 Sep 20, 09:25, Hamish Martin wrote:
> Some integrated OHCI controller hubs do not expose all ports of the hub
> to pins on the SoC. In some cases the unconnected ports generate
> spurious over-current events. For example the Broadcom 56060/Ranger 2 SoC
> contains a nominally 3 port hub but only the first port is wired.
>=20
> Default behaviour for ohci-platform driver is to use global over-current
> protection mode (AKA "ganged"). This leads to the spurious over-current
> events affecting all ports in the hub.
>=20
> We now alter the default to use per-port over-current protection.

This specific patch lead to breaking OHCI on my mom's laptop (whom was about
to buy a new one thinking the hardware had failed). I get no OHCI interrupt=
 at
all and no USB 1 device is ever detected.

I haven't really found a reasonable explanation about why that is, but here
are some notes I was able to collect:
- The issue showed up on 5.8,18 and 5.9.15, which don't include the patch
  from this series that sets distrust_firmware =3D false; This results in t=
he NPS
  bit being set via OHCI_QUIRK_HUB_POWER.
- Adding val &=3D ~RH_A_PSM; (as was done before this change) solves the is=
sue
  which is weird because the bit is supposed to be inactive when NPS is set;
- Setting ohci_hcd.distrust_firmware=3D0 in the cmdline results in not sett=
ing
  the NPS bit and also solves the issue;
- The initial value of the register at function entry is 0x1001104 (PSM bit
  is set, NPS is unset);
- The OHCI controller is the following:
00:03.0 USB controller: Silicon Integrated Systems [SiS] USB 1.1 Controller=
 (rev 0f) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 1aa7

Does that make any sense to you?

I really wonder what a proper fix could be and here are some suggestions:
- Adding a specific quirk to clear the PSM bit for this hardware which seem=
s to
  consider the bit regardless of NPS;
- Adding the patch that sets distrust_firmware =3D false to stable branches;

What do you think?

Cheers,

Paul

> This patch results in the following configuration changes depending
> on quirks:
> - For quirk OHCI_QUIRK_SUPERIO no changes. These systems remain set up
>   for ganged power switching and no over-current protection.
> - For quirk OHCI_QUIRK_AMD756 or OHCI_QUIRK_HUB_POWER power switching
>   remains at none, while over-current protection is now guaranteed to be
>   set to per-port rather than the previous behaviour where it was either
>   none or global over-current protection depending on the value at
>   function entry.
>=20
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> ---
>=20
> Notes:
>     Changes in v2:
>     - remove clearing of RH_A_PSM in OHCI_QUIRK_HUB_POWER block.
>=20
>  drivers/usb/host/ohci-hcd.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index dd37e77dae00..2845ea328a06 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -673,20 +673,24 @@ static int ohci_run (struct ohci_hcd *ohci)
> =20
>  	/* handle root hub init quirks ... */
>  	val =3D roothub_a (ohci);
> -	val &=3D ~(RH_A_PSM | RH_A_OCPM);
> +	/* Configure for per-port over-current protection by default */
> +	val &=3D ~RH_A_NOCP;
> +	val |=3D RH_A_OCPM;
>  	if (ohci->flags & OHCI_QUIRK_SUPERIO) {
> -		/* NSC 87560 and maybe others */
> +		/* NSC 87560 and maybe others.
> +		 * Ganged power switching, no over-current protection.
> +		 */
>  		val |=3D RH_A_NOCP;
> -		val &=3D ~(RH_A_POTPGT | RH_A_NPS);
> -		ohci_writel (ohci, val, &ohci->regs->roothub.a);
> +		val &=3D ~(RH_A_POTPGT | RH_A_NPS | RH_A_PSM | RH_A_OCPM);
>  	} else if ((ohci->flags & OHCI_QUIRK_AMD756) ||
>  			(ohci->flags & OHCI_QUIRK_HUB_POWER)) {
>  		/* hub power always on; required for AMD-756 and some
> -		 * Mac platforms.  ganged overcurrent reporting, if any.
> +		 * Mac platforms.
>  		 */
>  		val |=3D RH_A_NPS;
> -		ohci_writel (ohci, val, &ohci->regs->roothub.a);
>  	}
> +	ohci_writel(ohci, val, &ohci->regs->roothub.a);
> +
>  	ohci_writel (ohci, RH_HS_LPSC, &ohci->regs->roothub.status);
>  	ohci_writel (ohci, (val & RH_A_NPS) ? 0 : RH_B_PPCM,
>  						&ohci->regs->roothub.b);
> --=20
> 2.28.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Smv2TijY037QtWlE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl/obnoACgkQ3cLmz3+f
v9H38Qf/bak2ehuKVY7Ky7MD+Yo2z98TvUwbvJMz4t6ncISe+LaeOfCjnVEiw0Gp
TUZA2OUDR9pTFuPg7KwYzOGGvRR2DV+b3YDNOawTs2enzC62ToFldHGUuezdL/kN
Zatg86b4vECQDldjqKNmVP7Z8ttu31RXzdOBi0CVZNNz94m+ytsA5d966G43iVmB
/bLz5kQ+j9MDQulx+IUQcALDUAEoIG9hGoqPNN8/Ci/Xex1ul3N2giRxk2SQk0hB
n4V/1Nwif4TWUdwHnH7WI4JWGey7+rTODDR4uxDfedzL6+dgHeXuIX2aSA0LbcQu
m9fcSb1m6aXjK2f8VQoPajo3wUY2KQ==
=khjv
-----END PGP SIGNATURE-----

--Smv2TijY037QtWlE--
