Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0CD287237
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgJHKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:05:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJHKF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:05:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 983DBAD20;
        Thu,  8 Oct 2020 10:05:26 +0000 (UTC)
Message-ID: <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        will@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com,
        hch@lst.de, linux-arm-kernel@lists.infradead.org
Date:   Thu, 08 Oct 2020 12:05:25 +0200
In-Reply-To: <20201002115541.GC7034@gaia>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
         <20201001161740.29064-2-nsaenzjulienne@suse.de>
         <20201001171500.GN21544@gaia> <20201001172320.GQ21544@gaia>
         <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
         <20201002115541.GC7034@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UgRFrRCNh36xLg4FQaLM"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UgRFrRCNh36xLg4FQaLM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin, sorry for the late reply.

On Fri, 2020-10-02 at 12:55 +0100, Catalin Marinas wrote:
> On Thu, Oct 01, 2020 at 07:31:19PM +0200, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-10-01 at 18:23 +0100, Catalin Marinas wrote:
> > > On Thu, Oct 01, 2020 at 06:15:01PM +0100, Catalin Marinas wrote:
> > > > On Thu, Oct 01, 2020 at 06:17:37PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > > > index 4602e467ca8b..cd0d115ef329 100644
> > > > > --- a/drivers/of/fdt.c
> > > > > +++ b/drivers/of/fdt.c
> > > > > @@ -25,6 +25,7 @@
> > > > >  #include <linux/serial_core.h>
> > > > >  #include <linux/sysfs.h>
> > > > >  #include <linux/random.h>
> > > > > +#include <linux/dma-direct.h>	/* for zone_dma_bits */
> > > > > =20
> > > > >  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> > > > >  #include <asm/page.h>
> > > > > @@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
> > > > >  	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > > >  }
> > > > > =20
> > > > > +void __init early_init_dt_update_zone_dma_bits(void)
> > > > > +{
> > > > > +	unsigned long dt_root =3D of_get_flat_dt_root();
> > > > > +
> > > > > +	if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
> > > > > +		zone_dma_bits =3D 30;
> > > > > +}
> > > >=20
> > > > I think we could keep this entirely in the arm64 setup_machine_fdt(=
) and
> > > > not pollute the core code with RPi4-specific code.
> > >=20
> > > Actually, even better, could we not move the check to
> > > arm64_memblock_init() when we initialise zone_dma_bits?
> >=20
> > I did it this way as I vaguely remembered Rob saying he wanted to centr=
alise
> > all early boot fdt code in one place. But I'll be happy to move it ther=
e.
>=20
> I can see Rob replied and I'm fine if that's his preference. However,
> what I don't particularly like is that in the arm64 code, if
> zone_dma_bits =3D=3D 24, we set it to 32 assuming that it wasn't touched =
by
> the early_init_dt_update_zone_dma_bits(). What if at some point we'll
> get a platform that actually needs 24 here (I truly hope not, but just
> the principle of relying on magic values)?
>=20
> So rather than guessing, I'd prefer if the arch code can override
> ZONE_DMA_BITS_DEFAULT. Then, in arm64, we'll just set it to 32 and no
> need to explicitly touch the zone_dma_bits variable.

Yes, sonds like the way to go. TBH I wasn't happy with that solution either=
,
but couldn't think of a nicer alternative.

Sadly I just realised that the series is incomplete, we have RPi4 users tha=
t
want to boot unsing ACPI, and this series would break things for them. I'll
have a word with them to see what we can do for their use-case.

Regards,
Nicolas


--=-UgRFrRCNh36xLg4FQaLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9+5GUACgkQlfZmHno8
x/6e8wf9EJ0i1Wi9BCOQEMRii/Avn31umkWy/c6brw125hfV8Jcwwn6RlD9oTrD6
57UaLxdLJjFjZcCHmPhOG7zcMwfsP/Ft5hmeS6ECAgOl3bL6jDRpnrQ80+gEO3U2
rJ0sgrVHJp+ZC0Yf1HedSnj0EpgjbQFc3iPJHEW19XVLbZ61cu8keEKDZevaHONm
BssWhdVqPaNW8Z9LuT04V4y+JXxLCjflB88QQD+UA5BbdLLRPn2DGZKErUwyyF8O
U68UbaCmHEPIddLXLdHde657lQS0pT99yCJzyGA8S9k3XbNLcPK304WYZj1Qib8Z
DI2imsq4V1HT3TAyebIj++LJgx/Uyg==
=Sv3m
-----END PGP SIGNATURE-----

--=-UgRFrRCNh36xLg4FQaLM--

