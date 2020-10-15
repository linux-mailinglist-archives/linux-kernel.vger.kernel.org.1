Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3C28EF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbgJOJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:51:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388789AbgJOJvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:51:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22A4FB228;
        Thu, 15 Oct 2020 09:51:30 +0000 (UTC)
Message-ID: <165ca8621058696f7df8e8f894cf647b3171d6fd.camel@suse.de>
Subject: Re: [PATCH v3 4/8] of: unittest: Add test for
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
Date:   Thu, 15 Oct 2020 11:51:28 +0200
In-Reply-To: <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
         <20201014191211.27029-5-nsaenzjulienne@suse.de>
         <CAL_JsqLC5vAnPjCrr4H3ik_Gh_7vW6+uzyrnjd8WnDxtwypgyQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X8qOX67+76GtlnxqUBk7"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X8qOX67+76GtlnxqUBk7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-14 at 17:04 -0500, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
> > data as the rest of dma-ranges unit tests.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/of/unittest.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 06cc988faf78..2cbf2a585c9f 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -869,6 +869,25 @@ static void __init of_unittest_changeset(void)
> >  #endif
> >  }
> >=20
> > +static void __init of_unittest_dma_get_max_cpu_address(void)
> > +{
> > +#ifdef CONFIG_HAS_DMA
>=20
> Can't the unittest run without this? I run the unittests under UML.

It was cargo culted from its sibling of_unittest_dma_ranges_one(), now that=
 you
mention it, I can't seem to find the reason why it's here in the first plac=
e,
nor for other similar usages in OF code.

I ran the test in UML with all HAS_DMA conditionals removed from OF code an=
d
things went well. I'll prepare a fix for that.

> > +       struct device_node *np;
> > +       phys_addr_t cpu_addr;
> > +
> > +       np =3D of_find_node_by_path("/testcase-data/address-tests");
> > +       if (!np) {
> > +               pr_err("missing testcase data\n");
> > +               return;
> > +       }
> > +
> > +       cpu_addr =3D of_dma_get_max_cpu_address(np);
> > +       unittest(cpu_addr =3D=3D 0x50000000ULL,
> > +                "of_dma_get_max_cpu_address: wrong CPU addr %pad (expe=
cting %llx)\n",
> > +                &cpu_addr, 0x50000000ULL);
> > +#endif
> > +}
> > +
> >  static void __init of_unittest_dma_ranges_one(const char *path,
> >                 u64 expect_dma_addr, u64 expect_paddr)
> >  {
> > @@ -3266,6 +3285,7 @@ static int __init of_unittest(void)
> >         of_unittest_changeset();
> >         of_unittest_parse_interrupts();
> >         of_unittest_parse_interrupts_extended();
> > +       of_unittest_dma_get_max_cpu_address();
> >         of_unittest_parse_dma_ranges();
> >         of_unittest_pci_dma_ranges();
> >         of_unittest_match_node();
> > --
> > 2.28.0
> >=20


--=-X8qOX67+76GtlnxqUBk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IG6AACgkQlfZmHno8
x/4LMAf/QcDwrq8xC+sEW6qMg3hpF9bfJCqcr+hehJmADyEcCDmz8TevhzumZXeM
RtlVB67o7Z2bAeSpOqTlQGQHYLdWu3zZ+Zqu0PRjUdQ6CE1l9qzLj1TSIME93HrV
kSSiqWLmOlbyISGAb1pFKbzsVqIX4t+Zn6CuH+BBLl4YimWi0Fj2aCNXSobo/K9J
aOkm5VtaIWCYbrv44+KHzpP+pJZIPl0Ya0NOzH2c2YgmL7nj7meneGEWaiRX7p8d
A/5dnYZRj/HJ+VOYW36zDfzsp5nHZxJVMXG76QJYFSleD36Skl2IyjfYQS+XwMEb
rKyrJ54T41B/RpMYjTMKcmO+x/BUMQ==
=Nev7
-----END PGP SIGNATURE-----

--=-X8qOX67+76GtlnxqUBk7--

