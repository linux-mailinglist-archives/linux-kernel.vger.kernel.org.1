Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7052A296099
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900580AbgJVODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:03:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894676AbgJVODV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B00A3B181;
        Thu, 22 Oct 2020 14:03:19 +0000 (UTC)
Message-ID: <e1da254cdf27edb3de798058bb234d8ded80267b.camel@suse.de>
Subject: Re: [PATCH v4 3/7] of/address: Introduce
 of_dma_get_max_cpu_address()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Date:   Thu, 22 Oct 2020 16:03:16 +0200
In-Reply-To: <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
         <20201021123437.21538-4-nsaenzjulienne@suse.de>
         <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UvLPWvl3/tbDetGzXF2K"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UvLPWvl3/tbDetGzXF2K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 14:23 +0200, Ard Biesheuvel wrote:
> > +/**
> > + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for =
DMA
> > + * @np: The node to start searching from or NULL to start from the roo=
t
> > + *
> > + * Gets the highest CPU physical address that is addressable by all DM=
A masters
> > + * in the sub-tree pointed by np, or the whole tree if NULL is passed.=
 If no
> > + * DMA constrained device is found, it returns PHYS_ADDR_MAX.
> > + */
> > +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > +{
> > +       phys_addr_t max_cpu_addr =3D PHYS_ADDR_MAX;
> > +       struct of_range_parser parser;
> > +       phys_addr_t subtree_max_addr;
> > +       struct device_node *child;
> > +       struct of_range range;
> > +       const __be32 *ranges;
> > +       u64 cpu_end =3D 0;
> > +       int len;
> > +
> > +       if (!np)
> > +               np =3D of_root;
> > +
> > +       ranges =3D of_get_property(np, "dma-ranges", &len);
> > +       if (ranges && len) {
> > +               of_dma_range_parser_init(&parser, np);
> > +               for_each_of_range(&parser, &range)
> > +                       if (range.cpu_addr + range.size > cpu_end)
> > +                               cpu_end =3D range.cpu_addr + range.size=
;
>=20
>=20
> Shouldn't this be 'range.cpu_addr + range.size - 1' ?

Yes, I agree. In that case arm64's counterpart should be:

	zone_dma_bits =3D max(32U, fls64(of_dma_get_max_cpu_address(NULL)));

I'll update it.

Regards,
Nicolas


--=-UvLPWvl3/tbDetGzXF2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+RkSUACgkQlfZmHno8
x/6WbQgAkVcDhB3SycLRGqPjX7WUnNsAxd8ccdYnBA32Lo5ualAFZpZH1lAjlBrF
fsE03ZH1EMEFjaV5UJfaquybvyGf4z6boCw+jX30MUDLJePhl3XTMfWhIjTN81t+
8ZW+wKCaL0M+F1hMjE4wGtk4toTaeYHNHxB8t9DKIwxjZ4mUE5sPBmpRQZv6eK/t
YezVQWfjCjOP2MyY76PzZ54F4qSHXBQnsfZciol8tOCFARX/e0HfZtHtsILye37P
nRydYfQsLGMhkDoDUDK4o529hPYTRY4REnEp1lbD0EUiXvpR/ZbnKMTLGz6y5uoQ
2KCLhICIqbSK6ab+UBgXrHFRIRoavA==
=hL5X
-----END PGP SIGNATURE-----

--=-UvLPWvl3/tbDetGzXF2K--

