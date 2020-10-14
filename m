Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200FB28DFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgJNLew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:34:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbgJNLev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:34:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2D19ADCC;
        Wed, 14 Oct 2020 11:34:48 +0000 (UTC)
Message-ID: <3023eb53ffd2afd8c6c0755af825e426e109cbc2.camel@suse.de>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        iommu@lists.linux-foundation.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Wed, 14 Oct 2020 13:34:47 +0200
In-Reply-To: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
         <20201010151235.20585-3-nsaenzjulienne@suse.de>
         <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3FpJRYmVjKizmPf2oMLX"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3FpJRYmVjKizmPf2oMLX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-10-11 at 09:47 +0200, Ard Biesheuvel wrote:
> Hi Nicolas,
>=20
> $SUBJECT is out of sync with the patch below. Also, for legibility, it
> helps if the commit log is intelligible by itself, rather than relying
> on $SUBJECT being the first line of the first paragraph.

Noted, I'll update all commit logs.

> On Sat, 10 Oct 2020 at 17:12, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > The function provides the CPU physical address addressable by the most
> > constrained bus in the system. It might be useful in order to
> > dynamically set up memory zones during boot.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/of.h   |  7 +++++++
> >  2 files changed, 41 insertions(+)
> >=20
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index eb9ab4f1e80b..755e97b65096 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, con=
st struct bus_dma_region **map)
> >  }
> >  #endif /* CONFIG_HAS_DMA */
> >=20
> > +/**
> > + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> > + *
> > + * Gets the CPU physical address limit for safe DMA addressing system =
wide by
> > + * searching for the most constraining dma-range. Otherwise it returns=
 ~0ULL.
> > + */
> > +u64 __init of_dma_safe_phys_limit(void)
>=20
> I don't think 'safe' strikes the right tone here. You are looking for
> the highest CPU address that is addressable by all DMA masters in the
> system.
>=20
> Something like
>=20
> of_dma_get_max_cpu_address(void)
>=20
> perhaps? Also, since this is generic code, phys_addr_t is probably a
> better type to return.

Sonds good to me, I dindn't like the name I used either.

Will use with phys_addr_t.

Regards,
Nicolas


--=-3FpJRYmVjKizmPf2oMLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+G4lcACgkQlfZmHno8
x/4+2Qf9GAEy2PCZfqL+CKXSci2Q9BU2ykIHZgeZZn6AKWxXV1hrFjie5271Jnmr
ivJ/+EIhJoKSrjOPHETRjSc8vVjYIrZsdJPZjHgiGd7VTCnrER1elr6bUeN0r/LK
4Pk4htI6qYa+qm1olPEV1uG3ZzTFx+STdQnXnDl3CizOdzlSkitgos1bjylAmCVU
UzyQrqA5JQnlmM0DxoJj7gq9DeDpV85cjfngrW6Iq0KJP1iM1NflNW5hMHcL6k/m
a/ykOok8q2IgO4Sv0I2mCn2T/eDieQxGA/ksRjyqwPdbGLTAULFURU01xD2DJsj3
Jj5PawT49NznUrRDddcdpBtXBJ0CKQ==
=O9H3
-----END PGP SIGNATURE-----

--=-3FpJRYmVjKizmPf2oMLX--

