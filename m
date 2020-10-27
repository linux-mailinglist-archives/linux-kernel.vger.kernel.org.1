Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E929A79F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505750AbgJ0JTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407507AbgJ0JTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:19:01 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690B02224E;
        Tue, 27 Oct 2020 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603790340;
        bh=APYsaGexIvLPnOo7r338WsGJoQsC/lI3MZUO2JiEcok=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZZ2JJUagdVkVauWfqh+GeLuc18v3DO49rvP6+w7LJoihNvXtPnAe+tUBCUU3KTnXH
         YRy+D9OXJRd4BxsVel27e4bTcQvwgEULUJOxu6qWLS8SjSUdDFp7a3X2tE1AlLE4QW
         7W4ukaneaGAY6iZ6a6dGa7Kbt0/gsju4IeyyOGW4=
From:   Felipe Balbi <balbi@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/3] usb: dwc3: ulpi: Replace CPU-based busyloop with
 Protocol-based one
In-Reply-To: <20201010222351.7323-3-Sergey.Semin@baikalelectronics.ru>
References: <20201010222351.7323-1-Sergey.Semin@baikalelectronics.ru>
 <20201010222351.7323-3-Sergey.Semin@baikalelectronics.ru>
Date:   Tue, 27 Oct 2020 11:18:51 +0200
Message-ID: <87h7qgc9hg.fsf@kernel.org>
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

> Originally the procedure of the ULPI transaction finish detection has been
> developed as a simple busy-loop with just decrementing counter and no
> delays. It's wrong since on different systems the loop will take a
> different time to complete. So if the system bus and CPU are fast enough
> to overtake the ULPI bus and the companion PHY reaction, then we'll get to
> take a false timeout error. Fix this by converting the busy-loop procedure
> to take the standard bus speed, address value and the registers access
> mode into account for the busy-loop delay calculation.
>
> Here is the way the fix works. It's known that the ULPI bus is clocked
> with 60MHz signal. In accordance with [1] the ULPI bus protocol is created
> so to spend 5 and 6 clock periods for immediate register write and read
> operations respectively, and 6 and 7 clock periods - for the extended
> register writes and reads. Based on that we can easily pre-calculate the
> time which will be needed for the controller to perform a requested IO
> operation. Note we'll still preserve the attempts counter in case if the
> DWC USB3 controller has got some internals delays.
>
> [1] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
>     October 20, 2004, pp. 30 - 36.
>
> Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/usb/dwc3/ulpi.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
> index 20f5d9aba317..0dbc826355a5 100644
> --- a/drivers/usb/dwc3/ulpi.c
> +++ b/drivers/usb/dwc3/ulpi.c
> @@ -7,6 +7,8 @@
>   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>   */
>=20=20
> +#include <linux/delay.h>
> +#include <linux/time64.h>
>  #include <linux/ulpi/regs.h>
>=20=20
>  #include "core.h"
> @@ -17,12 +19,22 @@
>  		DWC3_GUSB2PHYACC_ADDR(ULPI_ACCESS_EXTENDED) | \
>  		DWC3_GUSB2PHYACC_EXTEND_ADDR(a) : DWC3_GUSB2PHYACC_ADDR(a))
>=20=20
> -static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
> +#define DWC3_ULPI_BASE_DELAY	DIV_ROUND_UP(NSEC_PER_SEC, 60000000L)
> +
> +static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
>  {
> +	unsigned long ns =3D 5L * DWC3_ULPI_BASE_DELAY;
>  	unsigned count =3D 1000;
>  	u32 reg;
>=20=20
> +	if (addr >=3D ULPI_EXT_VENDOR_SPECIFIC)
> +		ns +=3D DWC3_ULPI_BASE_DELAY;
> +
> +	if (read)
> +		ns +=3D DWC3_ULPI_BASE_DELAY;
> +
>  	while (count--) {
> +		ndelay(ns);

could we allow for a sleep here instead of a delay? Also, I wonder if
you need to make this so complex or should we just take the larger
access time of 7 clock cycles.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+X5fsRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbFOA//RLMezPqI1XnIaQfE6WN7WFWhwAEzYoiJ
dRa0fDLg2AsievUsW29QDN25/0FrGsZKDrQSy4u13LW41ba6H4d2J+T3vdTlm5xI
ug1cSMaV49aKpQo1oE8KEsl2b5S4Fc1AwZXtDeY3m4phgDgszu/XUTQY0cC5/jzq
Z+TARubUj6soFIcICM2KNZishegmu9i2jOjHdvizA+CRoiPxCAmzsqfllgE69Imj
OZrmbgQeNg5uAD7eOS0cOLWAAggU3LNysMDTlQ5cp/An3OxotyIj0NzpdMfjptzU
c6Gke3nXTOraV7U0xR/BPtM7v4g9xE+c9o/IoYkfbgnRE1hnvZuKIfb/ksrL6X7F
1DZZQ2GGaZ0ThOZ0B+u3B3DEnP5PHm62E2zcni09D/b4rzJwVOWZUY2IqziXH6qO
99sz9tnFgX3g573UB24k5MY5J5a5zynbl7YVouqCf6loCuzCBM7iuCgXKw0II5/y
aVutZWTtOOrDn3UsEqjrM1UtwTLIUM/o3RP03SQLBdJnm7Szav8I69HQ0X3gFqFg
mKUwadHbpx3zk8UKYNEkM3T4pQ/IF+W83QsZ1T6TojUFzLHs0xIaoZNW5EQJwEwz
VzHt24Q9T+aAoOWunH5h5IKQk1uQmjlcZCIk8duZI8mQT5TgX+5fOucQnAFDlNSn
dS5781fafjw=
=Izn9
-----END PGP SIGNATURE-----
--=-=-=--
