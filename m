Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693C628EED3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgJOIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:54:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbgJOIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0BDEAEC2;
        Thu, 15 Oct 2020 08:54:12 +0000 (UTC)
Message-ID: <de5e33352782331cf0a6ee32c1c8c6bdfe20b6af.camel@suse.de>
Subject: Re: [PATCH v3 3/8] of/address: Introduce
 of_dma_get_max_cpu_address()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org
Date:   Thu, 15 Oct 2020 10:54:11 +0200
In-Reply-To: <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-4-nsaenzjulienne@suse.de>
         <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YUQJ5U+i4xNz/NZrjBJR"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YUQJ5U+i4xNz/NZrjBJR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-14 at 17:02 -0500, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> > physical address addressable by all DMA masters in the system. It's
> > specially useful for setting memory zones sizes at early boot time.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---

[...]

> > +       struct of_range_parser parser;
> > +       phys_addr_t subtree_max_addr;
> > +       struct device_node *child;
> > +       phys_addr_t cpu_end =3D 0;
> > +       struct of_range range;
> > +       const __be32 *ranges;
> > +       int len;
> > +
> > +       if (!np)
> > +               np =3D of_root;
> > +
> > +       ranges =3D of_get_property(np, "dma-ranges", &len);
>=20
> I'm not really following why you changed the algorithm here. You're
> skipping disabled nodes which is good. Was there some other reason?

Yes, it's a little more complex. But I had to change it in order to be able=
 to
start parsing down from an arbitrary device node, which is needed for the u=
nit
tests.

for_each_of_allnodes() and friends will traverse the whole tree, regardless=
 of
the starting point. I couldn't find a similar function that would just iter=
ate
over a subsection of the tree, so I went with this recursive approach.

Regards,
Nicolas


--=-YUQJ5U+i4xNz/NZrjBJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IDjMACgkQlfZmHno8
x/7rjAf+KrPaZm2zT8XfzDn5CDIf7492No2jTgiouPN9YLIyCBwWqNc3j9ApACr0
Boxl6eP0BL49yAtVQJz+hq86/9a1TTbqs+xj1mdUG0KruCrKQvSm8sd8DexTFBaV
zw7F1cvFs6HgYqAmNfK5ybVBoDy1Br0LVK5E05S2baUkID/HZDVSGEwhS3FSaRQP
WcMPbmIvPgxNg1/Tk16wi9rX2FToZCJymwwil45nHAFnc4hSsudcTHFmX4Td8J01
jd51b5qeWQ1mX3LY7a4xo0YiR18m69VB0ToPRpQKQvAb24nxMatXip9NtseykiQs
4jVbFSQAT/FxsnzgjJRMVHJOBZFvAQ==
=1G9v
-----END PGP SIGNATURE-----

--=-YUQJ5U+i4xNz/NZrjBJR--

