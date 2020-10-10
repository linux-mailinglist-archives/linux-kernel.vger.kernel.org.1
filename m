Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9790628A327
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgJJW51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732220AbgJJTnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:43:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08B5CACAA;
        Sat, 10 Oct 2020 10:53:22 +0000 (UTC)
Message-ID: <e62784bde26293c26fcc2fee50133dc445c084ab.camel@suse.de>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Sat, 10 Oct 2020 12:53:19 +0200
In-Reply-To: <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
References: <20201001172320.GQ21544@gaia>
         <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
         <20201002115541.GC7034@gaia>
         <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
         <20201009071013.GA12208@lst.de>
         <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
         <513833810c15b5efeab7c3cbae1963a78c71a79f.camel@suse.de>
         <CAMj1kXGP_OTKgqMT0-+t3=7EKDY26y9n9xjLodSF1E-mUCe9tg@mail.gmail.com>
         <20201009152433.GA19953@e121166-lin.cambridge.arm.com>
         <CAMj1kXFuqw3qNRAB78OzvMws+t7=B6L8pASA36D2fxXobbvpUA@mail.gmail.com>
         <20201009171051.GL23638@gaia>
         <CAMj1kXEWeqGVr=QV7zQ+dXBK=t_Lh+W9q1+kLLdBw8=Pj798Ng@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qkulNlIkIv1qKYpoJFMk"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qkulNlIkIv1qKYpoJFMk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-10 at 12:36 +0200, Ard Biesheuvel wrote:
> On Fri, 9 Oct 2020 at 19:10, Catalin Marinas <catalin.marinas@arm.com> wr=
ote:
> > On Fri, Oct 09, 2020 at 06:23:06PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 9 Oct 2020 at 17:24, Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > > We can move this check to IORT code and call it from arm64 if it
> > > > can be made to work.
> > >=20
> > > Finding the smallest value in the IORT, and assigning it to
> > > zone_dma_bits if it is < 32 should be easy. But as I understand it,
> > > having these separate DMA and DMA32 zones is what breaks kdump, no? S=
o
> > > how is this going to fix the underlying issue?
> >=20
> > If zone_dma_bits is 32, ZONE_DMA32 disappears into ZONE_DMA (GFP_DMA32
> > allocations fall back to ZONE_DMA).
> >=20
> > kdump wants DMA-able memory and, without a 30-bit ZONE_DMA, that would
> > be the bottom 32-bit. With the introduction of ZONE_DMA, this suddenly
> > became 1GB. We could change kdump to allocate ZONE_DMA32 but this one
> > may also be small as it lost 1GB to ZONE_DMA. However, the kdump kernel
> > would need to be rebuilt without ZONE_DMA since it won't have any. IIRC
> > (it's been a while since I looked), the kdump allocation couldn't span
> > multiple zones.
> >=20
> > In a separate thread, we try to fix kdump to use allocations above 4G a=
s
> > a fallback but this only fixes platforms with enough RAM (and maybe it'=
s
> > only those platforms that care about kdump).
> >=20
>=20
> One thing that strikes me as odd is that we are applying the same
> shifting logic to ZONE_DMA as we are applying to ZONE_DMA32, i.e., if
> DRAM starts outside of the zone, it is shifted upwards.
>=20
> On a typical ARM box, this gives me
>=20
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
> [    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000000fffffffff]
>=20
> i.e., the 30-bit addressable range has bit 31 set, which is weird.

Yes I agree it's weird, and IMO plain useless. I sent a series this summer =
to
address this[1], which ultimately triggered the discussion we're having rig=
ht
now.

Although with with your latest patch and the DT counterpart, we should be O=
K.
It would be weird for a HW description to define DMA constraints that are
impossible to reach on that system.

> I wonder if it wouldn't be better (and less problematic in the general
> case) to drop this logic for ZONE_DMA, and simply let it remain empty
> unless there is really some memory there.

=46rom my experience, you can't have empty ZONE_DMA when enabled. Empty
ZONE_DMA32 is OK though. Although I'm sure it's something that can be chang=
ed.

Regards,
Nicolas

[1] https://lkml.org/lkml/2020/8/19/1022



--=-qkulNlIkIv1qKYpoJFMk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+Bkp8ACgkQlfZmHno8
x/4HlwgAg+SxWz4q20kCmC4ZyKgZB1vQ1FPqNlfr3c+mE9y3v4chake0ZAe/Nvun
bMlo04GRPutBFWflDzLSbnagQjBgv8J1nmIYPdrlYFYMRPSIm/lDPwRnhas+N5Ig
Qx6P9sx+zhx4cXsLsSTOwueZoEvl6d7RAirq7H8PIjxGobQQ/lvRGGvQ18Rb57m1
2AE/iIiyVf6kp47STUlfk3iRjxYUjwu0P9vqyiRutle2Gk/bCY5vghD2qzrowhMg
Dx9ZOICuom2mThtLThOlfBopsVbKMWJDAlzbiC6oJPO+Z2ERrP70MGU48DK0WYn4
CpWueu0wvWdi6CWYpIyKErMPl/7kcg==
=HBry
-----END PGP SIGNATURE-----

--=-qkulNlIkIv1qKYpoJFMk--

