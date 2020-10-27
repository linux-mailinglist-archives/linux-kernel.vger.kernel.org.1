Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266129A785
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439185AbgJ0JPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411637AbgJ0JPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:15:34 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1A722258;
        Tue, 27 Oct 2020 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603790132;
        bh=o5KRhvwObRIIQc6rBh3vrmdNSSuJOyeCIk62E98RJfg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=z1oLA+RUDnVAlZYMLiieV+BGMBhdaCEYnMv73I489vB5gwnejH1WitUaHxSmQv1dI
         GXhsGoa37oVDFUlwBfPf8vej2pp+V5DdXCXxFUq+OGNM7w2lx5k8vz6rDvDE5kq1Wj
         KK478ZVX48QWaYrIoOSU6Zf43fep59D55DCNfAYg=
From:   Felipe Balbi <balbi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Youn <John.Youn@synopsys.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: dwc3: ulpi: Use VStsDone to detect PHY regs
 access completion
In-Reply-To: <20201010222351.7323-2-Sergey.Semin@baikalelectronics.ru>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
 <20201010222351.7323-2-Sergey.Semin@baikalelectronics.ru>
Date:   Tue, 27 Oct 2020 11:15:24 +0200
Message-ID: <87k0vcc9n7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Serge Semin <Sergey.Semin@baikalelectronics.ru> writes:

> In accordance with [1] the DWC_usb3 core sets the GUSB2PHYACCn.VStsDone
> bit when the PHY vendor control access is done and clears it when the
> application initiates a new transaction. The doc doesn't say anything
> about the GUSB2PHYACCn.VStsBsy flag serving for the same purpose. Moreover
> we've discovered that the VStsBsy flag can be cleared before the VStsDone
> bit. So using the former as a signal of the PHY control registers
> completion might be dangerous. Let's have the VStsDone flag utilized
> instead then.
>
> [1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
>     Databook, 2.70a, December 2013, p.388
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/usb/dwc3/core.h | 1 +
>  drivers/usb/dwc3/ulpi.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 2f04b3e42bf1..8d5e5bba1bc2 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -284,6 +284,7 @@
>=20=20
>  /* Global USB2 PHY Vendor Control Register */
>  #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
> +#define DWC3_GUSB2PHYACC_DONE		BIT(24)
>  #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
>  #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
>  #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
> diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
> index e6e6176386a4..20f5d9aba317 100644
> --- a/drivers/usb/dwc3/ulpi.c
> +++ b/drivers/usb/dwc3/ulpi.c
> @@ -24,7 +24,7 @@ static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
>=20=20
>  	while (count--) {
>  		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
> -		if (!(reg & DWC3_GUSB2PHYACC_BUSY))
> +		if (reg & DWC3_GUSB2PHYACC_DONE)

are you sure this works in all supported versions of the core?

John, could you confirm this for us?

thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+X5SwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZHxA//fg2g3FbmW01YsryQ46l99nUvp3dxAsRX
WasKiojNKREaCkd7bG6XH8oFt+ibwt8Qhdf4yuFuWgNL1+DfH6i91jj2Rg3aBE10
CnslZktzo3cph5My6OLb9QZy0ATXkR59K8tJg7WKkzIFtDHMULYRvUDKF+inwnTC
FHnHbe9JLNwhYtgLg/nSZnh7V3Z6CEYD1H9ToAMWQaDh7nb6+W2RqUCaNovSUe4a
jB8qrBlKA4hcHV1Xb3XRAHHJ5vFkSR2lSLZlcQLwhz9ACjeE5YEnOsYzZJXk+IB2
jn2NSqc2kW7UyeMoiSO9Vba2tjuEv2u3cgIQoqDzqk/mbCXgcmCtQVRRhnOv/XfD
Ar7WdVAOsDpEgpgPHkRA+h5Lj9+7kmy0kvUuj8pDb4lydsOozc0UG1xpfb/SYyYH
u28wFrvlnOjWgdCUmnebT1Ar/gP1KT8L/XQWl2ru+Av3FRXqLxjUPDuv1Xo9/Obf
TNAsIiqp4thvq39XRIVqMwXcU8zOVWapFFD+Rup0rQq7UgZr+ikRuT6nyqBVrq0U
3n3hiK+Q8z6GnnDjwQ8Mn+1/JoG0KKrY+6fCYNkX6/LaCxKEQpKuhRO20GEDSjy8
Gy/jtG61+yjwCaUd1QY7KAn5Tv+mmCkA5BVXMA/koBFvOGnTFaqSM2xun2LIHOcG
Od0Jaw8SHyc=
=UFn6
-----END PGP SIGNATURE-----
--=-=-=--
