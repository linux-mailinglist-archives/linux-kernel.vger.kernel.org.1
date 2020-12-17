Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845792DD354
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgLQOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:54:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:42884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgLQOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:54:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82032AC90;
        Thu, 17 Dec 2020 14:53:44 +0000 (UTC)
Message-ID: <289bb62c166c86e9a89649650f38c6c11a1b4bbd.camel@suse.de>
Subject: Re: [PATCH] arm64: Kconfig: select ZONE_DMA
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Date:   Thu, 17 Dec 2020 15:53:43 +0100
In-Reply-To: <20201217124323.GB15336@gaia>
References: <20201217080802.29023-1-peng.fan@oss.nxp.com>
         <93832374535cb46419e921f5ee02ecabfe2cc83d.camel@suse.de>
         <20201217124323.GB15336@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-O+xhLPMi0z3DYDhuQ6rL"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O+xhLPMi0z3DYDhuQ6rL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-17 at 12:43 +0000, Catalin Marinas wrote:
> On Thu, Dec 17, 2020 at 09:44:31AM +0100, Nicolas Saenz Julienne wrote:
> > On Thu, 2020-12-17 at 16:08 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >=20
> > > ZONE_DMA should not be disabled, otherwise arm64_dma_phys_limit is
> > > left uninitialized and cause swiotlb have IO TLB above 4GB which
> > > might crash some platforms
>=20
> Actually, arm64_dma_phys_limit would be zero-initialised. The
> ARCH_LOW_ADDRESS_LIMIT becomes ~0UL, hence it covers the whole address
> space.
>=20
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >=20
> > > Not sure whether need to address code to initialize the variables or
> > > force select ZONE_DMA
> >=20
> > What is the cause for the swiotlb related crashes? I assume it's DMA in=
to an
> > address too high for the bus, but it might be something else.
>=20
> I think that's the case, swiotlb is not within the low 32-bit of the
> address space.
>=20
> > I figure you have a setup with ZONE_DMA32, ZONE_NORMAL and !ZONE_DMA.
> >=20
> > First of all, I'd suggest you try arm64's defaults (all zones enabled),=
 the
> > series I mention above should fix most of the issues we've had with
> > ZONE_DMA/ZONE_DMA32 in the past. We now parse DT/ACPI and only create t=
wo
> > distinct DMA zones if really needed. Otherwise ZONE_DMA spans the whole=
 32 bit
> > address space.
> >=20
> > That said, IMO we're not doing the right thing in the !ZONE_DMA && ZONE=
_DMA32
> > case, and this should fix it (I didn't test it):
> >=20
> > - #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
> > + #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit ? : arm64_dma32_=
phys_limit)
>=20
> Does this limit need to be inclusive?

Yes, I'm missing a '- 1'.

I'll send a fix if there is no further push back/comments.

Regards,
Nicolas


--=-O+xhLPMi0z3DYDhuQ6rL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/bcPcACgkQlfZmHno8
x/4sVgf+KVIFmmnUuBOaVUJsFT03XtuQoFr0KYE4FlKWvoJ9qudbyj1xrWdG4r1o
zJoElvOSKrVaDhvDkqrSQoP0zoUrpN6tcxf5g9HPTXDfhVqNVJfuJ4DHii83w8w1
AsCw++MxF94UDwNkTwCwdqbcTgo/l+9fdzfEXwpkgKFI8Q6gphE9PzahhJDFhb0u
BiVSzX9T7ATzDXkyTtxpXnas9R8CPHf5iR5wFNOZplPAFJalCYfTcdwvbMJjvRA9
XjQIw6500zMaz+L6+FwXoBK7mg/2EGlOXySuzBBCoktbgZNnlUZ1EEx8ap0RhQNF
H+Dn1EvKiJVfK00ycwXfG2QEP7btxw==
=HC2u
-----END PGP SIGNATURE-----

--=-O+xhLPMi0z3DYDhuQ6rL--

