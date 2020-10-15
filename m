Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2690D28EF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgJOJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:16:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbgJOJQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:16:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FF6AAC97;
        Thu, 15 Oct 2020 09:16:04 +0000 (UTC)
Message-ID: <607e809796bc57ee649390824c4ab2bb767b00ba.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce
 of_dma_get_max_cpu_address()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Thu, 15 Oct 2020 11:16:02 +0200
In-Reply-To: <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-4-nsaenzjulienne@suse.de>
         <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
         <CAMj1kXFnLEpNTZVq16YgBomkZwwdGsH89OSELsYeiee4P+GLPg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sQ2v3OKZpIeLs71fPeU6"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sQ2v3OKZpIeLs71fPeU6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 08:56 +0200, Ard Biesheuvel wrote:
> On Thu, 15 Oct 2020 at 00:03, Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > Introduce of_dma_get_max_cpu_address(), which provides the highest CP=
U
> > > physical address addressable by all DMA masters in the system. It's
> > > specially useful for setting memory zones sizes at early boot time.
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >=20
> > > ---
> > >=20
> > > Changes since v2:
> > >  - Use PHYS_ADDR_MAX
> > >  - return phys_dma_t
> > >  - Rename function
> > >  - Correct subject
> > >  - Add support to start parsing from an arbitrary device node in orde=
r
> > >    for the function to work with unit tests
> > >=20
> > >  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h   |  7 +++++++
> > >  2 files changed, 49 insertions(+)
> > >=20
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index eb9ab4f1e80b..b5a9695aaf82 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, c=
onst struct bus_dma_region **map)
> > >  }
> > >  #endif /* CONFIG_HAS_DMA */
> > >=20
> > > +/**
> > > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable fo=
r DMA
> > > + * @np: The node to start searching from or NULL to start from the r=
oot
> > > + *
> > > + * Gets the highest CPU physical address that is addressable by all =
DMA masters
> > > + * in the system (or subtree when np is non-NULL). If no DMA constra=
ined device
> > > + * is found, it returns PHYS_ADDR_MAX.
> > > + */
> > > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np=
)
> > > +{
> > > +       phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> >=20
> > One issue with using phys_addr_t is it may be 32-bit even though the
> > DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
> > the truncation is fine here? Maybe not.
> >=20
>=20
> PHYS_ADDR_MAX is the max addressable CPU address on the system, and so
> it makes sense to use it for the return type, and for the preliminary
> return value: this is actually what /prevents/ truncation, because we
> will only overwrite max_cpu_addr if the new u64 value is lower.
>=20

Actually I now see how things might go south.

> > > +       if (ranges && len) {
> > > +               of_dma_range_parser_init(&parser, np);
> > > +               for_each_of_range(&parser, &range)
> > > +                       if (range.cpu_addr + range.size > cpu_end)
> > > +                               cpu_end =3D range.cpu_addr + range.si=
ze;

If cpu_end hits 0x1_00000000, it'll overflow to 0. This is possible on 32-b=
it
systems (LPAE or not). And something similar might happen on LPAE disabled
systems.

I could add some extra logic, something like:

	/* We overflowed */
	if (cpu_end < range.cpu_addr)
		cpu_end =3D PHYS_ADDR_MAX;

Which is not perfect but will cover most sensible cases.

Or simply deal internally in u64s, and upon returning, check if "max_cpu_ad=
dr"
falls higher than PHYS_ADDR_MAX.

> > > +
> > > +               if (max_cpu_addr > cpu_end)
> > > +                       max_cpu_addr =3D cpu_end;
> > > +       }
> > > +
> > > +       for_each_available_child_of_node(np, child) {
> > > +               subtree_max_addr =3D of_dma_get_max_cpu_address(child=
);
> > > +               if (max_cpu_addr > subtree_max_addr)
> > > +                       max_cpu_addr =3D subtree_max_addr;
> > > +       }
> > > +
> > > +       return max_cpu_addr;
> > > +}

Regards,
Nicolas


--=-sQ2v3OKZpIeLs71fPeU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IE1IACgkQlfZmHno8
x/48cAf/f4EAh2ApzAtvkP3faJslUt27+oT3TMeyHfRGhMr3i4A+86Y9VRAHTnf6
D8Cv30Frgv5i6wg3cTNmZKcjNF5fF6VV+qChZnKZjv+v2F8PDTr169C/c6hRINWD
JgANJ6T7JV6okI5WkEJHD/j9YFtdvBFltt6NqXmds6VewS6mOLVXRxj+N9qP+V5P
caGCEU9eJt9sqRRwL37RX80slzlHggLsjc4RigF61x/TDzjztg8UdFocYuUTvJCW
bfYgyhq40knvU84wyiCvNhOVSKIVgtYXNf5usrKV/mm886P76nUx1LBek4X0aMKq
9w/J+VYneK8lMET/YF6FKVHt/y5TcQ==
=V7Cs
-----END PGP SIGNATURE-----

--=-sQ2v3OKZpIeLs71fPeU6--

